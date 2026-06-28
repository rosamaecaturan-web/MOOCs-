using System;
using System.Net;
using System.Net.Mail;

namespace MOOCs
{
    public partial class Forgotpassword : System.Web.UI.Page
    {
        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            if (email == "")
            {
                lblMessage.Text = "❌ Please enter your email.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            // Generate OTP
            Random rnd = new Random();
            string otp = rnd.Next(100000, 999999).ToString();
            Session["OTP"] = otp;
            Session["OTP_Email"] = email;

            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("yourgmail@gmail.com");
                mail.To.Add(email);
                mail.Subject = "Your OTP Code";
                mail.Body = $"Your OTP is: {otp}\n\nDo not share this code.";

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("yourgmail@gmail.com", "APP_PASSWORD");
                smtp.EnableSsl = true;
                smtp.Send(mail);

                lblMessage.Text = "✅ OTP sent to your email.";
                lblMessage.CssClass = "text-success";
                pnlOTP.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Failed to send OTP.";
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            if (txtOTP.Text == Session["OTP"]?.ToString())
            {
                Response.Redirect("ResetPassword.aspx");
            }
            else
            {
                lblMessage.Text = "❌ Invalid OTP.";
                lblMessage.CssClass = "text-danger";
            }
        }
    }
}
