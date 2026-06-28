<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course.aspx.cs" Inherits="MOOCs.Course" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Courses</title>
     <link rel="icon" type="image/x-icon" href="images/Favicon-Course.ico"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        /* Navbar styling */
        .navbar {
            background: linear-gradient(90deg, #0d6efd, #0a58ca);
        }
        .navbar-brand {
            font-size: 2rem;
            transition: transform 0.2s ease-in-out;
        }
        .navbar-brand:hover {
            transform: scale(1.05);
        }
        .nav-link {
            color: #f8f9fa !important;
            transition: color 0.2s, background-color 0.2s;
            border-radius: 8px;
        }
        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }
        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.25);
            font-weight: bold;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">
    <form id="form1" runat="server" class="flex-grow-1 d-flex flex-column">
            <div class="header" style="display: flex; justify-content: space-between; align-items: center; background-color: #0a2472; color: white; padding: 20px 20px;">
    <a href="Home.aspx" style="font-size: 36px; cursor: pointer; text-decoration: none; color: inherit;">
        &#8592; <!-- ← back arrow -->
    </a>
    <h1 style="margin: 0; text-align: center; flex: 1;">Available Course</h1>
</div>
     
        <!-- ✅ Main Content -->
        <div class="container mt-5 flex-grow-1">
 

            <div class="row" id="courseGrid">
                <asp:Repeater ID="rptCourses" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4 d-flex align-items-stretch">
                            <div class="card shadow-sm border-0 w-100">
                                <img src='<%# Eval("course_image") %>' 
                                     class="card-img-top" alt="Course Image"
                                     style="height:200px;object-fit:cover;" />
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title fw-bold"><%# Eval("course_name") %></h5>
                                    <p class="card-text text-muted flex-grow-1">
                                        <%# Eval("course_description") %>
                                    </p>
                                    <a href="#" 
                                    class="btn btn-success w-100 fw-bold" 
                                    onclick="enrollCourse('<%# Eval("course_code") %>'); return false;">
                                    Click Here To start 👈
                                </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- ✅ Enrollment Confirmation Modal (outside Repeater!) -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Confirm To start</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to enroll in <span id="modalCourseName"></span>?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-success" id="btnConfirmToStart">Yes, Start</button>
      </div>
    </div>
  </div>
              </div>
    </form>

    <!-- ✅ Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        let selectedCourseCode = "";

        function checkEnrollment(courseCode, courseName) {
            selectedCourseCode = courseCode;

            // Call server via AJAX to check if user already enrolled
            fetch(`CheckEnrollment.aspx?course_code=${courseCode}`)
                .then(response => response.text())
                .then(result => {
                    if (result === "enrolled") {
                        // Already enrolled → redirect to module page
                        window.location.href = 'Module.aspx?course_code=' + courseCode;
                    } else {
                        // Not enrolled → show confirmation modal
                        document.getElementById("modalCourseName").innerText = courseName;
                        const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
                        modal.show();
                    }
                });
        }

        document.getElementById("btnConfirmEnroll").onclick = function () {
            // Call server to insert enrollment
            fetch(`EnrollCourse.aspx?course_code=${selectedCourseCode}`)
                .then(response => response.text())
                .then(result => {
                    if (result === "success") {
                        window.location.href = 'Module.aspx?course_code=' + selectedCourseCode;
                    } else {
                        alert("Enrollment failed. Try again!");
                    }
                });
        };
        function enrollCourse(courseCode) {
            fetch('Course.aspx/CheckAndEnroll', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ courseCode: courseCode })
            })
                .then(response => response.json())
                .then(result => {
                    const status = result.d;

                    if (status === "notloggedin") {
                        alert("Please login first!");
                        window.location.href = "Login.aspx";
                    } else if (status === "enrolled") {
                        window.location.href = "Module.aspx?course_code=" + courseCode;
                    } else if (status === "success") {
                        alert("Successful Now You My start!");
                        window.location.href = "Module.aspx?course_code=" + courseCode;
                    } else if (status.startsWith("fail:")) {
                        alert("Enrollment failed: " + status.substring(6));
                    } else {
                        alert("Enrollment failed. Try again!");
                    }
                });
        }

    </script>

    <!-- ✅ Footer -->
    <footer class="bg-dark text-white text-center py-4 mt-auto">
        <div class="container">
            <p class="mb-0">© 2025 My Learning Platform | All Rights Reserved</p>
        </div>
    </footer>

</body>
</html>
