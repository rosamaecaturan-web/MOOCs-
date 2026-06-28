using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class Student_page : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            if (Session["userId"] == null)
            {
                Response.Redirect("signup.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadStudentInfo();
                LoadUserCourses();
                LoadUserModuleCourses(); // ✅ grouped modules
                LoadCertificates();
                LoadOverviewCourses();
                
            }


        }

        // ================= STUDENT INFO =================
        private void LoadStudentInfo()
        {
            string userId = Session["userId"].ToString();

            using (var conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = @"SELECT first_name, last_name, email, phone, bio, profile_pic
                                 FROM tbl_users WHERE user_id=@uid";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", userId);

                using (MySqlDataReader r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        txtFirstName.Text = r["first_name"].ToString();
                        txtLastName.Text = r["last_name"].ToString();
                        txtEmail.Text = r["email"].ToString();
                        txtPhone.Text = r["phone"].ToString();
                        txtBio.Text = r["bio"].ToString();

                        string pic = string.IsNullOrEmpty(r["profile_pic"].ToString())
                            ? "~/uploads/default.png"
                            : r["profile_pic"].ToString();

                        imgProfilePic.ImageUrl = pic;
                        imgSidebarProfile.ImageUrl = pic;

                        lblFullName.Text = r["first_name"] + " " + r["last_name"];
                        lblStudentName.Text = lblFullName.Text;
                        lblBioOverview.Text = r["bio"].ToString();
                    }
                }
            }
        }

        // ================= USER COURSES =================
        private void LoadUserCourses()
        {
            using (var conn = new MySqlConnection(connStr))
            {
                string query = @"
                    SELECT course_code,
                           MAX(course_name) AS course_name,
                           MAX(course_description) AS course_description,
                           MAX(course_image) AS course_image
                    FROM tbl_course
                    GROUP BY course_code";

                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCourses.DataSource = dt;
                rptCourses.DataBind();
            }
        }

   
        // ================= MODULE COURSES (OUTER) =================
        private void LoadUserModuleCourses()
        {
            using (var conn = new MySqlConnection(connStr))
            {
                string query = @"
            SELECT DISTINCT m.course_code
            FROM tbl_module m
            INNER JOIN tbl_progress p
                ON m.course_code = p.course_code
               AND m.module_number = p.module_number
            WHERE p.user_id = @uid
              AND p.status = 'Completed'";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", Session["userId"]);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCoursesModules.DataSource = dt;
                rptCoursesModules.DataBind();
            }
        }
        protected void rptCoursesModules_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
                e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string courseCode = DataBinder.Eval(e.Item.DataItem, "course_code").ToString();
                string uid = Session["userId"].ToString();

                Repeater rptModuleList = (Repeater)e.Item.FindControl("rptModuleList");
                Label lblScore = (Label)e.Item.FindControl("lblScore");

                using (var conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // ================= MODULE LIST =================
                    string moduleQuery = @"
                SELECT 
                    m.module_title,
                    IFNULL(p.quiz_score,0) AS score
                FROM tbl_module m
                INNER JOIN tbl_progress p
                    ON m.course_code = p.course_code
                   AND m.module_number = p.module_number
                WHERE m.course_code = @course
                  AND p.user_id = @uid
                  AND p.status = 'Completed'
                ORDER BY m.module_number";

                    MySqlCommand moduleCmd = new MySqlCommand(moduleQuery, conn);
                    moduleCmd.Parameters.AddWithValue("@course", courseCode);
                    moduleCmd.Parameters.AddWithValue("@uid", uid);

                    MySqlDataAdapter da = new MySqlDataAdapter(moduleCmd);
                    DataTable dtModules = new DataTable();
                    da.Fill(dtModules);

                    rptModuleList.DataSource = dtModules;
                    rptModuleList.DataBind();

                    // ================= TOTAL SCORE =================
                    string totalQuery = @"
                SELECT SUM(IFNULL(quiz_score,0))
                FROM tbl_progress
                WHERE course_code = @course
                  AND user_id = @uid
                  AND status = 'Completed'";

                    MySqlCommand totalCmd = new MySqlCommand(totalQuery, conn);
                    totalCmd.Parameters.AddWithValue("@course", courseCode);
                    totalCmd.Parameters.AddWithValue("@uid", uid);

                    object totalScore = totalCmd.ExecuteScalar();
                    lblScore.Text = totalScore != DBNull.Value ? totalScore.ToString() : "0";
                }
            }
        }

        // ================= CERTIFICATES =================
        private void LoadCertificates()
        {
            string uid = Session["userId"].ToString();

            using (var conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = @"SELECT course_code, file_path, date_issued
                                 FROM tbl_certificate WHERE user_id=@uid";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", uid);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCertificates.DataSource = dt;
                rptCertificates.DataBind();
            }
        }

        // ================= ACTIVITY =================
        private void LoadActivity()
        {
            string uid = Session["userId"].ToString();

            using (var conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = @"
                    SELECT action_details,
                           NULLIF(activity_time,'0000-00-00 00:00:00') AS activity_time
                    FROM tbl_activity_log
                    WHERE user_id=@uid
                    ORDER BY activity_time DESC";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", uid);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptActivity.DataSource = dt;
                rptActivity.DataBind();
                phNoActivity.Visible = dt.Rows.Count == 0;
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            string userId = Session["userId"]?.ToString();
            if (string.IsNullOrEmpty(userId)) return;

            string profilePath = UploadProfileImage();

            // ---------- GET ORIGINAL VALUES FROM DB ----------
            string originalFirst = "", originalLast = "", originalPhone = "", originalBio = "", originalPic = "";

            using (var conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string queryGet = "SELECT first_name, last_name, phone, bio, profile_pic FROM tbl_users WHERE user_id=@uid";
                MySqlCommand cmdOld = new MySqlCommand(queryGet, conn);
                cmdOld.Parameters.AddWithValue("@uid", userId);

                using (var r = cmdOld.ExecuteReader())
                {
                    if (r.Read())
                    {
                        originalFirst = r["first_name"].ToString();
                        originalLast = r["last_name"].ToString();
                        originalPhone = r["phone"].ToString();
                        originalBio = r["bio"].ToString();
                        originalPic = r["profile_pic"].ToString();
                    }
                }
            }

            // ------------ BUILD ACTIVITY DETAILS ------------
            string changes = "";

            if (originalFirst != txtFirstName.Text.Trim())
                changes += $"First Name changed: {originalFirst} ➝ {txtFirstName.Text}\n";

            if (originalLast != txtLastName.Text.Trim())
                changes += $"Last Name changed: {originalLast} ➝ {txtLastName.Text}\n";

            if (originalPhone != txtPhone.Text.Trim())
                changes += $"Phone changed: {originalPhone} ➝ {txtPhone.Text}\n";

            if (originalBio != txtBio.Text.Trim())
                changes += $"Bio changed.\n";

            if (originalPic != profilePath)
                changes += $"Profile Picture updated.\n";

            // ------------ LOG ACTIVITY IF THERE ARE CHANGES ------------
            if (!string.IsNullOrEmpty(changes))
            {
                using (var conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string query = @"INSERT INTO tbl_activity_log (user_id, action_details, activity_time)
                             VALUES (@uid, @details, @time)";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@details", changes);
                    cmd.Parameters.AddWithValue("@time", DateTime.Now); // current timestamp
                    cmd.ExecuteNonQuery();
                }
            }

            // ------------ UPDATE PROFILE ----------
            try
            {
                using (var conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string query = @"UPDATE tbl_users 
                             SET first_name=@fn, last_name=@ln, phone=@ph, bio=@bio, profile_pic=@pic
                             WHERE user_id=@uid";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@fn", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ln", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ph", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@bio", txtBio.Text.Trim());
                    cmd.Parameters.AddWithValue("@pic", profilePath);
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "✅ Profile updated successfully!";
                lblMessage.CssClass = "alert alert-success d-block";
                lblMessage.Visible = true;

                LoadStudentInfo();
               
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error updating profile: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger d-block";
                lblMessage.Visible = true;
            }
        }


        private string UploadProfileImage()
        {
            if (fuProfilePic.HasFile)
            {
                string ext = Path.GetExtension(fuProfilePic.FileName).ToLower();
                if (ext != ".jpg" && ext != ".png" && ext != ".jpeg")
                {
                    lblMessage.Text = "❌ Only JPG, PNG, JPEG allowed.";
                    lblMessage.CssClass = "alert alert-danger d-block";
                    lblMessage.Visible = true;
                    return imgProfilePic.ImageUrl;
                }

                if (fuProfilePic.PostedFile.ContentLength > 2 * 1024 * 1024)
                {
                    lblMessage.Text = "❌ File size must be less than 2MB.";
                    lblMessage.CssClass = "alert alert-danger d-block";
                    lblMessage.Visible = true;
                    return imgProfilePic.ImageUrl;
                }

                string folder = Server.MapPath("~/uploads/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fileName = Guid.NewGuid() + ext;
                string savePath = Path.Combine(folder, fileName);
                fuProfilePic.SaveAs(savePath);

                return "~/uploads/" + fileName;
            }

            return imgProfilePic.ImageUrl;
        }



        private void LoadOverviewCourses()
        {
            using (var conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string query = @"
            SELECT 
                course_code,
                MAX(course_name) AS course_name,
                MAX(course_description) AS course_description,
                MAX(course_image) AS course_image
            FROM tbl_course
            GROUP BY course_code
            ORDER BY course_name";

                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptOverviewCourses.DataSource = dt;
                rptOverviewCourses.DataBind();
            }
        }




        // ================= LOGOUT =================
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
