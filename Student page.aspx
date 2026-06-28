<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student page.aspx.cs" Inherits="MOOCs.Student_page" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Profile</title>
      <link rel="icon" type="image/x-icon" href="images/favicon-student.ico"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background-color: #f4f6f9;
        }

        header {
            background-color: #0a2472;
            color: white;
            padding: 10px 0;
            text-align: center;
        }

        header h1 {
            font-size: 2rem; 
            letter-spacing: 1px;
        }


        /* Sidebar */
        .sidebar {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            padding: 90px;
            border-radius: 6px;
        }

        .sidebar .nav-link {
            color: white;
            border-radius: 10px;
            margin-bottom: 5px;
        }

        .sidebar .nav-link.active {
            background-color: #fff;
            color: #4158D0;
        }

        .profile-summary {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-summary img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #fff;
        }

        .profile-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 30px;
            min-height: 600px;
        }





        /* Footer Base */
.footer {
    background-color: #111;
    color: #fff;
    padding: 40px 0;
    font-family: Arial, sans-serif;
}

/* Container Layout */
.footer-container {
    max-width: 1100px;
    margin: auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 30px;
    align-items: flex-start;
}

/* Each Column */
.footer-column h2,
.footer-column h3 {
    margin-bottom: 10px;
}

.footer-column p {
    color: #ccc;
}

