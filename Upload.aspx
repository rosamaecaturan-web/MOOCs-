<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="MOOCs.Upload" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Faculty Upload</title>
        <link rel="icon" type="image/x-icon" href="images/Favicon-upload.ico"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
        }
        header, footer {
            background-color: #0a2472;
            color: #fff;
            padding: 15px 0;
        }
        header h1, footer p {
            margin: 0;
            text-align: center;
        }
        label { font-weight: 600; }
        .text-muted { font-size: 0.85rem; }
        .section-card {
            background: #fff;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        input::placeholder, textarea::placeholder {
            color: #aaa;
            font-style: italic;
        }
        h3.section-title {
            color: #0a2472;
            font-weight: 700;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        h3.section-title i {
            color: #0a2472;
        }
        .btn-primary:hover {
            background-color: #06205c;
            transition: background-color 0.3s ease-in-out;
        }

        .square-btn {
            width: 34px;
            height: 34px;
            border-radius: 6px !important;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
         }

        .square-btn i { margin-right: 0; }
        .form-control-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
         }

   
@media (max-width: 768px) {
    .section-card {
        padding: 20px;
        margin-bottom: 20px;
    }

    h3.section-title {
        font-size: 1.4rem;
        gap: 6px;
    }

    input.form-control-sm,
    textarea.form-control-sm {
        font-size: 0.8rem;
        padding: 0.2rem 0.4rem;
    }

    .square-btn {
        width: 30px;
        height: 30px;
    }

    header h1,
    footer p {
        font-size: 1.2rem;
    }
}

/* Small mobile screens */
@media (max-width: 480px) {
    .section-card {
        padding: 15px;
        margin-bottom: 15px;
    }

    h3.section-title {
        font-size: 1.2rem;
        gap: 4px;
    }

    input.form-control-sm,
    textarea.form-control-sm {
        font-size: 0.75rem;
        padding: 0.2rem 0.35rem;
    }

    .square-btn {
        width: 28px;
        height: 28px;
    }

    header h1,
    footer p {
        font-size: 1rem;
    }
}

    </style>
</head>
<body>

    <!-- Header -->
    <div class="header d-flex justify-content-between align-items-center" style="background-color: #0a2472; color: white; padding: 10px 20px;">
        <a href="Faculty.aspx" style="color: white; text-decoration: none; font-size: 24px;">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <h1 class="text-center flex-grow-1">Faculty Course Upload</h1>
    </div>

    <form id="form1" runat="server" class="container mt-5 mb-5">
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>

        <!-- Step 1: Course Info -->
        <div class="section-card">
            <h3 class="section-title"><i class="fa-solid fa-book"></i> Step 1: Course Information</h3>
            <div class="row g-3">
                <div class="col-md-4">
                    <label>Course Code</label>
                    <asp:TextBox ID="txtCourseCode" runat="server" CssClass="form-control" placeholder="e.g., IT101" />
                </div>
                <div class="col-md-8">
                    <label>Course Name</label>
                    <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" placeholder="e.g., Introduction to IT" />
                </div>
                <div class="col-md-6">
                    <label>Course Image</label>
                    <asp:FileUpload ID="fileCourseImage" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6">
                    <label>Course Description</label>
                    <asp:TextBox ID="txtCourseDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Brief description of the course..." />
                </div>
            </div>
        </div>

  <!-- Step 2: Module Info -->
<div class="section-card">
    <h3 class="section-title">
        <i class="fa-solid fa-layer-group"></i> Step 2: Module Information
    </h3>

    <div class="row g-3 align-items-end">

        <!-- Module Selector -->
        <div class="d-flex align-items-end gap-2">
            <div class="flex-grow-1">
                <label class="form-label">Select Module</label>
                <asp:DropDownList 
                    ID="ddlModuleSelector" 
                    runat="server" 
                    CssClass="form-select" 
                    AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlModuleSelector_SelectedIndexChanged">
                    <asp:ListItem Value="1">Module 1</asp:ListItem>
                    <asp:ListItem Value="2">Module 2</asp:ListItem>
                    <asp:ListItem Value="3">Module 3</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:LinkButton 
                ID="btnAddModule" 
                runat="server" 
                CssClass="btn btn-success btn-sm square-btn"
                ToolTip="Add New Module" 
                OnClick="btnAddModule_Click">
                <i class="fa fa-plus"></i>
            </asp:LinkButton>
        </div>

        <!-- Module Title + File Upload (Side by Side) -->
        <div class="col-md-8 d-flex align-items-end gap-3">
            <div class="flex-grow-1">
                <label class="form-label">Module Title</label>
                <asp:TextBox 
                    ID="txtModuleTitle" 
                    runat="server" 
                    CssClass="form-control" 
                    placeholder="e.g., Networking Basics" />
            </div>

            <div style="width: 250px;">
                <label class="form-label small text-muted">
    Upload File (Optional) – PDF only
</label>

