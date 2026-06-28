<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Faculty.aspx.cs" Inherits="MOOCs.Faculty" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Faculty Dashboard</title>
     <link rel="icon" type="image/x-icon" href="images/Favicon-faculty.ico"/>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        body {
    font-family: 'Poppins', sans-serif;
    background-color: #f5f7fb;
    overflow-x: hidden;
}

/* Sidebar */
.sidebar {
    width: 250px;
    height: 100vh;
    background: #092c54;
    color: #fff;
    position: fixed;
    top: 0;
    left: 0;
    padding: 30px 20px;
}

/* Profile Section */
.profile-section {
    text-align: center;
    margin-bottom: 40px;
}
.profile-section img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    margin-bottom: 10px;
}
.profile-section h5 {
    font-weight: 600;
    margin: 5px 0 2px;
}
.profile-section p {
    font-size: 0.9rem;
    color: #c9d4e3;
}

/* Navigation Links */
.nav-link {
    color: #c9d4e3;
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 15px;
    border-radius: 8px;
    transition: background 0.3s;
    cursor: pointer;
}
.nav-link:hover,
.nav-link.active {
    background: #0d6efd;
    color: #fff;
}

/* Main Content */
.main-content {
    margin-left: 270px;
    padding: 40px 50px;
}

/* Dashboard Title */
.dashboard-title {
    font-weight: 600;
    color: #0d2e5a;
}

/* Info Cards */
.info-card {
    background: #fff;
    border-radius: 12px;
    padding: 25px;
    text-align: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    cursor: pointer;
}
.info-card h3 {
    font-weight: 700;
    color: #0d2e5a;
}
.info-card span {
    font-size: 0.9rem;
    color: #6c757d;
}
.info-card i {
    font-size: 1.8rem;
    color: #0d6efd;
}

