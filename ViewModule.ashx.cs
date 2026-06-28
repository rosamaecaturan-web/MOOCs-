using System;
using System.Web;
using System.IO;

public class ViewModule : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string filePath = context.Server.MapPath("~/uploads/modules/sample.pdf");

        context.Response.Clear();
        context.Response.ContentType = "application/pdf";
        context.Response.AddHeader("Content-Disposition", "inline");
        context.Response.AddHeader("X-Content-Type-Options", "nosniff");

        context.Response.TransmitFile(filePath);
        context.Response.End();
    }

    public bool IsReusable => false;
}