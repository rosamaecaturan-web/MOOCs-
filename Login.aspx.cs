using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Net.Mail;
using System.Net;


namespace MOOCs
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtLoginId.Attributes["placeholder"] = "Email";
            }

            if (Request.QueryString["logout"] == "true")
            {
                Session.Clear();
                Session.Abandon();
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            Response.Redirect("Signup.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string loginInput = txtLoginId.Text.Trim();
            string passwordInput = txtPassword.Text.Trim();
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // ✅ FIXED QUERY: Faculty uses faculty_code ONLY
                    string query = @"
            SELECT user_id, role, password, email, faculty_id_code
            FROM tbl_users
            WHERE 
                (role = 'faculty' AND BINARY faculty_id_code = @Input)
                OR
                (role <> 'faculty' AND BINARY email = @Input)";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Input", loginInput);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (!reader.Read())
                            {
                                ShowMessage("Account not found. Please check your login credentials.");
                                return;
                            }

                            string role = reader["role"].ToString().ToLower();
                            string storedPassword = reader["password"].ToString();

                            // ✅ PASSWORD CHECK
                            if (!VerifyPassword(passwordInput, storedPassword))
                            {
                                ShowMessage("Incorrect password.");
                                return;
                            }

                            // ✅ SESSION SETUP
                            Session["userId"] = Convert.ToInt32(reader["user_id"]);
                            Session["role"] = role;
                            Session["Email"] = reader["email"].ToString();

                            // ✅ ROLE REDIRECTION
                            if (role == "admin")
                                Response.Redirect("Admin.aspx");
                            else if (role == "faculty")
                                Response.Redirect("Faculty.aspx");
                            else
                                Response.Redirect("Home.aspx");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Database error: " + ex.Message);
            }
        }

        // ------------------------- Forgot Password & OTP -------------------------

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            string email = txtForgotEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {


                ShowNotification("Invalid OTP.", "error");
                stepEmail.Visible = false;
                stepOTP.Visible = true;
                return;
               
               
            }


            // TODO: check if email exists in DB (naa na ka ani)

            // Generate OTP
            Random rnd = new Random();
            string otp = rnd.Next(100000, 999999).ToString();

            Session["ForgotPasswordOTP"] = otp;
            Session["ForgotPasswordEmail"] = email;
            Session["ForgotPasswordOTPTime"] = DateTime.Now;

            // Send email
            SendOTPEmail(email, otp);

            // 🔥 IMPORTANT PART
            stepEmail.Visible = false;
            stepOTP.Visible = true;

            ShowNotification("OTP has been sent to your email.", "success");
        }

        protected void btnResendOTP_Click(object sender, EventArgs e)
        {
            string email = (string)Session["ForgotPasswordEmail"];
            if (string.IsNullOrEmpty(email))
            {
                ShowNotification("Email session expired. Please start over.", "error");
                stepOTP.Style["display"] = "none";
                stepEmail.Style["display"] = "block";
                return;
            }

            Random rnd = new Random();
            string otp = rnd.Next(100000, 999999).ToString();
            Session["ForgotPasswordOTP"] = otp;
            Session["ForgotPasswordOTPTime"] = DateTime.Now;

            try
            {
                SendOTPEmail(email, otp);
                ShowNotification("A new OTP has been sent to your email.", "success");
            }
            catch
            {
                ShowNotification("Failed to send OTP. Please try again later.", "error");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string enteredOTP = txtOTP.Text.Trim();
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmNewPassword.Text;

            if (string.IsNullOrEmpty(enteredOTP) || string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                ShowNotification("Please fill in all fields.", "error");
                return;
            }

            if (Session["ForgotPasswordOTP"] == null || Session["ForgotPasswordOTPTime"] == null || Session["ForgotPasswordEmail"] == null)
            {
                ShowNotification("OTP session expired. Please start over.", "error");
                stepOTP.Style["display"] = "none";
                stepEmail.Style["display"] = "block";
                return;
            }

            DateTime otpTime = (DateTime)Session["ForgotPasswordOTPTime"];
            if (DateTime.Now.Subtract(otpTime).TotalMinutes > 5)
            {
                ShowNotification("OTP has expired. Please resend OTP.", "error");
                return;
            }

            if (enteredOTP != (string)Session["ForgotPasswordOTP"])
            {
                ShowNotification("Invalid OTP. Please check your email.", "error");
                return;
            }

            if (newPassword != confirmPassword)
            {
                ShowNotification("Passwords do not match.", "error");
                return;
            }

            bool isStrongPassword = System.Text.RegularExpressions.Regex.IsMatch(
                newPassword,
                @"^(?=.*\d)(?=.*[^\w\s]).{8,}$"
            );
            if (!isStrongPassword)
            {
                ShowNotification("Password must be at least 8 characters long and contain at least one number and one special character.", "error");
                return;
            }

            string email = (string)Session["ForgotPasswordEmail"];
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string query = "UPDATE tbl_users SET password = @Password WHERE email = @Email";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        string hashedPassword = HashPassword(newPassword);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);
                        cmd.Parameters.AddWithValue("@Email", email);
                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            Session.Remove("ForgotPasswordOTP");
                            Session.Remove("ForgotPasswordEmail");
                            Session.Remove("ForgotPasswordOTPTime");

                            txtNewPassword.Text = "";
                            txtConfirmNewPassword.Text = "";
                            txtOTP.Text = "";

                            ShowNotification("✅ Your password has been updated successfully.", "success");

                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "CloseForgotModal",
                                "$('#forgotPasswordModal').modal('hide');",
                                true
                            );
                        }
                        else
                        {
                            ShowNotification("Something went wrong. Please try again.", "error");
                        }
                    }
                }
            }
            catch
            {
                ShowNotification("Something went wrong. Please try again later.", "error");
            }
        }

    

        private void SendOTPEmail(string toEmail, string otp)
        {
            MailMessage mail = new MailMessage();

            mail.From = new MailAddress("MOOCsweb1@gmail.com");
            mail.To.Add(toEmail);
            mail.Subject = "Your OTP Code";
            mail.Body = $"Your OTP for password reset is: {otp}";
            SmtpClient smtp = new SmtpClient("smtp.gmail.com");
            smtp.Port = 587; 
            smtp.Credentials = new NetworkCredential("MOOCsweb1@gmail.com", "fiiqvqbowjrrblon");
            smtp.EnableSsl = true; 

       
            smtp.Send(mail);
        }


        private void ShowNotification(string message, string type)
        {
            string bgColor = type == "success" ? "#4CAF50" : "#f44336";

            string script = $@"
        var notif = document.createElement('div');
        notif.innerHTML = '{message}';
        notif.style.position = 'fixed';
        notif.style.top = '20px';
        notif.style.right = '20px';
        notif.style.backgroundColor = '{bgColor}';
        notif.style.color = 'white';
        notif.style.padding = '15px 20px';
        notif.style.borderRadius = '5px';
        notif.style.zIndex = 9999;
        notif.style.boxShadow = '0 2px 10px rgba(0,0,0,0.2)';
        document.body.appendChild(notif);
        setTimeout(function() {{
            notif.remove();
        }}, 4000);";

            ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }

        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }

        private bool VerifyPassword(string enteredPassword, string storedHash)
        {
            byte[] hashBytes = Convert.FromBase64String(storedHash);
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);

            var pbkdf2 = new Rfc2898DeriveBytes(enteredPassword, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);

            for (int i = 0; i < 20; i++)
                if (hashBytes[i + 16] != hash[i])
                    return false;

            return true;
        }

        private string HashPassword(string password)
        {
            byte[] salt = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);

            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);

            return Convert.ToBase64String(hashBytes);
        }
    }
}