/* Chart Section */
.chart-section {
    margin-top: 40px;
    background: #fff;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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

.info-card {
        background-color: #f8f9fa; /* light card bg */
        border-radius: 0.5rem;
        padding: 1rem;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .info-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        text-decoration: none;
    }

    .info-card i {
        display: block;
    }

    .info-card h3 {
        font-size: 1.5rem;
    }

    .info-card span {
        font-size: 0.9rem;
    }


@media (max-width: 1200px) {
    .main-content {
        margin-left: 240px;
        padding: 30px 20px;
    }
}

@media (max-width: 992px) {
    .sidebar {
        width: 200px;
        padding: 20px 15px;
    }
    .main-content {
        margin-left: 200px;
        padding: 25px 15px;
    }
    .info-card {
        padding: 20px;
    }
    .profile-section img {
        width: 70px;
        height: 70px;
    }
}

@media (max-width: 768px) {
    .sidebar {
        position: relative;
        width: 100%;
        height: auto;
        padding: 15px;
    }
    .main-content {
        margin-left: 0;
        padding: 20px 10px;
    }
    .row.g-4 > .col-md-3 {
        flex: 0 0 50%;
        max-width: 50%;
        margin-bottom: 20px;
    }
    .chart-section, .profile-card {
        padding: 20px;
    }
}

@media (max-width: 576px) {
    .row.g-4 > .col-md-3 {
        flex: 0 0 100%;
        max-width: 100%;
    }
    .nav-link {
        font-size: 0.9rem;
        padding: 8px 12px;
    }
    .sidebar {
        text-align: center;
    }
    .profile-section h5, .profile-section p {
        font-size: 0.85rem;
    }
}

    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="profile-section">
                <asp:Image ID="imgFacultyProfile" runat="server" CssClass="rounded-circle mb-2" Width="80" Height="80" />
                <h5><asp:Label ID="lblFacultyName" runat="server"></asp:Label></h5>
                <p><asp:Label ID="lblFacultyEmail" runat="server"></asp:Label></p>
            </div>

            <nav class="nav flex-column">
                <asp:LinkButton ID="lnkHome" runat="server" CssClass="nav-link" OnClick="lnkHome_Click">
                    <i class="bi bi-house"></i> Home
                </asp:LinkButton>

                <a href="Upload.aspx" class="nav-link"><i class="bi bi-folder"></i> Add Files</a>

                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="settingsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-gear"></i> Settings
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="settingsDropdown">
                        <li>
                            <asp:LinkButton ID="lnkEditProfile" runat="server" CssClass="dropdown-item" OnClick="lnkEditProfile_Click">
                                <i class="bi bi-pencil-square"></i> Edit Profile
                            </asp:LinkButton>
                        </li>
                        <li>
                            <asp:LinkButton ID="lnkAbout" runat="server" CssClass="dropdown-item" OnClick="lnkAbout_Click">
                                <i class="bi bi-info-circle"></i> About
                            </asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </nav>

            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
        </div>

        <!-- Main Content -->
<div class="main-content">
    <!-- Dashboard -->
    <div ID="divDashboard" runat="server" Visible="false">
        <h3 class="dashboard-title mb-4">Faculty Dashboard</h3>

        <div class="row g-3">
            <!-- Uploaded Courses Card -->
            <div class="col-md-3">
                <asp:LinkButton ID="btnUploadedCourse" runat="server"
                    CssClass="info-card d-flex flex-column align-items-center justify-content-center text-decoration-none w-100"
                    OnClick="btnUploadedCourses_Click">
                    <i class="bi bi-upload mb-2" style="font-size: 2rem; color: #0d6efd;"></i>
                    <h3 class="fw-bold mb-1 text-dark">
                        <asp:Label ID="lblUploadedCourse" runat="server" Text="0"></asp:Label>
                    </h3>
                    <span class="text-muted">Uploaded Courses</span>
                </asp:LinkButton>
            </div>

            <!-- Total Courses Card -->
            <div class="col-md-3">
                <asp:LinkButton ID="btnTotalCourses" runat="server"
                    CssClass="info-card d-flex flex-column align-items-center justify-content-center text-decoration-none w-100"
                    OnClick="btnTotalCourses_Click">
                    <i class="bi bi-book-fill mb-2" style="font-size: 2rem; color: #0d6efd;"></i>
                    <h3 class="fw-bold mb-1 text-dark">
                        <asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label>
                    </h3>
                    <span class="text-muted">Total Courses</span>
                </asp:LinkButton>
            </div>

            <!-- Records Card -->
            <div class="col-md-3">
                <asp:LinkButton ID="btnShowRecords" runat="server"
                    CssClass="info-card d-flex flex-column align-items-center justify-content-center text-decoration-none w-100"
                    OnClick="btnShowRecords_Click">
                    <i class="bi bi-journal-text mb-2" style="font-size: 2rem; color: #198754;"></i>
                    <h3 class="fw-bold mb-1 text-dark">
                        <asp:Label ID="lblRecordCount" runat="server" Text="0"></asp:Label>
                    </h3>
                    <span class="text-muted">Records Of Student</span>
                </asp:LinkButton>
            </div>

            <!-- Students Card -->
            <div class="col-md-3">
                <asp:LinkButton ID="btnShowStudents" runat="server"
                    CssClass="info-card d-flex flex-column align-items-center justify-content-center text-decoration-none w-100"
                    OnClick="btnShowStudents_Click">
                    <i class="bi bi-people-fill mb-2" style="font-size: 2rem; color: #ffc107;"></i>
                    <h3 class="fw-bold mb-1 text-dark">
                        <asp:Label ID="lblStudentCount" runat="server" Text="0"></asp:Label>
                    </h3>
                    <span class="text-muted">Students</span>
                </asp:LinkButton>
            </div>
        </div> <!-- end row -->
    

                <div class="chart-section mt-5">
    <h5 class="fw-semibold mb-3">Results Overview</h5>
    <p class="text-muted mb-4">
        This section provides a summary of student performance across your courses. 
        You can quickly view quiz scores, module completion rates, and overall progress to identify trends and areas for improvement.
    </p>
    <div class="card p-3">
        <canvas id="resultsChart" style="width:100%; height:10px;"></canvas>


       <asp:Panel ID="pnlCourseCards" runat="server" CssClass="row g-4 mt-3" Visible="false">
    <asp:Repeater ID="rptCourseCards" runat="server">
        <ItemTemplate>
            <div class="col-md-3">
                <div class="card">
                    <img src='<%# Eval("CourseImage") %>' class="card-img-top" style="height:150px; object-fit:cover;" />
                    <div class="card-body">
                        <h5 class="card-title"><%# Eval("CourseTitle") %></h5>
                        
                        <!-- View Details Button -->
                        <asp:Button ID="btnViewDetails" runat="server" Text="View Details" CssClass="btn btn-primary btn-sm mt-2"
                                    CommandArgument='<%# Eval("CourseID") %>' OnClick="btnViewDetails_Click" />
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>





                <!-- Grids -->
                <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped" EmptyDataText="No student records found." Visible="false">
                    <Columns>
                        <asp:BoundField DataField="first_name" HeaderText="First Name" />
                        <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                        <asp:BoundField DataField="email" HeaderText="Email" />
                        <asp:BoundField DataField="role" HeaderText="Role" />
                    </Columns>
                </asp:GridView>

              <asp:GridView ID="gvRecords" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
    EmptyDataText="No record data found." Visible="false"
    OnRowDataBound="gvRecords_RowDataBound">
    <Columns>
        <asp:BoundField DataField="user_id" HeaderText="User ID" />
        <asp:BoundField DataField="first_name" HeaderText="First Name" />
        <asp:BoundField DataField="last_name" HeaderText="Last Name" />
        <asp:BoundField DataField="course_code" HeaderText="Course Code" />
        <asp:BoundField DataField="course_name" HeaderText="Course Name" />
        <asp:BoundField DataField="module_number" HeaderText="Module Number" />
        <asp:BoundField DataField="status" HeaderText="Status" />
        <asp:BoundField DataField="quiz_score" HeaderText="Quiz Score" />
    </Columns>
</asp:GridView>


                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped" Visible="false">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="Course ID" />
                        <asp:BoundField DataField="course_code" HeaderText="Course Code" />
                        <asp:BoundField DataField="course_name" HeaderText="Course Name" />
                        <asp:BoundField DataField="course_description" HeaderText="Description" />
                        <asp:TemplateField HeaderText="Course Image">
                            <ItemTemplate><img src='<%# Eval("course_image") %>' width="80" /></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
</div>
            </div>
            <!-- Edit Profile -->
            <div ID="divEditProfile" runat="server" Visible="false">
                <div class="profile-card p-3">
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
                    </div>

                    <asp:Button ID="btnSave" runat="server" Text="Save Profile" CssClass="btn btn-success" OnClick="btnSave_Click" />
                </div>
            </div>

            <!-- About -->
            <div ID="divAbout" runat="server" Visible="false">
                <div class="profile-card p-3 shadow-sm rounded">
                    <h4>About This Faculty Dashboard</h4>
                   <p>
    This Faculty Dashboard is your central hub for managing courses, modules, videos, quizzes, and your profile.
    It is designed to provide faculty members with a simple and organized interface that allows you to efficiently manage all aspects of your teaching activities.
    Through this dashboard, you can easily create new courses, add learning materials such as modules and video lessons, and design quizzes to assess your students' understanding.
    You can also monitor student progress, view records of completed modules and quiz scores, and make informed decisions to improve learning outcomes.
    Additionally, you can update your personal profile, including your name, contact information, and profile picture, ensuring that your information is always up-to-date for students and administrators.
    This dashboard streamlines all your course management tasks in one place, helping you save time, stay organized, and focus more on teaching and supporting your students.
</p>

<h5 class="mt-3">How It Works</h5>
<ul>
    <li>Create and manage courses: Add course details, upload images, and organize course modules.</li>
    <li>Upload learning materials: Add modules, video lessons, and supplementary documents for your students.</li>
    <li>Manage quizzes: Create quizzes for each course and track students' performance.</li>
    <li>View student progress: Access records of students’ module completion and quiz scores.</li>
    <li>Edit profile: Update your name, email, and profile picture directly from the dashboard.</li>
    <li>Stay organized: All courses, materials, and student records are accessible in one place, making it easier to manage your teaching workload.</li>
</ul>

<h5 class="mt-3">Benefits for Faculty</h5>
<p>
    By using this dashboard, faculty members can streamline course management, easily track student engagement, and maintain up-to-date course materials.
    It provides a clear overview of all your courses, students, and their progress, helping you make data-driven decisions to enhance learning experiences.
</p>

                </div>
            </div>

        </div>


        <script type="text/javascript">
            window.onload = function () {
                if (window.history && window.history.replaceState) {
                    window.history.replaceState(null, null, window.location.href);
                }
            };

            window.onpageshow = function (event) {
                if (event.persisted || window.performance && window.performance.navigation.type === 2) {
                    window.location.href = 'Login.aspx';
                }
            };
        </script>

    </form>

</body>
</html>
