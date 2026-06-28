using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class ApproveFaculty : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Not logged in
            if (Session["UserID"] == null || Session["Role"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Only faculty allowed
            if (Session["Role"].ToString() != "faculty")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // CHECK STATUS
            string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT status FROM tbl_users WHERE user_id=@UserID";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    string status = cmd.ExecuteScalar()?.ToString();

                    // ⛔ BLOCK IF NOT APPROVED
                    if (status != "Approved")
                    {
                        Response.Redirect("FacultyPending.aspx");
                        return;
                    }
                }
            }
        }
    }
}