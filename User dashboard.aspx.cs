using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.IO;
using System.Web.UI;

namespace MOOCs
{
    public partial class User_dashboard : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserInfo();
            }
        }

        private void LoadUserInfo()
        {
            string userId = Session["user_id"]?.ToString();
            if (string.IsNullOrEmpty(userId)) return;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT first_name, role, profile_pic FROM tbl_users WHERE user_id = @user_id";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblFullName.Text = reader["first_name"].ToString();
                            lblRole.Text = reader["role"].ToString();

                            string profilePic = reader["profile_pic"].ToString();
                            if (!string.IsNullOrEmpty(profilePic))
                                imgProfilePic.ImageUrl = "~/uploads/" + profilePic;
                            else
                                imgProfilePic.ImageUrl = "~/uploads/default.png"; // fallback image
                        }
                    }
                }
            }
        }

        protected void btnUploadPic_Click(object sender, EventArgs e)
        {
            if (fuProfilePic.HasFile)
            {
                try
                {
                    string userId = Session["user_id"]?.ToString();
                    if (string.IsNullOrEmpty(userId))
                    {
                        lblUploadMessage.Text = "⚠ User not logged in.";
                        return;
                    }

                    string fileExtension = Path.GetExtension(fuProfilePic.FileName).ToLower();
                    if (fileExtension != ".png" && fileExtension != ".jpg" && fileExtension != ".jpeg")
                    {
                        lblUploadMessage.Text = "⚠ Only PNG or JPG files are allowed.";
                        return;
                    }

                    string uploadFolder = Server.MapPath("~/uploads/");
                    if (!Directory.Exists(uploadFolder))
                        Directory.CreateDirectory(uploadFolder);

                    string uniqueFileName = $"{Guid.NewGuid()}{fileExtension}";
                    string filePath = Path.Combine(uploadFolder, uniqueFileName);
                    fuProfilePic.SaveAs(filePath);

                    // Update database
                    using (MySqlConnection conn = new MySqlConnection(connStr))
                    {
                        conn.Open();
                        string query = "UPDATE tbl_users SET profile_pic = @profile_pic WHERE user_id = @user_id";
                        using (MySqlCommand cmd = new MySqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@profile_pic", uniqueFileName);
                            cmd.Parameters.AddWithValue("@user_id", userId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Update the displayed image
                    imgProfilePic.ImageUrl = "~/uploads/" + uniqueFileName;
                    lblUploadMessage.Text = "✅ Profile picture updated!";
                }
                catch (Exception ex)
                {
                    lblUploadMessage.Text = "❌ Error: " + ex.Message;
                }
            }
            else
            {
                lblUploadMessage.Text = "⚠ Please select a picture first.";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string userId = Session["user_id"]?.ToString();
            if (string.IsNullOrEmpty(userId)) return;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = @"UPDATE tbl_users 
                                 SET first_name = @first_name, last_name = @last_name, 
                                     email = @email, phone = @phone, bio = @bio 
                                 WHERE user_id = @user_id";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@first_name", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@last_name", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@bio", txtBio.Text.Trim());
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    cmd.ExecuteNonQuery();
                }
            }

            // Refresh UI
            lblFullName.Text = txtFirstName.Text + " " + txtLastName.Text;
            lblMessage.Text = "✅ Profile updated!";
        }

        

    }
}
