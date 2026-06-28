using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace MOOCs
{
    public partial class Signup : Page
    {
        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;

            string firstNameInput = firstName.Text.Trim();
            string lastNameInput = lastName.Text.Trim();
            string emailInput = email.Text.Trim();
            string passwordInput = password.Text;
            string confirmPasswordInput = confirmPassword.Text;
            string role = ddlRole.SelectedValue;
            string facultyAccessCodeInput = facultyId.Text.Trim();

            // ================= REQUIRED FIELDS =================
            if (string.IsNullOrEmpty(firstNameInput) ||
                string.IsNullOrEmpty(lastNameInput) ||
                string.IsNullOrEmpty(emailInput) ||
                string.IsNullOrEmpty(passwordInput) ||
                string.IsNullOrEmpty(confirmPasswordInput) ||
                string.IsNullOrEmpty(role))
            {
                ShowMessage("⚠ Please fill in all required fields.");
                return;
            }

            // ================= NAME VALIDATION =================
            if (!Regex.IsMatch(firstNameInput, @"^[A-Za-z]+$") ||
                !Regex.IsMatch(lastNameInput, @"^[A-Za-z]+$"))
            {
                ShowMessage("⚠ First Name and Last Name must contain letters only.");
                return;
            }

            // ================= PASSWORD MATCH =================
            if (passwordInput != confirmPasswordInput)
            {
                ShowMessage("⚠ Passwords do not match.");
                return;
            }

            // ================= PASSWORD STRENGTH =================
            if (!Regex.IsMatch(passwordInput, @"^(?=.*\d)(?=.*[@$!%*_?&]).{8,}$"))
            {
                ShowMessage("Opss! Your password is weak. Make sure it has at least 8 characters, includes numbers and special characters.  \r\nExample: MyPass123!.");
                return;
            }

            // ================= STUDENT EMAIL RULE =================
            if (role == "student")
            {
                string emailLower = emailInput.ToLower();
                if (!(emailLower.EndsWith("@gmail.com") || emailLower.EndsWith("@spamast.edu.ph")))
                {
                    ShowMessage("❌ Students must use Gmail or SPAMAST email.");
                    return;
                }
            }

            // ================= ADMIN BLOCK =================
            if (role == "admin")
            {
                ShowMessage("⚠ Admins cannot sign up here.");
                Response.Redirect("Login.aspx");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // ================= CHECK EMAIL =================
                    string checkEmailQuery = "SELECT COUNT(*) FROM tbl_users WHERE email=@Email";
                    using (MySqlCommand cmdCheck = new MySqlCommand(checkEmailQuery, conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@Email", emailInput);
                        int count = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        if (count > 0)
                        {
                            ShowMessage("⚠ Email is already registered.");
                            return;
                        }
                    }

                    string insertQuery = @"
            INSERT INTO tbl_users
            (first_name, last_name, email, password, role, faculty_id_code, phone, bio, profile_pic, status, created_at)
            VALUES
            (@FirstName, @LastName, @Email, @Password, @Role, @FacultyIdCode, @Phone, @Bio, @ProfilePic, @Status, @CreatedAt)";

                    using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", firstNameInput);
                        cmd.Parameters.AddWithValue("@LastName", lastNameInput);
                        cmd.Parameters.AddWithValue("@Email", emailInput);
                        cmd.Parameters.AddWithValue("@Password", HashPassword(passwordInput));
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@CreatedAt", DateTime.UtcNow);

                        string generatedID = "";
                        string status = "approved"; // default for students

                        if (role == "faculty")
                        {
                            const string facultyAccessCode = "FACULTYKEY2025";
                            if (facultyAccessCodeInput != facultyAccessCode)
                            {
                                ShowMessage("❌ Invalid faculty secret code.");
                                return;
                            }

                            // Generate Faculty ID but do not display yet
                            generatedID = "FAC" + GenerateFacultyCode(5);
                            cmd.Parameters.AddWithValue("@FacultyIdCode", generatedID);

                            status = "pending"; // faculty pending admin approval
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@FacultyIdCode", DBNull.Value);
                        }

                        cmd.Parameters.AddWithValue("@Phone", "");
                        cmd.Parameters.AddWithValue("@Bio", "");
                        cmd.Parameters.AddWithValue("@ProfilePic", "default.png");
                        cmd.Parameters.AddWithValue("@Status", status);

                        int rows = cmd.ExecuteNonQuery();


                        if (rows > 0)
                        {
                            int userId;

                            // GET LAST INSERTED USER ID
                            using (MySqlCommand cmdGetId = new MySqlCommand("SELECT LAST_INSERT_ID()", conn))
                            {
                                userId = Convert.ToInt32(cmdGetId.ExecuteScalar());
                            }

                            if (role == "faculty")
                            {
                                // ================= INSERT INTO tbl_faculty =================
                                string insertFacultyQuery = @"
        INSERT INTO tbl_faculty
        (Email, Password, first_name, last_name, user_id, created_at)
        VALUES
        (@Email, @Password, @FirstName, @LastName, @UserId, @CreatedAt)";

                                using (MySqlCommand cmdFaculty = new MySqlCommand(insertFacultyQuery, conn))
                                {
                                    cmdFaculty.Parameters.AddWithValue("@Email", emailInput);
                                    cmdFaculty.Parameters.AddWithValue("@Password", HashPassword(passwordInput)); // same hash
                                    cmdFaculty.Parameters.AddWithValue("@FirstName", firstNameInput);
                                    cmdFaculty.Parameters.AddWithValue("@LastName", lastNameInput);
                                    cmdFaculty.Parameters.AddWithValue("@UserId", userId);
                                    cmdFaculty.Parameters.AddWithValue("@CreatedAt", DateTime.UtcNow);

                                    cmdFaculty.ExecuteNonQuery();
                                }

                                // ================= FACULTY MODAL =================
                                string script = @"
        var facultyModal = new bootstrap.Modal(document.getElementById('facultyModal'));
        facultyModal.show();
        document.getElementById('facultyModalBody').innerText = 
        '✅ Signup successful! Please wait for admin approval. An email will be sent to you once approved.';
        document.getElementById('facultyModal').addEventListener('hidden.bs.modal', function () {
            window.location='Login.aspx';
        });";

                                ClientScript.RegisterStartupScript(this.GetType(), "ShowFacultyModal", script, true);
                                btnSignUp.Enabled = false;
                            }
                            else
                            {
                                // ================= STUDENT FLOW =================
                                Session["UserID"] = userId;
                                Session["Email"] = emailInput;
                                Session["Role"] = role;
                                Session["FullName"] = firstNameInput + " " + lastNameInput;

                                ClientScript.RegisterStartupScript(this.GetType(),
                                    "RedirectAfterSignup",
                                    $"setTimeout(function(){{ window.location='Student page.aspx'; }}, 1200);",
                                    true);
                            }
                        }

                        else
                        {
                            ShowMessage("❌ Signup failed. Please try again.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Database error: " + ex.Message);
            }
        }

        // ================= ERROR MESSAGE =================
        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
            lblMessage.Style["color"] = "red";
            lblMessage.Visible = true;
        }

     

        // ================= FACULTY CODE GENERATOR =================
        private string GenerateFacultyCode(int length)
        {
            const string chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
            char[] result = new char[length];
            byte[] buffer = new byte[length];

            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(buffer);
            }

            for (int i = 0; i < length; i++)
                result[i] = chars[buffer[i] % chars.Length];

            return new string(result);
        }

        // ================= PASSWORD HASH =================
        private string HashPassword(string password)
        {
            byte[] salt = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000))
            {
                byte[] hash = pbkdf2.GetBytes(20);
                byte[] hashBytes = new byte[36];

                Array.Copy(salt, 0, hashBytes, 0, 16);
                Array.Copy(hash, 0, hashBytes, 16, 20);

                return Convert.ToBase64String(hashBytes);
            }
        }

        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRole.SelectedValue == "admin")
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}
