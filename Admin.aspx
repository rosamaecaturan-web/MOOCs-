<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="MOOCs.Admin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <link rel="icon" type="image/x-icon" href="images/Favicon-Admin.ico"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"/>

<style>
/* ================= GLOBAL STYLES ================= */
html, body {
    height: 100%;
    margin: 0;
    background-color: #f8f9fa;
}

body {
    overflow-x: hidden;
    font-family: Arial, sans-serif;
}

/* ================= SIDEBAR ================= */
.sidebar {
    min-height: 107vh;
    background-color: #092c54;
    color: #fff;
    padding-top: 1rem;
}

.sidebar a {
    color: #fff;
    text-decoration: none;
    padding: 1rem;
    display: block;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.sidebar a.active,
.sidebar a:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

/* ================= MAIN CONTENT ================= */
.main {
    padding: 1rem;
}

/* ================= TOPBAR ================= */
.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

/* ================= STAT CARDS ================= */
.stat-card {
    border-radius: 10px;
    padding: 20px;
    color: #fff;
    text-align: center;
    margin-top: 20px;
    transition: transform 0.2s;
}

.stat-card:hover {
    transform: translateY(-3px);
}

.stat-row .col {
    margin-bottom: 1rem;
}

/* ================= AVATARS ================= */
.student-avatar,
.faculty-avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
}

/* ================= TABLES ================= */
.table img {
    border-radius: 8px;
    width: 200px;
    height: 150px;
    object-fit: cover;
}

.scrollable-table {
    max-height: 400px;
    overflow-y: auto;
}

/* ================= TABS ================= */
.tab-content {
    display: none;
}

.tab-content.active {
    display: block;
}

/* ================= LOG SCROLL CONTAINERS ================= */
.student-log-scroll,
.teacher-log-scroll {
    max-height: 300px; /* pwede usbon (250px, 400px, etc.) */
    overflow-y: auto;
    padding-right: 5px;
}

/* Scrollbar styling (Chrome/Edge) */
.student-log-scroll::-webkit-scrollbar,
.teacher-log-scroll::-webkit-scrollbar {
    width: 6px;
}

.student-log-scroll::-webkit-scrollbar-thumb {
    background-color: #ccc;
    border-radius: 10px;
}

.teacher-log-scroll::-webkit-scrollbar-thumb {
    background-color: #bbb;
    border-radius: 10px;
}

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

.students-scroll-container {
    max-height: 700px;   
    overflow-y: auto;
}

.courses-scroll-container {
    max-height: 700px;  
    overflow-y: auto;
    padding-right: 5px;
}