<asp:FileUpload 
    ID="fuModuleFile" 
    runat="server" 
    CssClass="form-control form-control-sm" 
    accept=".pdf" />


                <asp:Label 
    ID="lblFileError" 
    runat="server" 
    CssClass="text-danger fw-bold d-block mt-2"
    Visible="false" />


            </div>
        </div>

        <!-- Module 1 -->
        <div class="col-12" id="module1" runat="server" visible="true">
            <label>Module 1 Content</label>
            <asp:TextBox 
                ID="txtModule1Content" 
                runat="server" 
                CssClass="form-control" 
                TextMode="MultiLine" 
                Rows="3" 
                placeholder="Enter content for Module 1..." />
        </div>

        <!-- Module 2 -->
        <div class="col-12" id="module2" runat="server" visible="false">
            <label>Module 2 Content</label>
            <asp:TextBox 
                ID="txtModule2Content" 
                runat="server" 
                CssClass="form-control" 
                TextMode="MultiLine" 
                Rows="3" 
                placeholder="Enter content for Module 2..." />
        </div>

        <!-- Module 3 -->
        <div class="col-12" id="module3" runat="server" visible="false">
            <label>Module 3 Content</label>
            <asp:TextBox 
                ID="txtModule3Content" 
                runat="server" 
                CssClass="form-control" 
                TextMode="MultiLine" 
                Rows="3" 
                placeholder="Enter content for Module 3..." />
        </div>

        <asp:PlaceHolder ID="phModules" runat="server" />
    </div>
</div>

     <!-- Step 3: Video Content -->
<div class="section-card">
    <h3 class="section-title">
        <i class="fa-solid fa-video"></i> Step 3: Video Content
    </h3>
    <div class="row g-3">
        <div class="col-md-6">
            <label>Video Title</label>
            <asp:TextBox 
                ID="txtVideoTitle" 
                runat="server" 
                CssClass="form-control" 
                placeholder="e.g., Introduction Video" />
        </div>
        <div class="col-md-6">
            <label>Upload Video</label>
            <asp:FileUpload 
                ID="fileUploadVideo" 
                runat="server" 
                CssClass="form-control" 
                accept="video/*" />
            <small class="text-muted">
                Allowed: MP4,| Max duration: 2 minutes
            </small>
        </div>
    </div>
</div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const uploadInput = document.querySelector('[id$="fileUploadVideo"]');
                if (!uploadInput) return;

                uploadInput.addEventListener("change", function (e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // ✅ Allowed extensions
                    const allowedExtensions = [".mp4", ".mov", ".avi", ".mkv"];
                    const ext = file.name.substring(file.name.lastIndexOf(".")).toLowerCase();
                    if (!allowedExtensions.includes(ext)) {
                        alert("Invalid file type! Please upload a video file (MP4, MOV, AVI, MKV).");
                        e.target.value = ""; // reset
                        return;
                    }

                    // ✅ Check video duration
                    const video = document.createElement("video");
                    video.preload = "metadata";
                    video.onloadedmetadata = function () {
                        window.URL.revokeObjectURL(video.src);
                        const duration = video.duration;
                        if (duration > 120) { // 120 seconds = 2 minutes
                            alert("Video too long! Maximum allowed duration is 2 minutes.");
                            e.target.value = ""; // reset
                        }
                    };
                    video.src = URL.createObjectURL(file);
                });
            });
        </script>

        <!-- Step 4: Quiz Section -->
        <div class="section-card">
            <h3 class="section-title"><i class="fa-solid fa-pen-to-square"></i> Step 4: Quiz Section</h3>
            <div class="row g-3">
                <div class="col-md-6">
                   <label>Select Quiz Type</label>
                   <asp:DropDownList ID="ddlQuizTypeSelector" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlQuizTypeSelector_SelectedIndexChanged">
                   <asp:ListItem Value="">--SELECT--</asp:ListItem>
                   <asp:ListItem Value="MCQ">Multiple Choice</asp:ListItem>
                   <asp:ListItem Value="TF">True/False</asp:ListItem>
                  <asp:ListItem Value="FIB">Fill in the Blank</asp:ListItem>
                  </asp:DropDownList>

                </div>
            </div>

            <div class="mt-3 p-3 border rounded bg-light" id="quiz_mcq" runat="server" visible="false">
                <h5>Multiple Choice Questions</h5>
                <small class="text-muted">Format: Question|A|B|C|D|CorrectLetter</small>
                <asp:TextBox ID="txtMCQBulk" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" placeholder="Question|A|B|C|D|CorrectLetter" />
            </div>

            <div class="mt-3 p-3 border rounded bg-light" id="quiz_tf" runat="server" visible="false">
                <h5>True/False Questions</h5>
                <small class="text-muted">Format: Question|True/False</small>
                <asp:TextBox ID="txtTFBulk" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" placeholder="Question|True/False" />
            </div>

            <div class="mt-3 p-3 border rounded bg-light" id="quiz_fib" runat="server" visible="false">
                <h5>Fill in the Blank Questions</h5>
                <small class="text-muted">Format: Question with ___|Answer</small>
                <asp:TextBox ID="txtFIBBulk" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" placeholder="Question with ___|Answer" />
            </div>
        </div>

        <!-- Step 5: Submit -->
        <div class="text-center mt-4">
            <asp:Button ID="btnAddCourse" runat="server" Text="Upload Content" CssClass="btn btn-primary btn-lg px-5" OnClick="btnAddCourse_Click" />
            <asp:Label ID="lblStatus" runat="server" CssClass="text-success fw-bold d-block mt-3" />
        </div>
    </form>

    <!-- Footer -->
    <footer class="mt-5">
        <p>&copy; 2025 SPAMAST Faculty Portal. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Confirmation before uploading
        document.getElementById('<%= btnAddCourse.ClientID %>').addEventListener('click', function (e) {
            const confirmUpload = confirm("Are you sure you want to upload this course and its content?");
            if (!confirmUpload) e.preventDefault();
        });

        // File selection alert
        document.querySelectorAll('input[type="file"]').forEach(fileInput => {
            fileInput.addEventListener('change', function () {
                if (this.files.length > 0) {
                    alert("✅ File selected: " + this.files[0].name);
                }
            });
        });

        // Smooth scroll
        document.addEventListener("DOMContentLoaded", function () {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    </script>
</body>
</html>
