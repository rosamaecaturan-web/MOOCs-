using System;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using System.IO;
using System.Web;
using iTextSharp.text;
using iTextSharp.text.pdf;
using MySql.Data.MySqlClient;

namespace MOOCs
{
    public partial class Certificate : System.Web.UI.Page
    {
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    lblMessage.Text = "⚠️ Please log in first.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    btnView.Visible = false;
                    btnGenerate.Visible = false;
                    return;
                }

                int userId = Convert.ToInt32(Session["userId"]);
                string courseCode = Request.QueryString["courseCode"];

                if (HasCompletedAllModules(userId, courseCode))
                {
                    lblMessage.Text = "🎉 Congratulations! You've completed all modules. You can now view your certificate.";
                    btnView.Visible = true;
                    btnGenerate.Visible = false;
                }
                else
                {
                    lblMessage.Text = "🕓 You need to complete all modules before generating your certificate.";
                    lblMessage.ForeColor = System.Drawing.Color.Red; 
                    btnView.Visible = false;
                    btnGenerate.Visible = false;
                }
            }
        }




        protected void btnView_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["userId"]);
            string recipient = GetUserFullName(userId);
            string awardTitle = GetCompletedCourseTitle(userId);
            string dateText = DateTime.Now.ToString("MMMM d, yyyy");

            using (MemoryStream certImageStream = CreateCertificateImage(recipient, awardTitle, dateText))
            {
                string base64Image = Convert.ToBase64String(certImageStream.ToArray());
                imgPreview.ImageUrl = "data:image/png;base64," + base64Image;
                imgPreview.Visible = true;
                btnGenerate.Visible = true;
                btnView.Visible = false;
                lblMessage.Text = "✅ Preview your certificate below. Click 'Generate Certificate' to download as PDF.";
                lblMessage.ForeColor = System.Drawing.Color.Blue;
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["userId"]);
            string recipient = GetUserFullName(userId);
            string awardTitle = GetCompletedCourseTitle(userId);
            string dateText = DateTime.Now.ToString("MMMM d, yyyy");
            string courseCode = Request.QueryString["courseCode"];

            using (MemoryStream certImageStream = CreateCertificateImage(recipient, awardTitle, dateText))
            {
                certImageStream.Position = 0;

                // ✅ Save certificate as image file on server
                string certFolder = Server.MapPath("~/certificates/");
                if (!Directory.Exists(certFolder))
                    Directory.CreateDirectory(certFolder);

                string imageFileName = $"certificate_{userId}_{courseCode}_{DateTime.Now:yyyyMMddHHmmss}.png";
                string imagePath = Path.Combine(certFolder, imageFileName);
                File.WriteAllBytes(imagePath, certImageStream.ToArray());

                // ✅ Save certificate record to database
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string insertQuery = @"INSERT INTO tbl_certificate (user_id, course_code, file_path, date_issued)
                                   VALUES (@uid, @code, @path, NOW())";
                    using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@uid", userId);
                        cmd.Parameters.AddWithValue("@code", courseCode);
                        cmd.Parameters.AddWithValue("@path", "~/certificates/" + imageFileName);
                        cmd.ExecuteNonQuery();
                    }
                }

                // ✅ Continue to generate PDF for download
                using (MemoryStream pdfStream = new MemoryStream())
                {
                    var img = iTextSharp.text.Image.GetInstance(certImageStream.ToArray());
                    var pageSize = new iTextSharp.text.Rectangle(img.Width, img.Height);
                    using (Document doc = new Document(pageSize, 0, 0, 0, 0))
                    {
                        PdfWriter.GetInstance(doc, pdfStream);
                        doc.Open();
                        img.SetAbsolutePosition(0, 0);
                        doc.Add(img);
                        doc.Close();
                    }

                    byte[] pdfBytes = pdfStream.ToArray();
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", $"attachment; filename=certificate_{SanitizeFileName(recipient)}.pdf");
                    Response.BinaryWrite(pdfBytes);
                    Response.Flush();
                    Response.End();
                }
            }
        }

        private bool HasCompletedAllModules(int userId, string courseCode)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = @"
                    SELECT 
                        COUNT(m.module_number) AS total_modules,
                        SUM(CASE WHEN p.status = 'completed' THEN 1 ELSE 0 END) AS completed_modules
                    FROM tbl_module m
                    LEFT JOIN tbl_progress p 
                        ON m.module_number = p.module_number 
                        AND m.course_code = p.course_code 
                        AND p.user_id = @userId
                    WHERE m.course_code = @courseCode;";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@courseCode", courseCode);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int totalModules = reader.IsDBNull(0) ? 0 : reader.GetInt32(0);
                            int completedModules = reader.IsDBNull(1) ? 0 : reader.GetInt32(1);
                            return totalModules > 0 && totalModules == completedModules;
                        }
                    }
                }
            }
            return false;
        }

        private string GetUserFullName(int userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT CONCAT(first_name, ' ', last_name) FROM tbl_users WHERE user_id = @id LIMIT 1;";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", userId);
                    object result = cmd.ExecuteScalar();
                    return result?.ToString() ?? "Recipient Name";
                }
            }
        }

        private string GetCompletedCourseTitle(int userId)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT c.course_code FROM tbl_progress p JOIN tbl_course c ON p.course_code = c.course_code WHERE p.user_id = @id LIMIT 1;";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", userId);
                    object result = cmd.ExecuteScalar();
                    return result?.ToString() ?? "Completed Course";
                }
            }
        }

        private MemoryStream CreateCertificateImage(string name, string award, string dateText)
        {
            int width = 1400, height = 990;
            Bitmap bmp = new Bitmap(width, height);

            using (Graphics g = Graphics.FromImage(bmp))
            {
                g.SmoothingMode = SmoothingMode.AntiAlias;
                g.TextRenderingHint = TextRenderingHint.AntiAliasGridFit;

                using (LinearGradientBrush bgBrush = new LinearGradientBrush(
                    new System.Drawing.Rectangle(0, 0, width, height),
                    Color.FromArgb(255, 252, 239),
                    Color.WhiteSmoke,
                    LinearGradientMode.Vertical))
                {
                    g.FillRectangle(bgBrush, 0, 0, width, height);
                }

                Random rand = new Random();
                for (int i = 0; i < 20; i++)
                {
                    int size = rand.Next(40, 120);
                    using (SolidBrush b = new SolidBrush(Color.FromArgb(40, 180, 200, 255)))
                        g.FillEllipse(b, rand.Next(0, width - size), rand.Next(0, height - size), size, size);
                }

                int margin = 30;
                using (Pen outer = new Pen(Color.FromArgb(212, 175, 55), 12))
                    g.DrawRectangle(outer, new System.Drawing.Rectangle(margin, margin, width - 2 * margin, height - 2 * margin));

                using (Pen inner = new Pen(Color.FromArgb(160, 130, 20), 2))
                    g.DrawRectangle(inner, new System.Drawing.Rectangle(margin + 15, margin + 15, width - 2 * (margin + 15), height - 2 * (margin + 15)));

                int headerTop = margin + 15;
                using (System.Drawing.Font mainTitle = new System.Drawing.Font("Poppins", 48, FontStyle.Bold))
                using (System.Drawing.Font subTitle = new System.Drawing.Font("Arial", 26, FontStyle.Bold))
                using (StringFormat sf = new StringFormat { Alignment = StringAlignment.Center })
                {
                    g.FillRectangle(new SolidBrush(Color.FromArgb(0, 70, 160)), margin + 15, headerTop, width - 2 * (margin + 15), 180);
                    g.DrawString("Certificate", mainTitle, Brushes.White, new RectangleF(0, headerTop + 35, width, 60), sf);
                    g.DrawString("of Achievement", subTitle, new SolidBrush(Color.LightBlue), new RectangleF(0, headerTop + 100, width, 50), sf);
                }

                using (System.Drawing.Font subFont = new System.Drawing.Font("Arial", 20, FontStyle.Italic))
                using (StringFormat sf = new StringFormat { Alignment = StringAlignment.Center })
                {
                    g.DrawString("This is proudly presented to", subFont, Brushes.Black, new RectangleF(100, 310, width - 200, 40), sf);
                }

                using (System.Drawing.Font nameFont = new System.Drawing.Font("Times New Roman", 56, FontStyle.Bold))
                using (StringFormat sf = new StringFormat { Alignment = StringAlignment.Center })
                {
                    g.DrawString(name, nameFont, new SolidBrush(Color.FromArgb(30, 50, 100)), new RectangleF(150, 400, width - 300, 100), sf);
                }

                // Course / award line
                using (System.Drawing.Font awardFont = new System.Drawing.Font("Arial", 24, System.Drawing.FontStyle.Regular))
                using (StringFormat sf = new StringFormat { Alignment = StringAlignment.Center })
                {
                    g.DrawString($"For successfully completing: {award}", awardFont, Brushes.Black, new RectangleF(150, 540, width - 300, 60), sf);
                }

                // Logo below the award line
                string logoPath = Server.MapPath("~/images/Lo.png");
                if (File.Exists(logoPath))
                {
                    using (System.Drawing.Image logo = System.Drawing.Image.FromFile(logoPath))
                    {
                        int logoW = 190;
                        int logoH = (int)(logo.Height * (logoW / (double)logo.Width));
                        int logoX = (width - logoW) / 2; // center horizontally
                        int logoY = 620; // below the award line (adjust as needed)
                        g.DrawImage(logo, logoX, logoY, logoW, logoH);
                    }
                }


                using (System.Drawing.Font sigFont = new System.Drawing.Font("Arial", 20, System.Drawing.FontStyle.Bold))
                using (System.Drawing.Font sigTitleFont = new System.Drawing.Font("Arial", 16, System.Drawing.FontStyle.Regular))
                using (StringFormat sf = new StringFormat { Alignment = StringAlignment.Center })
                {
                    // Dean signature
                    g.DrawLine(Pens.Black, 250, height - 120, 550, height - 120);
                    g.DrawString("Dean Name", sigFont, Brushes.Black, new RectangleF(250, height - 110, 300, 30), sf);
                    g.DrawString("Dean", sigTitleFont, Brushes.Black, new RectangleF(250, height - 80, 300, 25), sf);

                    // Faculty signature
                    g.DrawLine(Pens.Black, width - 550, height - 120, width - 250, height - 120);
                    g.DrawString("Faculty Name", sigFont, Brushes.Black, new RectangleF(width - 550, height - 110, 300, 30), sf);
                    g.DrawString("Faculty", sigTitleFont, Brushes.Black, new RectangleF(width - 550, height - 80, 300, 25), sf);
                }
            }

            MemoryStream ms = new MemoryStream();
            bmp.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            bmp.Dispose();
            ms.Position = 0;
            return ms;
        }

        private string SanitizeFileName(string input)
        {
            foreach (char c in Path.GetInvalidFileNameChars())
                input = input.Replace(c, '_');
            return input.Replace(" ", "_");
        }
    }
}
