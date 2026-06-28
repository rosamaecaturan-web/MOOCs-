using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
            }
        }

        protected void rptCourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewModules")
            {
                string courseCode = e.CommandArgument.ToString();
                Response.Redirect("course.aspx?course_code=" + courseCode);
            }
        }

        private void LoadCourses()
        {
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = @"
                    SELECT DISTINCT course_code, course_name, course_description, course_image
                    FROM tbl_course
                    GROUP BY course_code"; // avoid duplicates

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptCourses.DataSource = dt;
                        rptCourses.DataBind();
                    }
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string CheckAndEnroll(string courseCode)
        {
            if (HttpContext.Current.Session["userId"] == null)
                return "notloggedin";

            string userId = HttpContext.Current.Session["userId"].ToString();

            using (var conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString))
            {
                conn.Open();

                try
                {
                    // Check if the user is already enrolled in this course
                    string checkQuery = @"SELECT COUNT(*) FROM tbl_progress 
                                  WHERE user_id=@user AND course_code=@course";

                    using (var checkCmd = new MySqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@user", userId);
                        checkCmd.Parameters.AddWithValue("@course", courseCode);

                        int count = Convert.ToInt32(checkCmd.ExecuteScalar());
                        if (count > 0)
                        {
                            // User already enrolled → allow viewing modules
                            return "enrolled";
                        }
                    }

                    // Insert enrollment for the course
                    string insertQuery = @"INSERT INTO tbl_progress (user_id, course_code, status, module_number)
                                   VALUES (@user, @course, 'Not Started', 1);"; // module_number = 1 by default

                    using (var insertCmd = new MySqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@user", userId);
                        insertCmd.Parameters.AddWithValue("@course", courseCode);
                        insertCmd.ExecuteNonQuery();
                    }

                    return "success";
                }
                catch (Exception ex)
                {
                    return "fail:" + ex.Message;
                }
            }
        }


    }
}