.teachers-scroll-container {
    max-height: 700px;    
    overflow-y: auto;
    padding-right: 5px;
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
/* ================= MEDIA QUERIES ================= */
@media (max-width: 992px) {
    .stat-card {
        padding: 15px;
        font-size: 14px;
    }
    .table img {
        width: 100%;
        height: auto;
    }
}

@media (max-width: 768px) {
    .sidebar {
        width: 100%;
        padding: 0.5rem 0;
    }
    .topbar {
        flex-direction: column;
        align-items: flex-start;
    }
}

@media (max-width: 576px) {
    .stat-card {
        padding: 8px;
        font-size: 12px;
    }
}
</style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 sidebar p-3 d-flex flex-column" style="height:100vh;">
             <h4 class="text-white text-center fw-bold py-4 px-2">MOOCs</h4>
               

<!-- Centered Admin Info -->
<div class="d-flex justify-content-center align-items-center gap-3 mb-4">
    <!-- Profile Picture Box -->
   <div style="width:80px; height:80px; overflow:hidden; border-radius:10px; border:2px solid #fff;">
    <asp:Image ID="imgAdminProfile" runat="server"
        CssClass="img-fluid"
        ImageUrl="~/uploads/profile/sample-user.png"
        Style="width:100%; height:100%; object-fit:cover;" />
</div>

<div class="d-flex flex-column align-items-start">
    <!-- Admin Name -->
    <asp:Label ID="lblAdminName" runat="server"
        Text="Admin Name"
        CssClass="fw-bold text-white fs-5 mb-0"></asp:Label>
<a href="javascript:void(0);" class="text-white" style="font-size:0.8rem; line-height:1;" 
   data-bs-toggle="modal" data-bs-target="#editAdminModal"
   onclick="javascript:__doPostBack('EditAdmin', '<%= Session["AdminID"] %>');">
    <i class="bi bi-pencil-square"></i>
</a>

<!-- Edit Admin Modal -->
<div class="modal fade" id="editAdminModal" tabindex="-1" aria-labelledby="editAdminModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="editAdminModalLabel">Edit Admin Info</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <asp:HiddenField ID="hfAdminID" runat="server" />
                 <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-2"></asp:Label>

                <div class="mb-3">
                 <asp:Label ID="lblProfilePic" runat="server" Text="Profile Picture"></asp:Label>
                 <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="form-control" />
                 </div>


                <div class="mb-3">
                    <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnSaveAdmin" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSaveAdmin_Click" />
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


</div>

</div>



                    <!-- Navigation -->
                    <nav class="nav flex-column mt-3 flex-grow-1">
                        <a class="nav-link active" href="#" data-target="dashboardContent">🏠 Dashboard</a>
                        <a class="nav-link" href="#" data-target="studentsContent">👥 Students</a>
                        <a class="nav-link" href="#" data-target="teachersContent">🧑‍🏫 Teachers</a>
                        <a class="nav-link" href="#" data-target="coursesContent">📚 Courses</a>
                        <a class="nav-link" href="#" data-target="facultyApprovalContent">✅ Faculty Approval</a>
                    </nav>

                    <!-- Logout -->
                    <div class="mt-auto">
                        <a href="Login.aspx?logout=true" class="btn btn-danger btn-sm w-100">🚪 Logout</a>
                    </div>

                </div>

                <!-- ================= MAIN CONTENT ================= -->
                <div class="col-md-10 main p-3">

                    <!-- ================= DASHBOARD ================= -->
                    <div id="dashboardContent" class="tab-content active">

                        <!-- Stats Cards -->
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="stat-card bg-primary d-flex justify-content-between align-items-center p-3 rounded">
                                    <div>
                                        <h3><asp:Label ID="lblStudents" runat="server" Text="0"></asp:Label></h3>
                                        <p>Students</p>
                                    </div>
                                    <div style="font-size:30px;">🎓</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="stat-card bg-success d-flex justify-content-between align-items-center p-3 rounded">
                                    <div>
                                        <h3><asp:Label ID="lblTeachers" runat="server" Text="0"></asp:Label></h3>
                                        <p>Teachers</p>
                                    </div>
                                    <div style="font-size:30px;">👩‍🏫</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="stat-card bg-warning d-flex justify-content-between align-items-center p-3 rounded">
                                    <div>
                                        <h3><asp:Label ID="lblCourse" runat="server" Text="0"></asp:Label></h3>
                                        <p>Courses</p>
                                    </div>
                                    <div style="font-size:30px;">🏫</div>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Courses + Logs -->
                        <div class="row">

                            <!-- Recent Courses -->
                            <div class="col-md-8">
                                <div class="card p-3 mb-3">
                                    <h5>Recent Courses</h5>
                                    <div class="scrollable-table">
                                        <table class="table table-hover mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Course Code</th>
                                                    <th>Course Name</th>
                                                    <th>Description</th>
                                                    <th>Faculty</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptCourses" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td><%# Eval("course_code") %></td>
                                                            <td><%# Eval("course_name") %></td>
                                                            <td><%# Eval("course_description") %></td>
                                                            <td><%# Eval("faculty_id") ?? Eval("user_id") %></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Students & Teachers Logs -->
                            <div class="col-md-4 d-flex flex-column gap-3">

                                <!-- Students Log -->
                                <div class="card p-3">
                                    <h6>Students Logs</h6>
                                    <div class="student-log-scroll" style="max-height:250px; overflow-y:auto;">
                                        <asp:Repeater ID="rptNewStudents" runat="server">
                                            <ItemTemplate>
                                                <div class="d-flex align-items-center mb-2">
                                                    <asp:Image ID="imgProfile" runat="server"
                                                        ImageUrl='<%# string.IsNullOrEmpty(Eval("profile_pic") as string) ? "/uploads/profile/default.png" : Eval("profile_pic") %>'
                                                        CssClass="student-avatar me-2 rounded-circle" Width="40px" Height="40px"/>
                                                    <div>
                                                        <div class="fw-bold"><%# Eval("fullname") %></div>
                                                        <div class="text-muted small"><%# Eval("email") ?? "-" %></div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>

                                <!-- Teachers Log -->
                                <div class="card p-3">
                                    <h6>Teachers Log</h6>
                                    <div class="teacher-log-scroll" style="max-height:250px; overflow-y:auto;">
                                        <asp:Repeater ID="rptNewTeachers" runat="server">
                                            <ItemTemplate>
                                                <div class="d-flex align-items-center mb-2">
                                                    <asp:Image ID="imgProfile" runat="server"
                                                        ImageUrl='<%# string.IsNullOrEmpty(Eval("profile_pic") as string) ? "/uploads/profile/default.png" : Eval("profile_pic") %>'
                                                        CssClass="faculty-avatar me-2 rounded-circle" Width="40px" Height="40px"/>
                                                    <div>
                                                        <div class="fw-bold"><%# Eval("fullname") %></div>
                                                        <div class="text-muted small"><%# Eval("email") ?? "-" %></div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                <!-- ================= STUDENTS TAB ================= -->
<div id="studentsContent" class="tab-content p-3">

    <!-- Main Container -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Students</h5>
        </div>

        <!-- Scrollable Body -->
        <div class="card-body p-0 students-scroll-container">
            <asp:GridView ID="gvStudents" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-striped table-bordered mb-0"
                OnRowCommand="gvStudents_RowCommand"
                DataKeyNames="user_id">
                <Columns>
                    <asp:BoundField DataField="user_id" HeaderText="ID" />
                    <asp:BoundField DataField="first_name" HeaderText="First Name" />
                    <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-1">
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CommandName="DeleteStudent"
                                    CommandArgument='<%# Eval("user_id") %>'
                                    CssClass="btn btn-danger btn-sm px-2 py-1"
                                    OnClientClick="return confirm('Are you sure you want to delete this student?');" />

                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>

                    <!-- ================= FACULTY APPROVAL TAB ================= -->
                    <div id="facultyApprovalContent" class="tab-content p-3">
                        <h4>Faculty Approval</h4>
                        <p>Here you can approve newly registered faculty members.</p>
                        <asp:GridView ID="gvFacultyApproval" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-striped table-bordered"
                            OnRowCommand="gvFacultyApproval_RowCommand"
                            DataKeyNames="user_id">
                            <Columns>
                                <asp:BoundField DataField="user_id" HeaderText="ID" />
                                <asp:BoundField DataField="first_name" HeaderText="First Name" />
                                <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                                <asp:BoundField DataField="email" HeaderText="Email" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:Button ID="btnApprove" runat="server" Text="Approve"
                                            CommandName="ApproveFaculty"
                                            CommandArgument='<%# Eval("user_id") %>'
                                            CssClass="btn btn-primary btn-sm me-1"
                                            OnClientClick="return confirm('Approve this faculty?');" />
                                        <asp:Button ID="btnIgnore" runat="server" Text="Ignore"
                                            CommandName="IgnoreFaculty"
                                            CommandArgument='<%# Eval("user_id") %>'
                                            CssClass="btn btn-secondary btn-sm"
                                            OnClientClick="return confirm('Ignore this faculty?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                  <!-- ================= TEACHERS TAB ================= -->
<div id="teachersContent" class="tab-content p-3">

    <h4>Teachers</h4>

    <!-- Scrollable Container -->
    <div class="table-responsive teachers-scroll">
        <asp:GridView ID="gvTeachers" runat="server" AutoGenerateColumns="False"
            CssClass="table table-striped table-bordered mb-0"
            OnRowCommand="gvTeachers_RowCommand"
            EmptyDataText="No teachers found">

            <Columns>
                <asp:BoundField DataField="user_id" HeaderText="User ID" ReadOnly="True" />
                <asp:BoundField DataField="first_name" HeaderText="First Name" />
                <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                <asp:BoundField DataField="role" HeaderText="Role" />
                <asp:BoundField DataField="faculty_id_code" HeaderText="Faculty Code" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete"
                            CommandName="DeleteTeacher"
                            CommandArgument='<%# Eval("user_id") %>'
                            CssClass="btn btn-danger btn-sm"
                            OnClientClick="return confirm('Are you sure you want to delete this teacher?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
    </div>
</div>

                    <!-- ================= COURSES TAB ================= -->
                    <div id="coursesContent" class="tab-content p-3">

    <h4>Courses</h4>

    <!-- SCROLLABLE CONTAINER -->
    <div class="courses-scroll-container">

        <asp:Repeater ID="RepeaterCourseGroups" runat="server"
            OnItemDataBound="RepeaterCourseGroups_ItemDataBound">

            <ItemTemplate>

                <h5 class="mb-3 text-primary">
                    Course Code: <%# Eval("course_code") %>
                </h5>

                <div class="row">

                    <asp:Repeater ID="RepeaterCourses" runat="server">
                        <ItemTemplate>

                            <div class="col-6 col-sm-4 col-md-3 col-lg-3 mb-3">
                                <div class="card h-100 shadow-sm" style="font-size:0.85rem;">

                                    <img class="card-img-top"
                                        src='<%# Eval("course_image") %>'
                                        alt='<%# Eval("course_name") %>'
                                        style="height:120px; object-fit:cover;" />

                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title mb-1">
                                            <%# Eval("course_name") %>
                                        </h6>

                                        <p class="card-text mb-2" style="font-size:0.75rem;">
                                            <%# Eval("course_description") %>
                                        </p>

                                        <div class="mt-auto">
                                            <asp:Button runat="server"
                                                Text="Delete"
                                                CssClass="btn btn-danger btn-sm w-100"
                                                CommandName="DeleteCourse"
                                                CommandArgument='<%# Eval("id") %>'
                                                OnClientClick="return confirm('Delete this course?');" />
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>

                </div>

                <hr />

            </ItemTemplate>
        </asp:Repeater>

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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tab switching
        const navLinks = document.querySelectorAll('.sidebar .nav-link');
        const tabContents = document.querySelectorAll('.tab-content');

        navLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                navLinks.forEach(l => l.classList.remove('active'));
                tabContents.forEach(tc => tc.classList.remove('active'));
                this.classList.add('active');
                document.getElementById(this.getAttribute('data-target')).classList.add('active');
            });
        });
    </script>
</body>

</html>
