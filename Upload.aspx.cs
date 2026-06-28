using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aspose.Pdf;
using GroupDocs.Viewer;
using GroupDocs.Viewer.Options;

namespace MOOCs
{
    public partial class Upload : System.Web.UI.Page
    {
        private int ModuleCount
        {
            get { return (int)(ViewState["ModuleCount"] ?? 3); }
            set { ViewState["ModuleCount"] = value; }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            if (ViewState["ModuleCount"] == null)
                ModuleCount = 3;

            RecreateDynamicModuleControls();
        }

        private void RecreateDynamicModuleControls()
        {
            if (ModuleCount <= 3) return;

            for (int i = 4; i <= ModuleCount; i++)
            {
                if (phModules.FindControl("txtModule" + i + "Content") == null)
                    CreateDynamicModuleControl(i);
            }
        }

        private void CreateDynamicModuleControl(int index)
        {
            var div = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            div.ID = "module" + index;
            div.Attributes["class"] = "col-12 mt-2";

            div.Controls.Add(new LiteralControl($"<label>Module {index} Content</label>"));

            var contentBox = new TextBox
            {
                ID = "txtModule" + index + "Content",
                CssClass = "form-control",
                TextMode = TextBoxMode.MultiLine,
                Rows = 3,
                ToolTip = $"Content for Module {index}"
            };
            contentBox.Attributes["placeholder"] = $"Enter content for Module {index}...";
            div.Controls.Add(contentBox);

            div.Controls.Add(new LiteralControl("<br/><label>Upload File for this Module</label>"));
            var fileUpload = new FileUpload
            {
                ID = "fuModule" + index + "File",
                CssClass = "form-control"
            };
            div.Controls.Add(fileUpload);

            phModules.Controls.Add(div);
        }

        protected void btnAddModule_Click(object sender, EventArgs e)
        {
            ModuleCount++;

            if (ddlModuleSelector.Items.FindByValue(ModuleCount.ToString()) == null)
                ddlModuleSelector.Items.Add(new ListItem("Module " + ModuleCount, ModuleCount.ToString()));

            CreateDynamicModuleControl(ModuleCount);
            ddlModuleSelector.SelectedValue = ModuleCount.ToString();

            txtModuleTitle.Text = "Module " + ModuleCount;
            ShowModuleContent(ModuleCount);
        }

        private void ShowModuleContent(int selectedModuleNumber)
        {
            module1.Visible = selectedModuleNumber == 1;
            module2.Visible = selectedModuleNumber == 2;
            module3.Visible = selectedModuleNumber == 3;

            for (int i = 4; i <= ModuleCount; i++)
            {
                var div = phModules.FindControl("module" + i) as System.Web.UI.HtmlControls.HtmlGenericControl;
                if (div != null)
                    div.Visible = (i == selectedModuleNumber);
            }
        }

        protected void ddlModuleSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selected = 1;
            if (!int.TryParse(ddlModuleSelector.SelectedValue, out selected))
                selected = 1;

            txtModuleTitle.Text = "Module " + selected;
            ShowModuleContent(selected);
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["bsitConnectionString"].ConnectionString;

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    string courseCode = txtCourseCode.Text.Trim();
                    string courseName = txtCourseName.Text.Trim();
                    string courseDesc = txtCourseDescription.Text.Trim();
                    string selectedModule = ddlModuleSelector.SelectedValue;
                    string videoTitle = txtVideoTitle.Text.Trim();
                    string courseImagePath = string.Empty;
                    string videoFilePath = string.Empty;

                    // --- Upload Course Image ---
                    if (fileCourseImage.HasFile)
                    {
                        string folderPath = Server.MapPath("~/images/course/");
                        if (!Directory.Exists(folderPath))
                            Directory.CreateDirectory(folderPath);

                        string fileName = Path.GetFileName(fileCourseImage.FileName);
                        string savePath = Path.Combine(folderPath, fileName);
                        fileCourseImage.SaveAs(savePath);
                        courseImagePath = "images/course/" + fileName;
                    }

                    // --- Upload Video ---
                    if (fileUploadVideo.HasFile)
                    {
                        string ext = Path.GetExtension(fileUploadVideo.FileName).ToLower();
                        string[] allowed = { ".mp4", ".mov", ".avi", ".mkv" };
                        if (allowed.Contains(ext))
                        {
                            string folder = Server.MapPath("~/uploads/videos/");
                            if (!Directory.Exists(folder))
                                Directory.CreateDirectory(folder);

                            string fileName = $"{Guid.NewGuid()}{ext}";
                            string savePath = Path.Combine(folder, fileName);
                            fileUploadVideo.SaveAs(savePath);
                            videoFilePath = "uploads/videos/" + fileName;
                        }
                    }

