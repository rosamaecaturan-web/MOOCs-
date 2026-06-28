using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class CourseDetails : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                string query = "SELECT id, course_code, course_name, course_description, course_image FROM tbl_course";

                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCourses.DataSource = dt;
                rptCourses.DataBind();
            }
        }

        protected void rptCourses_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item ||
                e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                DataRowView drv = (DataRowView)e.Item.DataItem;
                string courseCode = drv["course_code"].ToString();

                // ============= LOAD MODULES =============
                Repeater rptModules = (Repeater)e.Item.FindControl("rptModules");

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string moduleQuery = @"SELECT module_id, course_code, module_title, module_content, module_number 
                                           FROM tbl_module 
                                           WHERE course_code=@code 
                                           ORDER BY module_number";

                    MySqlCommand cmd = new MySqlCommand(moduleQuery, conn);
                    cmd.Parameters.AddWithValue("@code", courseCode);

                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dtModules = new DataTable();
                    da.Fill(dtModules);

                    rptModules.DataSource = dtModules;
                    rptModules.DataBind();
                }

                // ============= LOAD VIDEOS + QUIZZES =============
                rptModules.ItemDataBound += (s, ev) =>
                {
                    if (ev.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item ||
                        ev.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
                    {
                        DataRowView mod = (DataRowView)ev.Item.DataItem;
                        string moduleNum = mod["module_number"].ToString();

                        Repeater rptVideos = (Repeater)ev.Item.FindControl("rptVideos");
                        Repeater rptQuizzes = (Repeater)ev.Item.FindControl("rptQuizzes");

                        using (MySqlConnection conn = new MySqlConnection(connStr))
                        {
                            conn.Open();

                            // ======== VIDEOS ========
                            string vidQuery = @"SELECT video_id, video_title 
                                                FROM tbl_videos 
                                                WHERE course_code=@code AND module_number=@mod";

                            MySqlCommand cmdVid = new MySqlCommand(vidQuery, conn);
                            cmdVid.Parameters.AddWithValue("@code", courseCode);
                            cmdVid.Parameters.AddWithValue("@mod", moduleNum);

                            MySqlDataAdapter daVid = new MySqlDataAdapter(cmdVid);
                            DataTable dtVid = new DataTable();
                            daVid.Fill(dtVid);

                            rptVideos.DataSource = dtVid;
                            rptVideos.DataBind();


                            // ======== QUIZZES ========
                            string quizQuery = @"SELECT id, quiz_type, quiz_question, option_a, option_b, option_c, option_d, correct_answer
                                                 FROM tbl_quizzes 
                                                 WHERE course_code=@code AND module_number=@mod";

                            MySqlCommand cmdQuiz = new MySqlCommand(quizQuery, conn);
                            cmdQuiz.Parameters.AddWithValue("@code", courseCode);
                            cmdQuiz.Parameters.AddWithValue("@mod", moduleNum);

                            MySqlDataAdapter daQuiz = new MySqlDataAdapter(cmdQuiz);
                            DataTable dtQuiz = new DataTable();
                            daQuiz.Fill(dtQuiz);

                            rptQuizzes.DataSource = dtQuiz;
                            rptQuizzes.DataBind();
                        }
                    }
                };
            }
        }

        protected void btnEditCourse_Click(object sender, EventArgs e)
        {
            var btn = (System.Web.UI.WebControls.Button)sender;
            int id = Convert.ToInt32(btn.CommandArgument);
            Response.Redirect("EditCourse.aspx?CourseID=" + id);
        }

        protected void btnDeleteCourse_Click(object sender, EventArgs e)
        {
            var btn = (System.Web.UI.WebControls.Button)sender;
            int id = Convert.ToInt32(btn.CommandArgument);

            string courseCode = "";

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                // get course code
                MySqlCommand cmd = new MySqlCommand("SELECT course_code FROM tbl_course WHERE id=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                courseCode = cmd.ExecuteScalar()?.ToString();

                if (courseCode != null)
                {
                    // Delete all child records
                    MySqlCommand delQuiz = new MySqlCommand("DELETE FROM tbl_quizzes WHERE course_code=@c", conn);
                    delQuiz.Parameters.AddWithValue("@c", courseCode);
                    delQuiz.ExecuteNonQuery();

                    MySqlCommand delVideos = new MySqlCommand("DELETE FROM tbl_videos WHERE course_code=@c", conn);
                    delVideos.Parameters.AddWithValue("@c", courseCode);
                    delVideos.ExecuteNonQuery();

                    MySqlCommand delModules = new MySqlCommand("DELETE FROM tbl_module WHERE course_code=@c", conn);
                    delModules.Parameters.AddWithValue("@c", courseCode);
                    delModules.ExecuteNonQuery();

                    // Delete course
                    MySqlCommand delCourse = new MySqlCommand("DELETE FROM tbl_course WHERE id=@id", conn);
                    delCourse.Parameters.AddWithValue("@id", id);
                    delCourse.ExecuteNonQuery();
                }
            }

            LoadCourses(); // refresh UI
        }


    }
}
