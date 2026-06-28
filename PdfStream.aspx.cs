using System;
using System.IO;

public partial class PdfStream : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ✅ Check session
        if (Session["UserID"] == null)
        {
            Response.StatusCode = 403;
            Response.End();
            return;
        }

        string fileName = Request.QueryString["file"];
        string filePath = Server.MapPath("~/uploads/modules/" + fileName);

        if (!File.Exists(filePath))
        {
            Response.StatusCode = 404;
            Response.End();
            return;
        }

        // Stream PDF to browser
        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "inline; filename=" + fileName);
        Response.TransmitFile(filePath);
        Response.End();
    }
}