                    // --- Insert Course Record ---
                    string insertCourse = @"INSERT INTO tbl_course 
                        (course_code, course_name, course_description, course_image) 
                        VALUES (@code, @name, @desc, @image)";
                    using (MySqlCommand cmd = new MySqlCommand(insertCourse, conn))
                    {
                        cmd.Parameters.AddWithValue("@code", courseCode);
                        cmd.Parameters.AddWithValue("@name", courseName);
                        cmd.Parameters.AddWithValue("@desc", courseDesc);
                        cmd.Parameters.AddWithValue("@image", courseImagePath);
                        cmd.ExecuteNonQuery();
                    }

                    // --- Insert Modules ---
                    for (int i = 1; i <= ModuleCount; i++)
                    {
                        string content = GetModuleContent(i) ?? ""; // ensure not null
                        string fileName = SaveModuleFile(i); // returns viewer HTML path or uploaded file path

                        if (!string.IsNullOrEmpty(content) || !string.IsNullOrEmpty(fileName))
                        {
                            string insertModule = @"INSERT INTO tbl_module 
            (course_code, module_number, module_title, module_content, file_path) 
            VALUES (@course_code, @num, @title, @content, @file)";
                            using (MySqlCommand cmd = new MySqlCommand(insertModule, conn))
                            {
                                cmd.Parameters.AddWithValue("@course_code", courseCode);
                                cmd.Parameters.AddWithValue("@num", i);
                                cmd.Parameters.AddWithValue("@title", "Module " + i);
                                cmd.Parameters.AddWithValue("@content", content); // now always not null
                                cmd.Parameters.AddWithValue("@file", fileName ?? "");
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    // --- Insert Video Record ---
                    if (!string.IsNullOrEmpty(videoFilePath))
                    {
                        string insertVideo = @"INSERT INTO tbl_videos 
                            (course_code, module_number, video_title, video_file_path) 
                            VALUES (@course_code, @module_number, @video_title, @path)";
                        using (MySqlCommand cmd = new MySqlCommand(insertVideo, conn))
                        {
                            cmd.Parameters.AddWithValue("@course_code", courseCode);
                            cmd.Parameters.AddWithValue("@module_number", selectedModule);
                            cmd.Parameters.AddWithValue("@video_title", videoTitle);
                            cmd.Parameters.AddWithValue("@path", videoFilePath);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // --- Save Quiz ---
                    string quizType = ddlQuizTypeSelector.SelectedValue;
                    SaveQuizData(conn, courseCode, selectedModule, quizType);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "uploadSuccess",
                        "alert('✅ Successfully uploaded content!');", true);

                    string script = "setTimeout(function(){ window.location.href = window.location.pathname; }, 2000);";
                    ScriptManager.RegisterStartupScript(this, GetType(), "RedirectPage", script, true);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Upload failed: " + ex.Message;
                lblStatus.CssClass = "text-danger fw-bold d-block mt-3";
            }
        }

        private string GetModuleContent(int moduleNumber)
        {
            if (moduleNumber == 1) return txtModule1Content.Text.Trim();
            if (moduleNumber == 2) return txtModule2Content.Text.Trim();
            if (moduleNumber == 3) return txtModule3Content.Text.Trim();

            var dyn = phModules.FindControl("txtModule" + moduleNumber + "Content") as TextBox;
            return dyn?.Text.Trim() ?? "";
        }
        private string SaveModuleFile(int moduleNumber)
        {
            FileUpload fu = null;

            if (moduleNumber == 1) fu = fuModuleFile;
            else if (moduleNumber == 2) fu = FindControlRecursive(this, "fuModule2File") as FileUpload;
            else if (moduleNumber == 3) fu = FindControlRecursive(this, "fuModule3File") as FileUpload;
            else fu = phModules.FindControl("fuModule" + moduleNumber + "File") as FileUpload;

            if (fu == null || !fu.HasFile)
                return null;

            string ext = Path.GetExtension(fu.FileName).ToLower();

            if (ext != ".pdf" && ext != ".doc" && ext != ".docx")
            {
                lblFileError.Text = "❌ Invalid file type. Please upload PDF/DOC/DOCX files only.";
                lblFileError.Visible = true;
                return null;
            }

            string folderPath = Server.MapPath("~/uploads/modules/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string fileName = $"Module_{moduleNumber}_{Guid.NewGuid()}{ext}";
            string savePath = Path.Combine(folderPath, fileName);
            fu.SaveAs(savePath);

            // --- PDF Conversion using GroupDocs.Viewer 25.x ---
            if (ext == ".pdf")
            {
                string convertedFolder = Server.MapPath("~/ViewerOutput/");
                if (!Directory.Exists(convertedFolder))
                    Directory.CreateDirectory(convertedFolder);

                string htmlFileName = Path.GetFileNameWithoutExtension(fileName) + ".html";
                string htmlPath = Path.Combine(convertedFolder, htmlFileName);

                try
                {
                    using (Viewer viewer = new Viewer(savePath))
                    {
                        HtmlViewOptions options = HtmlViewOptions.ForEmbeddedResources(htmlPath);
                        viewer.View(options);
                    }
                }
                catch
                {
                    // fallback: just return original PDF
                    return $"uploads/modules/{fileName}";
                }

                return $"ViewerOutput/{htmlFileName}";
            }

            return $"uploads/modules/{fileName}";
        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id) return root;
            foreach (Control c in root.Controls)
            {
                Control t = FindControlRecursive(c, id);
                if (t != null) return t;
            }
            return null;
        }
        private void SaveQuizData(MySqlConnection conn, string courseCode, string selectedModule, string quizType)
        {
            if (quizType == "MCQ")
            {
                string[] lines = txtMCQBulk.Text.Trim().Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string line in lines)
                {
                    var parts = line.Split('|');
                    if (parts.Length == 6)
                    {
                        string q = @"INSERT INTO tbl_quizzes 
                            (course_code, module_number, quiz_type, quiz_question, option_a, option_b, option_c, option_d, correct_answer)
                            VALUES (@code, @num, 'MCQ', @q, @a, @b, @c, @d, @correct)";
                        using (MySqlCommand cmd = new MySqlCommand(q, conn))
                        {
                            cmd.Parameters.AddWithValue("@code", courseCode);
                            cmd.Parameters.AddWithValue("@num", selectedModule);
                            cmd.Parameters.AddWithValue("@q", parts[0]);
                            cmd.Parameters.AddWithValue("@a", parts[1]);
                            cmd.Parameters.AddWithValue("@b", parts[2]);
                            cmd.Parameters.AddWithValue("@c", parts[3]);
                            cmd.Parameters.AddWithValue("@d", parts[4]);
                            cmd.Parameters.AddWithValue("@correct", parts[5]);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            else if (quizType == "TF")
            {
                string[] lines = txtTFBulk.Text.Trim().Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string line in lines)
                {
                    var parts = line.Split('|');
                    if (parts.Length == 2)
                    {
                        string q = @"INSERT INTO tbl_quizzes 
                            (course_code, module_number, quiz_type, quiz_question, correct_answer)
                            VALUES (@code, @num, 'TF', @q, @correct)";
                        using (MySqlCommand cmd = new MySqlCommand(q, conn))
                        {
                            cmd.Parameters.AddWithValue("@code", courseCode);
                            cmd.Parameters.AddWithValue("@num", selectedModule);
                            cmd.Parameters.AddWithValue("@q", parts[0]);
                            cmd.Parameters.AddWithValue("@correct", parts[1]);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            else if (quizType == "FIB")
            {
                string[] lines = txtFIBBulk.Text.Trim().Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string line in lines)
                {
                    var parts = line.Split('|');
                    if (parts.Length == 2)
                    {
                        string q = @"INSERT INTO tbl_quizzes 
                            (course_code, module_number, quiz_type, quiz_question, correct_answer)
                            VALUES (@code, @num, 'FIB', @q, @correct)";
                        using (MySqlCommand cmd = new MySqlCommand(q, conn))
                        {
                            cmd.Parameters.AddWithValue("@code", courseCode);
                            cmd.Parameters.AddWithValue("@num", selectedModule);
                            cmd.Parameters.AddWithValue("@q", parts[0]);
                            cmd.Parameters.AddWithValue("@correct", parts[1]);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }

        protected void ddlQuizTypeSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            quiz_mcq.Visible = ddlQuizTypeSelector.SelectedValue == "MCQ";
            quiz_tf.Visible = ddlQuizTypeSelector.SelectedValue == "TF";
            quiz_fib.Visible = ddlQuizTypeSelector.SelectedValue == "FIB";
        }
    }
}




