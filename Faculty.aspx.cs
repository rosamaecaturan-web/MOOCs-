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
    public partial class Faculty : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
           
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);

          
            if (Session["userId"] == null || Session["role"] == null || Session["role"].ToString().ToLower() != "faculty")
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Login.aspx", true);
            }

            if (!IsPostBack)
            {
                // Load dashboard as usual
                int facultyId = Convert.ToInt32(Session["userId"]);
                LoadFacultyInfo(facultyId.ToString());
                LoadDashboardCounts(facultyId);
                CountStudents();
                LoadTotalCourses();
                LoadRecordCount();
                LoadProfile();
                LoadUploadedCourseCount();

                divDashboard.Visible = true;
                divEditProfile.Visible = false;
                divAbout.Visible = false;
                gvStudents.Visible = false;
                gvRecords.Visible = false;
                gvCourses.Visible = false;
                pnlCourseCards.Visible = false;
            }
        }





        private void LoadUploadedCourseCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM tbl_course";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                int total = Convert.ToInt32(cmd.ExecuteScalar());
                lblUploadedCourse.Text = total.ToString();
            }
        }



        protected void btnUploadedCourses_Click(object sender, EventArgs e)
        {

            pnlCourseCards.Visible = true;
            gvRecords.Visible = false;
            gvStudents.Visible = false;
            gvCourses.Visible = false;


            if (pnlCourseCards.Visible)
            {
                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                // Use aliases to match Eval() in ASPX
                string query = @"
                SELECT 
                    id AS CourseID,
                    course_name AS CourseTitle,
                    course_image AS CourseImage
                FROM tbl_course";

                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCourseCards.DataSource = dt;
                rptCourseCards.DataBind();
            }
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int courseId = Convert.ToInt32(btn.CommandArgument);

            // Redirect to course details page with the selected course ID
            Response.Redirect($"CourseDetails.aspx?CourseID={courseId}");
        }





        // Toggle visibility helpers
        protected void lnkHome_Click(object sender, EventArgs e)
        {
            divDashboard.Visible = true;
            divEditProfile.Visible = false;
            divAbout.Visible = false;
        }

        protected void lnkEditProfile_Click(object sender, EventArgs e)
        {
            divDashboard.Visible = false;
            divEditProfile.Visible = true;
            divAbout.Visible = false;
        }

        protected void lnkAbout_Click(object sender, EventArgs e)
        {
            divDashboard.Visible = false;
            divEditProfile.Visible = false;
            divAbout.Visible = true;
        }


        // ✅ Faculty Info
        private void LoadFacultyInfo(string userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT first_name, profile_pic FROM tbl_users WHERE user_id=@UserId";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblFacultyName.Text = reader["first_name"].ToString();

                            string imgPath = reader["profile_pic"].ToString();
                            if (!string.IsNullOrEmpty(imgPath))
                                imgFacultyProfile.ImageUrl = "~/uploads/profile/" + imgPath;
                            else
                                imgFacultyProfile.ImageUrl = "~/images/default-profile.png";

                            // Save in session for quick access
                            Session["facultyPic"] = imgFacultyProfile.ImageUrl;
                            Session["facultyName"] = lblFacultyName.Text;
                        }
                    }
                }
            }
        }


        // ✅ Dashboard Counts
        private void LoadDashboardCounts(int facultyId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                // Uploaded courses by this faculty
                string queryCourses = "SELECT COUNT(*) FROM tbl_course WHERE faculty_id = @FacultyId";
                using (MySqlCommand cmd = new MySqlCommand(queryCourses, conn))
                {
                    cmd.Parameters.AddWithValue("@FacultyId", facultyId);
                    int courseCount = Convert.ToInt32(cmd.ExecuteScalar());
                   
                }

                // Total students
                string queryStudents = "SELECT COUNT(*) FROM tbl_users WHERE role = 'student'";
                using (MySqlCommand cmd = new MySqlCommand(queryStudents, conn))
                {
                    int studentCount = Convert.ToInt32(cmd.ExecuteScalar());
                    lblStudentCount.Text = studentCount.ToString();
                }
            }
        }

        // ✅ Count Students
        private void CountStudents()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM tbl_users WHERE role = 'student'";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    lblStudentCount.Text = count.ToString();
                }
            }
        }

       

        // ✅ Show Students
        protected void btnShowStudents_Click(object sender, EventArgs e)
        {
            gvStudents.Visible = true;
            gvRecords.Visible = false;
            gvCourses.Visible = false;
            pnlCourseCards.Visible = false;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT first_name, last_name, email, role FROM tbl_users WHERE role = 'student'";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvStudents.DataSource = dt;
                        gvStudents.DataBind();
                    }
                }
            }
        }
        // ✅ Show Unique Records
        protected void btnShowRecords_Click(object sender, EventArgs e)
        {
            gvRecords.Visible = true;
            gvStudents.Visible = false;
            gvCourses.Visible = false;
            pnlCourseCards.Visible =false;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = @"
            SELECT DISTINCT
    u.user_id,
    u.first_name,
    u.last_name,
    c.course_code,
    c.course_name,
    p.module_number,
    p.status,
    p.quiz_score
FROM tbl_progress p
INNER JOIN tbl_course c 
    ON p.course_code = c.course_code
INNER JOIN tbl_users u
    ON p.user_id = u.user_id
ORDER BY 
    u.user_id,
    c.course_code,
    p.module_number;

        ";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvRecords.DataSource = dt;
                        gvRecords.DataBind();
                    }
                }
            }
        }



        private string lastUserId = null;

        protected void gvRecords_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string currentUserId = DataBinder.Eval(e.Row.DataItem, "user_id").ToString();

                if (lastUserId != null && lastUserId == currentUserId)
                {
                    // Merge User ID, First Name, Last Name cells
                    e.Row.Cells[0].Text = ""; // user_id
                    e.Row.Cells[1].Text = ""; // first_name
                    e.Row.Cells[2].Text = ""; // last_name
                }
                else
                {
                    lastUserId = currentUserId;
                }
            }
        }

        // ✅ Redirect Upload
        protected void lnkUploadModule_Click(object sender, EventArgs e)
        {
            Response.Redirect("Upload.aspx");
        }

        // ✅ Logout
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        private void LoadRecordCount()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string query = @"
            SELECT COUNT(*) AS total_unique
            FROM (
                SELECT DISTINCT course_code, module_number
                FROM tbl_progress
            ) AS unique_records;
        ";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    object result = cmd.ExecuteScalar();
                    lblRecordCount.Text = result.ToString();
                }
            }
        }


        private void LoadTotalCourses()
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                // 1. Get total number of courses
                string countQuery = "SELECT COUNT(*) FROM tbl_course";
                MySqlCommand countCmd = new MySqlCommand(countQuery, conn);
                int totalCourses = Convert.ToInt32(countCmd.ExecuteScalar());
                lblTotalCourses.Text = totalCourses.ToString();

                // 2. Get course data for GridView
                string selectQuery = "SELECT id, course_code, course_name, course_description, course_image FROM tbl_course";
                MySqlCommand selectCmd = new MySqlCommand(selectQuery, conn);
                MySqlDataAdapter da = new MySqlDataAdapter(selectCmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);

                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        // Optional: toggle GridView visibility when clicking the card
        protected void btnTotalCourses_Click(object sender, EventArgs e)
        {
            gvCourses.Visible = true;
            gvRecords.Visible = false;
            gvStudents.Visible = false;
            pnlCourseCards.Visible = false;


        }

        private void LoadProfile()
        {
            string userId = Session["userId"]?.ToString();
            if (string.IsNullOrEmpty(userId)) return;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT first_name, last_name, profile_pic FROM tbl_users WHERE user_id=@uid";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userId);
                    using (MySqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            txtFirstName.Text = dr["first_name"].ToString();
                            txtLastName.Text = dr["last_name"].ToString();

                            string pic = dr["profile_pic"].ToString();
                            imgProfilePic.ImageUrl = !string.IsNullOrEmpty(pic)
                                ? "~/uploads/profile/" + pic
                                : "~/uploads/profile/default.png";
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string userId = Session["userId"]?.ToString();
            if (string.IsNullOrEmpty(userId)) return;

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string profileFileName = null;
            if (fuProfilePic.HasFile)
            {
                string ext = Path.GetExtension(fuProfilePic.FileName).ToLower();
                // Optional: validate file type
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                {
                    profileFileName = Guid.NewGuid().ToString() + ext;

                    // Ensure the folder exists
                    string folderPath = Server.MapPath("~/uploads/profile/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string savePath = Path.Combine(folderPath, profileFileName);
                    fuProfilePic.SaveAs(savePath);

                    // Update both images on the page
                    imgProfilePic.ImageUrl = "~/uploads/profile/" + profileFileName;
                    imgFacultyProfile.ImageUrl = imgProfilePic.ImageUrl;

                    // Update session
                    Session["facultyPic"] = imgFacultyProfile.ImageUrl;
                }
                else
                {
                    lblMessage.Text = "Invalid file type. Only JPG, PNG, GIF allowed.";
                    lblMessage.CssClass = "text-danger";
                    lblMessage.Visible = true;
                    return;
                }
            }

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query;

                if (!string.IsNullOrEmpty(profileFileName))
                {
                    query = @"UPDATE tbl_users 
                          SET first_name=@first, last_name=@last, profile_pic=@pic 
                          WHERE user_id=@uid";
                }
                else
                {
                    query = @"UPDATE tbl_users 
                          SET first_name=@first, last_name=@last 
                          WHERE user_id=@uid";
                }

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@first", firstName);
                    cmd.Parameters.AddWithValue("@last", lastName);
                    cmd.Parameters.AddWithValue("@uid", userId);

                    if (!string.IsNullOrEmpty(profileFileName))
                        cmd.Parameters.AddWithValue("@pic", profileFileName);

                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblMessage.Text = "Profile updated successfully!";
                        lblMessage.CssClass = "text-success";
                        lblMessage.Visible = true;
                        LoadProfile(); // Refresh the image and text
                    }
                    else
                    {
                        lblMessage.Text = "No changes made.";
                        lblMessage.CssClass = "text-warning";
                        lblMessage.Visible = true;
                    }
                }
            }
        }

       
    }
}

