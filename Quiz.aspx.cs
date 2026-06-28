using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class Quiz : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                string courseId = Request.QueryString["courseCode"] ?? Request.QueryString["course_code"];
                string moduleId = Request.QueryString["moduleId"] ?? Request.QueryString["module_id"];
                string moduleNumber = Request.QueryString["moduleNumber"] ?? Request.QueryString["module_number"];

                if (string.IsNullOrEmpty(courseId))
                {
                    lblMessage.Text = "Invalid quiz request (missing courseId).";
                    return;
                }

               
                bool loaded = false;
                if (!string.IsNullOrEmpty(moduleId))
                {
                    loaded = LoadQuiz(courseId, moduleId, useModuleNumber: false);
                    if (!loaded && !string.IsNullOrEmpty(moduleNumber))
                    {
                   
                        loaded = LoadQuiz(courseId, moduleNumber, useModuleNumber: true);
                        if (loaded)
                            lblMessage.Visible = false;

                    }
                }
                else if (!string.IsNullOrEmpty(moduleNumber))
                {
                    loaded = LoadQuiz(courseId, moduleNumber, useModuleNumber: true);
                }

                if (!loaded)
                {
            
                    lblMessage.Text = $"No quiz found for courseCode='{courseId}', moduleId='{moduleId}', moduleNumber='{moduleNumber}'.<br/>" +
                                      $"Run this in your DB to verify: <br/>" +
                                      $"SELECT * FROM tbl_quizzes WHERE course_id = '{courseId}' AND (module_id = '{moduleId}' OR module_number = '{moduleNumber}');";
                }
            }
        }


        private bool LoadQuiz(string courseId, string moduleValue, bool useModuleNumber)
        {
            DataTable dt = new DataTable();
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = @"SELECT quiz_type, quiz_question, option_a, option_b, option_c, option_d, correct_answer
                                 FROM tbl_quizzes
                                 WHERE course_code = @courseCode AND " + (useModuleNumber ? "module_number = @moduleValue" : "module_id = @moduleValue");

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@courseCode", courseId);
                    cmd.Parameters.AddWithValue("@moduleValue", moduleValue);
                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                rptQuiz.DataSource = dt;
                rptQuiz.DataBind();
                return true;
            }
            return false;
        }





        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveQuizResult(int score, int total, string courseCode, int moduleNumber)
        {
            try
            {
                int userId = (int)HttpContext.Current.Session["userId"];
                bool passed = (total > 0 && ((score * 100) / total) >= 50);
                string status = passed ? "Passed" : "Failed";

                string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    string query = @"UPDATE tbl_quiz_results
                 SET quiz_score = @Score,
                     total_question = @Total,
                     passed = @Passed,
                     module_number = @ModuleNumber,
                     date_taken = NOW()
                 WHERE result_id = @ResultId 
                   AND user_id = @UserId";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Score", score);
                        cmd.Parameters.AddWithValue("@Total", total);
                        cmd.Parameters.AddWithValue("@Passed", status);
                        cmd.Parameters.AddWithValue("@ModuleNumber", moduleNumber); 
                        cmd.Parameters.AddWithValue("@ResultId", HttpContext.Current.Session["QuizResultId"]);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.ExecuteNonQuery();
                    }


                    if (passed)
                    {
                        string progressQuery = @"
                      INSERT INTO tbl_progress (user_id, course_code, module_number, status, quiz_score)
                      VALUES (@UserId, @CourseCode, @ModuleNumber, 'completed', @QuizScore)
                      ON DUPLICATE KEY UPDATE 
                      status = 'completed',
                      quiz_score = @QuizScore;";


                        using (MySqlCommand cmd = new MySqlCommand(progressQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.Parameters.AddWithValue("@CourseCode", courseCode);
                            cmd.Parameters.AddWithValue("@ModuleNumber", moduleNumber);
                            cmd.Parameters.AddWithValue("@QuizScore", score);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                return "success";
            }
            catch (Exception ex)
            {
                return "error: " + ex.Message;
            }
        }


        protected void rptQuiz_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item || e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                string quizType = DataBinder.Eval(e.Item.DataItem, "quiz_type").ToString();
                var pnlMCQ = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlMCQ");
                var pnlTF = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlTF");
                var pnlFIB = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlFIB");

                pnlMCQ.Visible = quizType.Equals("MCQ", StringComparison.OrdinalIgnoreCase);
                pnlTF.Visible = quizType.Equals("TF", StringComparison.OrdinalIgnoreCase) || quizType.Equals("TRUEFALSE", StringComparison.OrdinalIgnoreCase);
                pnlFIB.Visible = quizType.Equals("FIB", StringComparison.OrdinalIgnoreCase) || quizType.Equals("FILLIN", StringComparison.OrdinalIgnoreCase);
            }
        }
    }
}
