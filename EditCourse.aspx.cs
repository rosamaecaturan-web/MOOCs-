using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class EditCourse : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["CourseID"] != null)
                {
                    int courseId = Convert.ToInt32(Request.QueryString["CourseID"]);
                    LoadCourse(courseId);
                    LoadModules(courseId);
                    LoadVideos(courseId);
                    LoadQuizzes(courseId);
                }
            }
        }

        // Load course info
        private void LoadCourse(int courseId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM tbl_course WHERE id=@id";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", courseId);
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtCourseCode.Text = reader["course_code"].ToString();
                    txtCourseName.Text = reader["course_name"].ToString();
                    txtCourseDesc.Text = reader["course_description"].ToString();
                    imgCourse.ImageUrl = reader["course_image"].ToString();
                }
                reader.Close();
            }
        }

        private void LoadModules(int courseId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM tbl_module WHERE course_code=(SELECT course_code FROM tbl_course WHERE id=@id) ORDER BY module_number";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", courseId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptModules.DataSource = dt;
                rptModules.DataBind();
            }
        }

        private void LoadVideos(int courseId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM tbl_videos WHERE course_code=(SELECT course_code FROM tbl_course WHERE id=@id)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", courseId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptVideos.DataSource = dt;
                rptVideos.DataBind();
            }
        }

        private void LoadQuizzes(int courseId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM tbl_quizzes WHERE course_code=(SELECT course_code FROM tbl_course WHERE id=@id)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", courseId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptQuizzes.DataSource = dt;
                rptQuizzes.DataBind();
            }
        }

        // Save all changes
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            int courseId = Convert.ToInt32(Request.QueryString["CourseID"]);

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                // 1️⃣ Update course info
                string updateCourse = @"UPDATE tbl_course SET course_name=@name, course_description=@desc WHERE id=@id";
                MySqlCommand cmdCourse = new MySqlCommand(updateCourse, conn);
                cmdCourse.Parameters.AddWithValue("@name", txtCourseName.Text);
                cmdCourse.Parameters.AddWithValue("@desc", txtCourseDesc.Text);
                cmdCourse.Parameters.AddWithValue("@id", courseId);
                cmdCourse.ExecuteNonQuery();

                string courseCode = txtCourseCode.Text;

                // 2️⃣ Update modules
                foreach (RepeaterItem item in rptModules.Items)
                {
                    TextBox txtTitle = (TextBox)item.FindControl("txtModuleTitle");
                    TextBox txtContent = (TextBox)item.FindControl("txtModuleContent");
                    HiddenField hfModuleId = (HiddenField)item.FindControl("hfModuleId");

                    if (hfModuleId != null)
                    {
                        string updateModule = @"UPDATE tbl_module 
                                                SET module_title=@title, module_content=@content 
                                                WHERE module_id=@moduleId";
                        MySqlCommand cmdMod = new MySqlCommand(updateModule, conn);
                        cmdMod.Parameters.AddWithValue("@title", txtTitle.Text);
                        cmdMod.Parameters.AddWithValue("@content", txtContent.Text);
                        cmdMod.Parameters.AddWithValue("@moduleId", hfModuleId.Value);
                        cmdMod.ExecuteNonQuery();
                    }
                }

                // 3️⃣ Update videos
                foreach (RepeaterItem item in rptVideos.Items)
                {
                    TextBox txtVideoTitle = (TextBox)item.FindControl("txtVideoTitle");
                    HiddenField hfVideoId = (HiddenField)item.FindControl("hfVideoId");

                    if (hfVideoId != null)
                    {
                        string updateVideo = @"UPDATE tbl_videos SET video_title=@title WHERE video_id=@videoId";
                        MySqlCommand cmdVideo = new MySqlCommand(updateVideo, conn);
                        cmdVideo.Parameters.AddWithValue("@title", txtVideoTitle.Text);
                        cmdVideo.Parameters.AddWithValue("@videoId", hfVideoId.Value);
                        cmdVideo.ExecuteNonQuery();
                    }
                }

                // 4️⃣ Update quizzes
                foreach (RepeaterItem item in rptQuizzes.Items)
                {
                    TextBox txtQuestion = (TextBox)item.FindControl("txtQuizQuestion");
                    DropDownList ddlType = (DropDownList)item.FindControl("ddlQuizType");
                    HiddenField hfQuizId = (HiddenField)item.FindControl("hfQuizId");

                    if (hfQuizId != null)
                    {
                        string updateQuiz = @"UPDATE tbl_quizzes 
                                              SET quiz_type=@type, quiz_question=@question 
                                              WHERE id=@quizId";
                        MySqlCommand cmdQuiz = new MySqlCommand(updateQuiz, conn);
                        cmdQuiz.Parameters.AddWithValue("@type", ddlType.SelectedValue);
                        cmdQuiz.Parameters.AddWithValue("@question", txtQuestion.Text);
                        cmdQuiz.Parameters.AddWithValue("@quizId", hfQuizId.Value);
                        cmdQuiz.ExecuteNonQuery();
                    }
                }
            }

            // Reload page after saving
            Response.Redirect(Request.RawUrl);
        }
    }
}
