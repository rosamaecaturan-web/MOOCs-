using System.Web;
using System;

using System.IO;

public class ModuleHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string fileName = context.Request.QueryString["file"];
        if (string.IsNullOrEmpty(fileName))
        {
            context.Response.StatusCode = 404;
            return;
        }

        string filePath = context.Server.MapPath("~/App_Data/Modules/" + fileName);
        if (!File.Exists(filePath))
        {
            context.Response.StatusCode = 404;
            return;
        }

        // Stream PDF without allowing download
        context.Response.Clear();
        context.Response.ContentType = "application/pdf";
        context.Response.AddHeader("Content-Disposition", "inline; filename=" + fileName);
        context.Response.TransmitFile(filePath);
        context.Response.End();
    }

    public bool IsReusable { get { return false; } }
}
