using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MOOCs
{
    /// <summary>
    /// Summary description for ModuleFileHandler
    /// </summary>
    public class ModuleFileHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}