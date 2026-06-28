using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace MOOCs
{
    public partial class Module : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string courseCode = Request.QueryString["courseCode"] ?? Request.QueryString["course_code"];
                if (!string.IsNullOrEmpty(courseCode))
                {
                    LoadCourseDetails(courseCode);
                    LoadModules(courseCode);
                    CheckAllModulesCompleted(courseCode);   // ✅ Certificate check
                }
                else
                {
                    lblCourseName.Visible = false;
                }
            }
        }

        // ============================================
        // ✅ CHECK IF USER COMPLETED ALL MODULES
        // ============================================
        private void CheckAllModulesCompleted(string courseCode)
        {
            int userId = Convert.ToInt32(Session["userId"]);

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string query = @"
                    SELECT 
                        (SELECT COUNT(*) FROM tbl_module WHERE course_code = @courseCode) AS total_modules,
                        (SELECT COUNT(*) FROM tbl_progress 
                         WHERE course_code = @courseCode 
                         AND user_id = @userId 
                         AND status = 'completed') AS completed_modules";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@courseCode", courseCode);
                    cmd.Parameters.AddWithValue("@userId", userId);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int totalModules = Convert.ToInt32(reader["total_modules"]);
                            int completedModules = Convert.ToInt32(reader["completed_modules"]);

                            if (totalModules == 1 && completedModules == 1)
                            {
                                pnlCertificate.Visible = true;
                                return;
                            }

                            if (totalModules > 1 && completedModules == totalModules)
                                pnlCertificate.Visible = true;
                            else
                                pnlCertificate.Visible = false;
                        }
                    }
                }
            }
        }

        private void LoadCourseDetails(string courseCode)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT course_name, course_description, course_image FROM tbl_course WHERE course_code = @CourseCode";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseCode", courseCode);
                    conn.Open();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblCourseName.Text = reader["course_name"].ToString();
                            lblCourseDescription.Text = reader["course_description"].ToString();
                            imgCourse.ImageUrl = reader["course_image"].ToString();
                        }
                        else
                        {
                            lblCourseName.Text = "Course not found.";
                        }
                    }
                }
            }
        }

        private void LoadModules(string courseCode)
        {
            DataTable dt = new DataTable();
            int userId = Convert.ToInt32(Session["userId"]);

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string query = @"
        SELECT 
            m.module_id, 
            m.module_number, 
            m.course_code,
            m.module_title,

            CASE 
                WHEN m.module_number = 1 THEN 0
                WHEN EXISTS (
                    SELECT 1 FROM tbl_progress p
                    WHERE p.module_number = m.module_number - 1
                      AND p.status = 'completed'
                      AND p.user_id = @UserId
                      AND p.course_code = m.course_code
                ) THEN 0
                ELSE 1
            END AS IsLocked,

            CASE 
                WHEN EXISTS (
                    SELECT 1 FROM tbl_quizzes q
                    WHERE q.course_code = m.course_code
                      AND (q.module_id = m.module_id OR q.module_number = m.module_number)
                ) THEN 1 ELSE 0
            END AS HasQuiz
        FROM tbl_module m
        WHERE m.course_code = @CourseCode
        ORDER BY m.module_number ASC";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseCode", courseCode);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            if (!dt.Columns.Contains("IsLocked"))
                dt.Columns.Add("IsLocked", typeof(bool));

            foreach (DataRow row in dt.Rows)
                if (row["IsLocked"] == DBNull.Value)
                    row["IsLocked"] = true;

            rptModules.DataSource = dt;
            rptModules.DataBind();
        }

        // ===================== MODULE CLICK =====================
        protected void btnModule_Command(object sender, CommandEventArgs e)
        {
            string moduleId = e.CommandArgument.ToString();
            ShowModuleDetails(moduleId);

            foreach (RepeaterItem item in rptModules.Items)
            {
                Button quizBtn = item.FindControl("btnQuiz") as Button;
                if (quizBtn != null) quizBtn.Visible = false;
            }

            Button clickedButton = sender as Button;
            if (clickedButton != null)
            {
                RepeaterItem parentItem = (RepeaterItem)clickedButton.NamingContainer;
                Button quizBtn = parentItem.FindControl("btnQuiz") as Button;
                if (quizBtn != null) quizBtn.Visible = true;
            }

            pnlModuleDetails.Visible = true;
        }

        // ===================== QUIZ CLICK =====================
        protected void btnQuiz_Command(object sender, CommandEventArgs e)
        {
            string[] parts = e.CommandArgument.ToString().Split('|');
            string moduleId = Server.UrlEncode(parts[0]);
            string moduleNumber = Server.UrlEncode(parts[1]);
            string courseCode = Server.UrlEncode(parts[2]);

            Response.Redirect($"quiz.aspx?courseCode={courseCode}&moduleId={moduleId}&moduleNumber={moduleNumber}");
        }

        // ===================== SHOW MODULE DETAILS =====================
        private void ShowModuleDetails(string moduleId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string moduleQuery = @"
            SELECT module_title, module_content, file_path, module_number, course_code
            FROM tbl_module
            WHERE module_id = @module_id";

                using (MySqlCommand cmd = new MySqlCommand(moduleQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@module_id", moduleId);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            lblModuleTitle.Text = "Module not found.";
                            litModuleContent.Text = "";
                            litFileViewer.Text = "";
                            lblVideoTitle.Text = "";
                            litVideo.Text = "";
                            return;
                        }

                        lblModuleTitle.Text = reader["module_title"].ToString();

                        litModuleContent.Text = reader["module_content"] == DBNull.Value
                            ? "<p class='text-muted'>No content available.</p>"
                            : reader["module_content"].ToString();

                        string filePath = reader["file_path"]?.ToString();
                        if (!string.IsNullOrEmpty(filePath))
                            litFileViewer.Text = GenerateFileViewer(filePath);
                        else
                            litFileViewer.Text = "<p class='text-muted'>No file attached.</p>";

                        string moduleNumber = reader["module_number"].ToString();
                        string courseCode = reader["course_code"].ToString();
                        reader.Close(); 

                        string videoQuery = @"
                    SELECT video_title, video_file_path
                    FROM tbl_videos
                    WHERE course_code = @course_code
                    AND module_number = @module_number";

                        using (MySqlCommand videoCmd = new MySqlCommand(videoQuery, conn))
                        {
                            videoCmd.Parameters.AddWithValue("@course_code", courseCode);
                            videoCmd.Parameters.AddWithValue("@module_number", moduleNumber);

                            using (MySqlDataReader videoReader = videoCmd.ExecuteReader())
                            {
                                if (videoReader.Read())
                                {
                                    lblVideoTitle.Text = videoReader["video_title"].ToString();
                                    string videoPath = videoReader["video_file_path"].ToString();

                                    litVideo.Text = $@"
                                <div class='text-center mt-3'>
                                    <video width='80%' height='400' controls class='rounded shadow-sm'>
                                        <source src='{ResolveUrl(videoPath)}' type='video/mp4'>
                                    </video>
                                </div>";
                                }
                                else
                                {
                                    lblVideoTitle.Text = "No video available for this module.";
                                    litVideo.Text = "";
                                }
                            }
                        }
                    }
                }
            }

            pnlModuleDetails.Visible = true;
        }
        private string GenerateFileViewer(string filePath)
        {
            string ext = Path.GetExtension(filePath).ToLower();
            string resolvedPath = ResolveUrl(filePath.Replace("~/", ""));

            if (ext == ".pdf" || ext == ".html")
            {
                // Use iframe to show rendered PDF HTML
                return $@"<iframe 
            src='{resolvedPath}' 
            style='width:100%; height:70vh; border:none;' 
            class='rounded'>
         </iframe>";
            }

            if (ext == ".doc" || ext == ".docx")
            {
                string url = Request.Url.GetLeftPart(UriPartial.Authority) + resolvedPath;
                return $@"<iframe 
            src='https://view.officeapps.live.com/op/embed.aspx?src={url}' 
            width='100%' height='900px' 
            class='border rounded'>
         </iframe>";
            }

            return "<p class='text-danger'>Unsupported file format</p>";
        }

        protected void btnCertificate_Click(object sender, EventArgs e)
        {
            string courseCode = Request.QueryString["courseCode"];
            Response.Redirect($"Certificate.aspx?courseCode={Server.UrlEncode(courseCode)}");
        }
    }
}
