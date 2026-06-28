using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace MOOCs
{
    public partial class FA : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                ClientScript.RegisterStartupScript(this.GetType(), "showFields", "showFields();", true);
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            string role = ddlRole.SelectedValue;
            string name = fullName.Text.Trim();
            string emailInput = email.Text.Trim();
            string passwordInput = password.Text;
            string confirmPwd = confirmPassword.Text;

            if (string.IsNullOrEmpty(role))
            {
                ShowMessage("Please select a role.");
                return;
            }

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(emailInput) ||
                string.IsNullOrEmpty(passwordInput) || string.IsNullOrEmpty(confirmPwd))
            {
                ShowMessage("Please fill in all required fields.");
                return;
            }

            if (passwordInput != confirmPwd)
            {
                ShowMessage("Passwords do not match.");
                return;
            }

            string hashedPassword = HashPassword(passwordInput);

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // Check for duplicate email
                    string checkQuery = role == "faculty"
                        ? "SELECT COUNT(*) FROM tbl_faculty WHERE email=@Email OR faculty_id=@ID"
                        : "SELECT COUNT(*) FROM tbl_admin WHERE email=@Email OR admin_id=@ID";

                    string id = role == "faculty" ? facultyId.Text.Trim() : adminId.Text.Trim();

                    using (MySqlCommand cmdCheck = new MySqlCommand(checkQuery, conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@Email", emailInput);
                        cmdCheck.Parameters.AddWithValue("@ID", id);
                        long exists = (long)cmdCheck.ExecuteScalar();
                        if (exists > 0)
                        {
                            ShowMessage("Email or ID already exists.");
                            return;
                        }
                    }

                    if (role == "faculty")
                    {
                        string facultyID = facultyId.Text.Trim();
                        if (string.IsNullOrEmpty(facultyID))
                        {
                            ShowMessage("Please enter Faculty ID.");
                            return;
                        }

                        string query = "INSERT INTO tbl_faculty (faculty_id, full_name, email, password) " +
                                       "VALUES (@FacultyID, @FullName, @Email, @Password)";
                        using (MySqlCommand cmd = new MySqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@FacultyID", facultyID);
                            cmd.Parameters.AddWithValue("@FullName", name);
                            cmd.Parameters.AddWithValue("@Email", emailInput);
                            cmd.Parameters.AddWithValue("@Password", hashedPassword);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else // admin
                    {
                        string adminID = adminId.Text.Trim();
                        string query = "INSERT INTO tbl_admin (admin_id, full_name, email, password) " +
                                       "VALUES (@AdminID, @FullName, @Email, @Password)";
                        using (MySqlCommand cmd = new MySqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@AdminID", adminID);
                            cmd.Parameters.AddWithValue("@FullName", name);
                            cmd.Parameters.AddWithValue("@Email", emailInput);
                            cmd.Parameters.AddWithValue("@Password", hashedPassword);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    ShowMessage("Registration successful!", true);
                    ClearFields();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message);
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                    builder.Append(b.ToString("x2"));
                return builder.ToString();
            }
        }

        private void ShowMessage(string message, bool success = false)
        {
            string script = string.Format("alert('{0}');", message);
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        private void ClearFields()
        {
            fullName.Text = "";
            email.Text = "";
            password.Text = "";
            confirmPassword.Text = "";
            facultyId.Text = "";
            ddlRole.SelectedIndex = 0;
            ClientScript.RegisterStartupScript(this.GetType(), "showFields", "showFields();", true);
        }
    }
}
