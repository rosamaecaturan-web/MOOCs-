using System;
using System.IO;
using System.Web.UI;
using PdfiumViewer;
using System.Drawing.Imaging;

namespace MOOCs
{
    public partial class RenderPdfAsImages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // ✅ PDF file name passed via query string
                // example: RenderPdfAsImages.aspx?file=sample.pdf
                string fileName = Request.QueryString["file"];

                if (string.IsNullOrEmpty(fileName))
                {
                    litViewer.Text = "<p>No PDF specified.</p>";
                    return;
                }

                string pdfPath = Server.MapPath("~/uploads/modules/" + fileName);

                if (!File.Exists(pdfPath))
                {
                    litViewer.Text = "<p>PDF not found.</p>";
                    return;
                }

                litViewer.Text = RenderPdfToImages(pdfPath);
            }
        }

        // ✅ CORRECT METHOD
        private string RenderPdfToImages(string pdfPath)
        {
            string imgFolder = Server.MapPath("~/temp/pdfimgs/");
            Directory.CreateDirectory(imgFolder);

            string html = "";

            using (var doc = PdfDocument.Load(pdfPath))
            {
                for (int i = 0; i < doc.PageCount; i++)
                {
                    using (var img = doc.Render(i, 1200, 1200, true))
                    {
                        string imgName = Guid.NewGuid() + ".png";
                        string imgPath = Path.Combine(imgFolder, imgName);

                        img.Save(imgPath, ImageFormat.Png);

                        html += $@"
<img src='/temp/pdfimgs/{imgName}' 
     style='width:100%; margin-bottom:20px;' />";
                    }
                }
            }

            return html;
        }
    }
}