/* Logo Image Column */
.footer-image {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.footer-image img {
    width: 180px;
    height: auto;
    object-fit: contain;
}

/* Footer Bottom */
.footer-bottom {
    text-align: center;
    color: #777;
    margin-top: 30px;
    font-size: 0.9rem;
    border-top: 1px solid #333;
    padding-top: 15px;
}

/* Responsive */
@media (max-width: 768px) {
    .footer-container {
        text-align: center;
        justify-content: center;
    }
    
    .footer-image {
        justify-content: center;
    }
}
     
        /* Logout Button */
.logout-btn {
    margin-top: 20px;
    width: 100%;
    background: #dc3545;
    color: #fff;
    border: none;
    border-radius: 8px;
    padding: 10px;
    font-weight: 600;
}
.logout-btn:hover {
    background: #b02a37;
}
        @media (max-width: 991px) {
            .sidebar {
                margin-bottom: 20px;
            }
        }

        @media (max-width: 576px) {
            .profile-summary img {
                width: 80px;
                height: 80px;
            }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
<header class="position-relative py-3">
    <a href="home.aspx" class="position-absolute start-0 top-50 translate-middle-y ps-3 text-white" style="font-size: 1.5rem;">
        <i class="bi bi-house-door-fill"></i>
    </a>
    <div class="text-center">
        <h1 class="text-white fw-bold mb-0">Student Dashboard</h1>
    </div>
</header>


    <div class="container-fluid py-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 mb-3">
                <div class="sidebar h-100">
                      
                    <div class="profile-summary">
                        <asp:Image ID="imgSidebarProfile" runat="server" ImageUrl="~/uploads/default.png" CssClass="mb-2" />
                        <h6 class="fw-bold mb-0">
                            <asp:Label ID="lblStudentName" runat="server" Text="Student Name"></asp:Label>
                        </h6>
                        <small>
                            <asp:Label ID="lblStudentCourse" runat="server" Text="BSIT Student"></asp:Label>
                        </small>
                    </div>

                    <div class="nav flex-column nav-pills" id="profileTabs" role="tablist">
                        <a class="nav-link active" data-bs-toggle="pill" href="#overview">Overview</a>
                        <a class="nav-link" data-bs-toggle="pill" href="#courses">Courses</a>
                        <a class="nav-link" data-bs-toggle="pill" href="#modules">Modules</a>
                        <a class="nav-link" data-bs-toggle="pill" href="#certificates">Certificates</a>


                        <div class="dropdown mt-3">
                            <button class="btn btn-light w-100 dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                ⚙ Settings
                            </button>
                            <ul class="dropdown-menu w-100">
                                <li><a class="dropdown-item" data-bs-toggle="pill" href="#editProfile">Edit Profile</a></li>
                                <li><a class="dropdown-item" data-bs-toggle="pill" href="#activity">Activity</a></li>
                                <li><a class="dropdown-item" data-bs-toggle="pill" href="#about">About</a></li>
                            </ul>
                        </div>
                       
                       <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9">
                <div class="tab-content">

       <!-- Overview -->
<div class="tab-pane fade show active" id="overview">
    <div class="profile-card text-center mb-4">
        <h4 class="fw-bold mb-3">Welcome, <asp:Label ID="lblFullName" runat="server" Text="John Doe"></asp:Label>!</h4>
        <p class="bio-overview text-secondary mb-3">
            <asp:Label ID="lblBioOverview" runat="server" Text="Student bio will appear here."></asp:Label>
        </p>
   
        <!-- Courses Section -->
        <div class="row" id="coursesOverview" style="max-height: 600px; overflow-y: auto;">
           <asp:Repeater ID="rptOverviewCourses" runat="server">
    <ItemTemplate>
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card h-100 shadow-sm">
                <img src='<%# Eval("course_image") %>'
                     class="card-img-top"
                     style="height:190px; object-fit:cover;" />

                <div class="card-body">
                    <h5 class="card-title"><%# Eval("course_name") %></h5>
                    <p class="card-text text-muted"><%# Eval("course_description") %></p>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

        </div>
    </div>
</div>


<div class="tab-pane fade" id="courses">
    <div class="profile-card p-4">
        <h4 class="mb-4 fw-bold" style="font-size: 1.75rem;">📚 Courses</h4>

        <div style="max-height: 600px; overflow-y: auto; padding-right: 10px;">
            <div class="row mt-3">
                <asp:Repeater ID="rptCourses" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card course-card h-100 shadow-sm border-0">
                                <div class="card-body d-flex flex-column">
                                    <span class="badge bg-primary mb-2" style="font-size: 0.9rem; padding: 0.4rem 0.8rem;">
                                        <%# Eval("course_code") %>
                                    </span>

                                    <h5 class="card-title mt-2" style="font-size: 1.25rem; font-weight: 600;">
                                        <%# Eval("course_name") %>
                                    </h5>

                                    <p class="card-text text-muted flex-grow-1" style="font-size: 0.95rem; line-height: 1.5;">
                                        <%# Eval("course_description") %>
                                    </p>

                                    <a href="Course.aspx" class="btn btn-outline-primary btn-sm mt-auto" style="font-size: 0.9rem;">
                                        View Course →
                                    </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>


<div class="tab-pane fade" id="modules">
    <div class="profile-card p-4">
        <h4 class="mb-4 fw-bold" style="font-size: 1.75rem;">🗂 Modules</h4>

        <div style="max-height: 800px; overflow-y: auto; padding-right: 10px;">
            <div class="row g-4 mt-3">

                <asp:Repeater ID="rptCoursesModules"
                    runat="server"
                    OnItemDataBound="rptCoursesModules_ItemDataBound">

                    <ItemTemplate>

                        <div class="col-lg-6 col-md-12">
                            <div class="card shadow-sm h-100">
                                <div class="card-body d-flex flex-column">

                                    <!-- COURSE TITLE -->
                                    <h5 class="fw-bold text-primary">
                                        📘 Course: <%# Eval("course_code") %>
                                    </h5>

                                    <span class="badge bg-success mt-2">
                                        Completed
                                    </span>

                                    <!-- MODULE LIST -->
                                    <div class="mt-3">
                                        <asp:Repeater ID="rptModuleList" runat="server">
                                            <ItemTemplate>
                                                <p class="text-muted mb-1">
                                                    <%# Eval("module_title") %> :
                                                    <span class="fw-bold text-dark">
                                                        Score <%# Eval("score") %>
                                                    </span>
                                                </p>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <hr />

                                    <!-- TOTAL SCORE -->
                                    <p class="text-muted fw-bold mb-2">
                                        Total Score:
                                        <asp:Label ID="lblScore" runat="server"></asp:Label>
                                    </p>

                                </div>
                            </div>
                        </div>

                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>
</div>


      <div class="tab-pane fade" id="certificates">
    <div class="profile-card p-4">
        <h4 class="mb-4 fw-bold" style="font-size: 1.75rem;">🏆 Certificates</h4>

        <div style="max-height: 800px; overflow-y: auto; padding-right: 10px;">
            <div class="row g-4">
                <asp:Repeater ID="rptCertificates" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6">
                            <div class="card certificate-card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                                <div class="card-body d-flex flex-column p-3 text-center">

                                    <img src='<%# ResolveUrl(Eval("file_path").ToString()) %>' 
                                         class="img-fluid rounded mb-3 certificate-img"
                                         style="cursor:pointer; max-height:200px; object-fit:contain;"
                                         data-bs-toggle="modal"
                                         data-bs-target="#certificateModal"
                                         data-src='<%# ResolveUrl(Eval("file_path").ToString()) %>' />

                                    <!-- Course Code -->
                                    <h6 class="fw-semibold mb-1"><%# Eval("course_code") %></h6>

                                    <!-- Date Issued -->
                                    <p class="text-muted mb-3" style="font-size:0.9rem;">
                                        Issued: <%# Eval("date_issued", "{0:MMMM dd, yyyy}") %>
                                    </p>

                                    <!-- Download Button -->
                                    <a href='<%# ResolveUrl(Eval("file_path").ToString()) %>' 
                                       class="btn btn-primary btn-sm mt-auto rounded-pill" 
                                       download
                                       style="font-size:0.85rem; padding:0.35rem 0.8rem;">
                                        Download
                                    </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>


<!-- Certificate Modal -->
<div class="modal fade" id="certificateModal" tabindex="-1" aria-labelledby="certificateModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-body text-center">
                <img id="modalCertificateImg" src="" class="img-fluid rounded" />
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <a id="btnDownloadModal" class="btn btn-primary" download>Download</a>
            </div>
        </div>
    </div>
</div>

<script>
    // Show clicked certificate in modal
    document.addEventListener('DOMContentLoaded', function () {
        const certificateImages = document.querySelectorAll('.certificate-img');
        const modalImg = document.getElementById('modalCertificateImg');
        const btnDownloadModal = document.getElementById('btnDownloadModal');

        certificateImages.forEach(img => {
            img.addEventListener('click', function () {
                const src = this.getAttribute('data-src');
                modalImg.src = src;
                btnDownloadModal.href = src;
            });
        });
    });
</script>


                    <!-- Edit Profile -->
                    <div class="tab-pane fade" id="editProfile">
                        <div class="profile-card">
                            <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
                            <h4 class="fw-bold mb-3">Edit Profile</h4>

                            <asp:Image ID="imgProfilePic" runat="server" CssClass="d-block mx-auto mb-3 rounded-circle border" Width="120" Height="120" />
                            <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="form-control mb-3" />

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">First Name</label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Last Name</label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone</label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Bio</label>
                                    <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                                </div>
                            </div>

                            <asp:Button ID="btnSave" runat="server" Text="Save Profile" CssClass="btn btn-success" OnClick="btnSave_Click" />
                        </div>
                    </div>

                   <!-- Activity -->
<div class="tab-pane fade" id="activity">
    <div class="profile-card">
        <h4>Recent Activity</h4>

        <!-- Message when there is no activity -->
        <asp:PlaceHolder ID="phNoActivity" runat="server">
            <p class="text-muted">No recent activity yet.</p>
        </asp:PlaceHolder>

        <!-- Activity Repeater -->
        <asp:Repeater ID="rptActivity" runat="server">
    <ItemTemplate>
        <div class="border-bottom pb-2 mb-2">
            <strong>Profile Update</strong>
            <pre style="white-space:pre-wrap; font-size:14px;"><%# Eval("action_details") %></pre>
            <small class="text-muted">
                <%# 
    Eval("activity_time") == DBNull.Value 
    || Eval("activity_time") is byte[]
        ? "No Date Recorded"
        : Convert.ToDateTime(Eval("activity_time")).ToString("MMM dd, yyyy hh:mm tt")
%>

            </small>
        </div>
    </ItemTemplate>
</asp:Repeater>

    </div>
</div>

                    <!-- About -->
                 <div class="tab-pane fade" id="about">
    <div class="profile-card">
        <h4>About This System</h4>
        <p>
            This Student Learning Dashboard serves as your central hub for managing your academic activities.
            It provides an organized, user-friendly interface that keeps all your learning resources accessible
            in one place.
        </p>

        <h5 class="mt-3">What You Can Do Here</h5>
        <ul>
            <li>Update and personalize your profile information.</li>
            <li>Browse available courses and enroll easily.</li>
            <li>Access modules, view lessons, and watch course videos.</li>
            <li>Take quizzes and track your learning progress.</li>
            <li>Download certificates after completing courses.</li>
            <li>See your recent activities and changes in your profile.</li>
        </ul>

        <h5 class="mt-3">Why This Dashboard Helps You</h5>
        <p>
            The system is designed to support self-paced learning and make your academic journey smooth.
            Everything you need—from lessons to assessments—is organized to help you stay motivated,
            productive, and informed.
        </p>

        <h5 class="mt-3">Need Help?</h5>
        <p>
            If you encounter issues or have questions, feel free to contact your instructor or system
            administrator for support.
        </p>
    </div>
</div>

                </div>
            </div>
        </div>
    </div>

         <footer id="footer" class="footer">
    <div class="footer-container">
        
        <!-- Logo + Tagline -->
        <div class="footer-column">
            <h2>MOOCs Learning Hub</h2>
            <p>Learn. Grow. Succeed.</p>
        </div>

        <!-- Contact -->
        <div class="footer-column">
            <h3>Contact Us</h3>
            <p>Email: info@moocs.edu</p>
            <p>Phone: 09603160606</p>
        </div>

        <!-- Logo Image -->
        <div class="footer-column footer-image">
            <img src="images/Lo.png" alt="MOOCs Logo" />
        </div>
    </div>

    <div class="footer-bottom">
        &copy; 2025 MOOCs. All rights reserved.
    </div>
</footer>
</form>

<script>
    // Live preview of uploaded profile image
    const fileUpload = document.getElementById('<%= fuProfilePic.ClientID %>');
    const profileImg = document.getElementById('<%= imgProfilePic.ClientID %>');
    if (fileUpload) {
        fileUpload.addEventListener('change', function () {
            if (fileUpload.files && fileUpload.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) { profileImg.src = e.target.result; };
                reader.readAsDataURL(fileUpload.files[0]);
            }
        });
    }
</script>


     <script type="text/javascript">
         window.onload = function () {
             // Prevent cached back navigation
             if (performance && performance.navigation.type === 3) {
                 location.href = 'login.aspx';
             }
         };

         window.onpageshow = function (event) {
             if (event.persisted) {
                 location.href = 'login.aspx';
             }
         };
     </script>
</body>
</html>