using System;
using System.IO;
using System.Web;

namespace MOOCs
{
    public partial class ViewPdf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Require login
            if (Session["userId"] == null)
            {
                Response.StatusCode = 403;
                Response.End();
                return;
            }

            string fileName = Request.QueryString["file"];
            if (string.IsNullOrEmpty(fileName))
            {
                Response.End();
                return;
            }

            string filePath = Server.MapPath("~/uploads/modules/" + fileName);

            if (!File.Exists(filePath))
            {
                Response.End();
                return;
            }

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline; filename=protected.pdf");
            Response.TransmitFile(filePath);
            Response.End();
        }
    }
}
