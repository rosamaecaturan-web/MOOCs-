using System;
using System.Web;

public class PDFHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string file = context.Request.QueryString["file"];
        if (string.IsNullOrEmpty(file))
        {
            context.Response.StatusCode = 400; // Bad Request
            return;
        }

        string path = context.Server.MapPath("~/uploads/modules/" + file);

        if (!System.IO.File.Exists(path))
        {
            context.Response.StatusCode = 404; // Not Found
            return;
        }

        // Optional: Add watermark text (like student name) here later
        string username = context.Session["username"]?.ToString() ?? "Student";

        context.Response.Clear();
        context.Response.ContentType = "application/pdf";
        context.Response.AddHeader("Content-Disposition", "inline;filename=module.pdf");
        context.Response.TransmitFile(path);
        context.Response.End();
    }

    public bool IsReusable => false;
}
