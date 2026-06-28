using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace MOOCs
{
    public partial class F___A_Signup : System.Web.UI.Page
    {
        // Replace with your MySQL connection string
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
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
                    else if (role == "admin")
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

                    ShowMessage("Registration successful!", success: true);
                    ClearFields();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message);
            }
        }

        // Hash password using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void ShowMessage(string message, bool success = false)
        {
            // Use a Label or JavaScript alert for now
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{message}');", true);
        }

        private void ClearFields()
        {
            fullName.Text = "";
            email.Text = "";
            password.Text = "";
            confirmPassword.Text = "";
            facultyId.Text = "";
            ddlRole.SelectedIndex = 0;
            // Hide dynamic fields
            ClientScript.RegisterStartupScript(this.GetType(), "hideFields", "showFields();", true);
        }
    }
}
