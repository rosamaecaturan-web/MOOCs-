using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class Admin : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblAdminName.Text = Session["admin_name"] != null ? Session["admin_name"].ToString() : "Admin";

                BindSummary();
                BindNewStudents();
                BindCourses();
                BindNewTeachers();
                BindStudentsWithProgress();
                BindTeachers();
             
                LoadCourseGroups();
                LoadStats();
                BindFacultyApproval();

                LoadAdminData();
            }
        }

        #region Dashboard Binds

        private void BindSummary()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                lblStudents.Text = new MySqlCommand("SELECT COUNT(*) FROM tbl_users WHERE LOWER(role)='student'", conn).ExecuteScalar()?.ToString() ?? "0";
                lblTeachers.Text = new MySqlCommand("SELECT COUNT(*) FROM tbl_users WHERE LOWER(role)='faculty'", conn).ExecuteScalar()?.ToString() ?? "0";
                lblCourse.Text = new MySqlCommand("SELECT COUNT(*) FROM tbl_course", conn).ExecuteScalar()?.ToString() ?? "0";
            }
        }
        private void LoadCourseGroups()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT DISTINCT course_code FROM tbl_course ORDER BY course_code";

                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                RepeaterCourseGroups.DataSource = dt;
                RepeaterCourseGroups.DataBind();
            }
        }


        protected void LoadAdminData(string adminID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;
            string query = "SELECT first_name, last_name, email FROM tbl_users WHERE user_id=@AdminID AND role='Admin'";

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@AdminID", adminID);
                    con.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfAdminID.Value = adminID;
                            txtFirstName.Text = reader["first_name"].ToString();
                            txtLastName.Text = reader["last_name"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                        }
                    }
                }
            }
        }

        protected void LoadAdminData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;
            string query = "SELECT user_id, first_name, last_name, email, profile_pic FROM tbl_users WHERE role='Admin' LIMIT 1";

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    con.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfAdminID.Value = reader["user_id"].ToString();
                            txtFirstName.Text = reader["first_name"].ToString();
                            txtLastName.Text = reader["last_name"].ToString();
                            txtEmail.Text = reader["email"].ToString();

                            // Display admin name
                            lblAdminName.Text = reader["first_name"].ToString() + " " + reader["last_name"].ToString();

                            // Display profile pic
                            string profilePic = reader["profile_pic"].ToString();
                            imgAdminProfile.ImageUrl = string.IsNullOrEmpty(profilePic) ? "~/uploads/profile/default.png" : profilePic;
                        }
                    }
                }
            }
        }

        protected void btnSaveAdmin_Click(object sender, EventArgs e)
        {
            string userID = hfAdminID.Value;
            string profilePicPath = null;

            // ===== HANDLE IMAGE UPLOAD =====
            if (fuProfilePic.HasFile)
            {
                string ext = Path.GetExtension(fuProfilePic.FileName).ToLower();
                string[] allowed = { ".jpg", ".jpeg", ".png", ".gif" };

                if (allowed.Contains(ext))
                {
                    string folderPath = Server.MapPath("~/uploads/profile/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = "admin_" + userID + ext;
                    string savePath = folderPath + fileName;

                    fuProfilePic.SaveAs(savePath);
                    profilePicPath = "~/uploads/profile/" + fileName;
                }
                else
                {
                    lblMessage.Text = "Invalid image format.";
                    return;
                }
            }

            // ===== BUILD QUERY DYNAMICALLY =====
            string query = @"UPDATE tbl_users SET 
                        first_name=@FirstName,
                        last_name=@LastName,
                        email=@Email";

            if (!string.IsNullOrEmpty(txtPassword.Text))
            {
                query += ", password=@Password";
            }

            if (profilePicPath != null)
            {
                query += ", profile_pic=@ProfilePic";
            }

            query += " WHERE user_id=@UserID AND role='Admin'";

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    if (!string.IsNullOrEmpty(txtPassword.Text))
                    {
                        cmd.Parameters.AddWithValue("@Password", HashPassword(txtPassword.Text.Trim()));
                    }

                    if (profilePicPath != null)
                    {
                        cmd.Parameters.AddWithValue("@ProfilePic", profilePicPath);
                    }

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rows > 0)
                    {
                        lblMessage.Text = "Admin updated successfully!";

                        lblAdminName.Text = txtFirstName.Text + " " + txtLastName.Text;

                        if (profilePicPath != null)
                        {
                            imgAdminProfile.ImageUrl = profilePicPath;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Update failed.";
                    }
                }
            }
        }

        // Example password hash
        private string HashPassword(string password)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = System.Text.Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        protected void RepeaterCourseGroups_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string courseCode = DataBinder.Eval(e.Item.DataItem, "course_code").ToString();
                Repeater rptCourses = (Repeater)e.Item.FindControl("RepeaterCourses");

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT * FROM tbl_course WHERE course_code=@code";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@code", courseCode);

                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptCourses.DataSource = dt;
                    rptCourses.DataBind();
                }
            }
        }

       

        private void LoadStats()
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                // Students count
                string studentQuery = "SELECT COUNT(*) FROM tbl_users WHERE role='Student'";
                MySqlCommand cmdStudent = new MySqlCommand(studentQuery, conn);
                lblStudents.Text = cmdStudent.ExecuteScalar().ToString();

                // Teachers count
                string teacherQuery = "SELECT COUNT(*) FROM tbl_users WHERE role='Faculty'";
                MySqlCommand cmdTeacher = new MySqlCommand(teacherQuery, conn);
                lblTeachers.Text = cmdTeacher.ExecuteScalar().ToString();

                // Courses count (optional, kung gusto i-update dinha, pero LoadCourses() naay count)
                string courseQuery = "SELECT COUNT(*) FROM tbl_course";
                MySqlCommand cmdCourse = new MySqlCommand(courseQuery, conn);
                lblCourse.Text = cmdCourse.ExecuteScalar().ToString();
            }
        }


        private void BindNewStudents()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = @"SELECT user_id AS id, CONCAT_WS(' ', first_name, last_name) AS fullname, email, profile_pic
                               FROM tbl_users WHERE LOWER(role)='student' ORDER BY user_id DESC LIMIT 6";
                DataTable dt = new DataTable();
                new MySqlDataAdapter(sql, conn).Fill(dt);
                rptNewStudents.DataSource = dt;
                rptNewStudents.DataBind();
            }
        }

        private void BindNewTeachers()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = @"SELECT user_id AS id, CONCAT_WS(' ', first_name, last_name) AS fullname, email, profile_pic
                               FROM tbl_users WHERE LOWER(role)='faculty' ORDER BY user_id DESC LIMIT 6";
                DataTable dt = new DataTable();
                new MySqlDataAdapter(sql, conn).Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    string pic = row["profile_pic"] as string;
                    row["profile_pic"] = !string.IsNullOrEmpty(pic) ? "/uploads/profile/" + pic : "/uploads/profile/default.png";
                }

                rptNewTeachers.DataSource = dt;
                rptNewTeachers.DataBind();
            }
        }

        private void BindCourses()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = @"SELECT c.id, c.course_name, c.course_description, c.course_code, u.user_id AS faculty_id
                               FROM tbl_course c LEFT JOIN tbl_users u ON c.faculty_id = u.user_id
                               ORDER BY c.id DESC LIMIT 50";
                DataTable dt = new DataTable();
                new MySqlDataAdapter(sql, conn).Fill(dt);
                rptCourses.DataSource = dt;
                rptCourses.DataBind();
            }
        }

        private void BindStudentsWithProgress()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = @"SELECT u.user_id, u.first_name, u.last_name, u.email, u.profile_pic,
                                      p.progress_id, p.course_code, p.status, p.quiz_score
                               FROM tbl_users u LEFT JOIN tbl_progress p ON u.user_id = p.user_id
                               WHERE LOWER(u.role) = 'student'
                               ORDER BY u.user_id";
                DataTable dt = new DataTable();
                new MySqlDataAdapter(sql, conn).Fill(dt);
                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        private void BindTeachers()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT user_id, first_name, last_name, role, faculty_id_code FROM tbl_users WHERE LOWER(role)='faculty'";
                DataTable dt = new DataTable();
                new MySqlDataAdapter(sql, conn).Fill(dt);
                gvTeachers.DataSource = dt;
                gvTeachers.DataBind();
            }
        }

        #endregion

        #region Faculty Approval

        private void BindFacultyApproval()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT user_id, first_name, last_name, email FROM tbl_users WHERE LOWER(role)='faculty' AND is_approved=0";
                DataTable dt = new DataTable();
                new MySqlDataAdapter(sql, conn).Fill(dt);
                gvFacultyApproval.DataSource = dt;
                gvFacultyApproval.DataBind();
            }
        }

        protected void gvFacultyApproval_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (int.TryParse(e.CommandArgument.ToString(), out int userId))
            {
                if (e.CommandName == "ApproveFaculty")
                    ApproveFaculty(userId);
                else if (e.CommandName == "IgnoreFaculty")
                    IgnoreFaculty(userId);

                BindFacultyApproval();
            }
        }

        private void IgnoreFaculty(int userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "DELETE FROM tbl_users WHERE user_id=@UserId AND LOWER(role)='faculty'";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.ExecuteNonQuery();
                }
            }

            BindTeachers();
            BindNewTeachers();
            BindSummary();
        }

        private void ApproveFaculty(int userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string facultyIdCode = "FAC" + GenerateFacultyCode(5);
                string firstName = "";
                string facultyEmail = "";

                using (MySqlCommand cmdCheck = new MySqlCommand("SELECT faculty_id_code, first_name, email FROM tbl_users WHERE user_id=@UserId AND LOWER(role)='faculty'", conn))
                {
                    cmdCheck.Parameters.AddWithValue("@UserId", userId);
                    using (MySqlDataReader reader = cmdCheck.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            facultyIdCode = string.IsNullOrEmpty(reader["faculty_id_code"].ToString())
                                ? facultyIdCode
                                : reader["faculty_id_code"].ToString();

                            firstName = reader["first_name"].ToString();
                            facultyEmail = reader["email"].ToString();
                        }
                    }
                }

                using (MySqlCommand cmdUpdate = new MySqlCommand("UPDATE tbl_users SET is_approved=1, faculty_id_code=@FacultyIdCode WHERE user_id=@UserId", conn))
                {
                    cmdUpdate.Parameters.AddWithValue("@FacultyIdCode", facultyIdCode);
                    cmdUpdate.Parameters.AddWithValue("@UserId", userId);
                    cmdUpdate.ExecuteNonQuery();
                }

                string subject = "Your Faculty Account is Approved!";
                string body = $@"
Hello {firstName},<br/><br/>
✅ Your faculty account has been approved by the admin.<br/>
Your Faculty ID: {facultyIdCode}<br/><br/>
You can now login here: <a href='https://yourdomain.com/Login.aspx'>Login</a><br/><br/>
Thank you.";

                SendEmail(facultyEmail, subject, body);
            }

            BindTeachers();
            BindNewTeachers();
            BindSummary();
        }

        private string GenerateFacultyCode(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            var code = new char[length];
            for (int i = 0; i < length; i++)
                code[i] = chars[random.Next(chars.Length)];
            return new string(code);
        }

        private void SendEmail(string toEmail, string subject, string body)
        {
            try
            {
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress("MOOCsweb1@gmail.com", "MOOCs");
                    mail.To.Add(toEmail);
                    mail.Subject = subject;
                    mail.Body = body;
                    mail.IsBodyHtml = true;

                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.Credentials = new NetworkCredential("MOOCsweb1@gmail.com", "fiiqvqbowjrrblon");
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Email sending failed: " + ex.Message);
            }
        }

        #endregion

        #region Student & Teacher Deletes

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStudent" && int.TryParse(e.CommandArgument.ToString(), out int userId))
                DeleteStudent(userId);
        }

        private void DeleteStudent(int userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                using (MySqlTransaction tran = conn.BeginTransaction())
                {
                    try
                    {
                        new MySqlCommand("DELETE FROM tbl_progress WHERE user_id=@UserId", conn, tran)
                            .AddParameter("@UserId", userId).ExecuteNonQuery();
                        new MySqlCommand("DELETE FROM tbl_users WHERE user_id=@UserId", conn, tran)
                            .AddParameter("@UserId", userId).ExecuteNonQuery();
                        tran.Commit();
                    }
                    catch { tran.Rollback(); throw; }
                }
            }

            BindStudentsWithProgress();
            BindSummary();
            BindNewStudents();
        }

        protected void gvTeachers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteTeacher" && int.TryParse(e.CommandArgument.ToString(), out int userId))
                DeleteTeacher(userId);
        }

        private void DeleteTeacher(int userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                using (MySqlTransaction tran = conn.BeginTransaction())
                {
                    try
                    {
                        new MySqlCommand("DELETE FROM tbl_faculty WHERE user_id=@UserId", conn, tran)
                            .AddParameter("@UserId", userId).ExecuteNonQuery();
                        new MySqlCommand("DELETE FROM tbl_users WHERE user_id=@UserId", conn, tran)
                            .AddParameter("@UserId", userId).ExecuteNonQuery();
                        tran.Commit();
                    }
                    catch { tran.Rollback(); throw; }
                }
            }

            BindTeachers();
            BindSummary();
            BindNewTeachers();
        }

        #endregion
    }

    // Extension method for quick parameter adding
    public static class MySqlExtensions
    {
        public static MySqlCommand AddParameter(this MySqlCommand cmd, string paramName, object value)
        {
            cmd.Parameters.AddWithValue(paramName, value);
            return cmd;
        }
    }
}
