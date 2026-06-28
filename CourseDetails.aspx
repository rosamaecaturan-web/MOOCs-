<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseDetails.aspx.cs" Inherits="MOOCs.CourseDetails" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Details</title>
       <link rel="icon" type="image/x-icon" href="images/favicon-detail.ico"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
    <style>
        body {
            background-color: #f8f9fa;
           
        }
        .accordion-button {
            background-color: #0d6efd;
            color: white;
        }
        .accordion-button.collapsed {
            background-color: #e7f1ff;
            color: #0d6efd;
        }
        .accordion-body {
            background-color: #ffffff;
        }
        .list-group-item {
            background-color: #f8f9fa;
            margin-bottom: 0.5rem;
            border-radius: 0.3rem;
        }
        .course-image {
            max-width: 150px;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
        }
        .btn {
            min-width: 80px;
        }
        h4, h5 {
            margin-top: 1rem;
        }
        /* Header and footer styling */
        header {
            background-color: #092c54;
            color: white;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        header h1 {
            margin: 0;
            font-size: 1.5rem;
        }
        footer {
            background-color: #092c54;
            color: white;
            text-align: center;
            padding: 1rem;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .back-arrow {
            font-size: 1.5rem;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   <header style="display: flex; align-items: center; justify-content: center; position: relative;">
    <a href="Faculty.aspx" class="text-white" style="position: absolute; left: 20px; text-decoration: none;">
        <i class="bi bi-arrow-left back-arrow"></i>
    </a>
    <h1>Course Details</h1>
</header>



        <div class="container mt-4 mb-5">
            <asp:Repeater ID="rptCourses" runat="server">
                <HeaderTemplate>
                    <div class="accordion" id="coursesAccordion">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="accordion-item mb-3 shadow-sm">
                        <h2 class="accordion-header" id="heading<%# Eval("id") %>">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%# Eval("id") %>" aria-expanded="false">
                                <%# Eval("course_name") %> - <%# Eval("course_code") %>
                            </button>
                        </h2>
                        <div id="collapse<%# Eval("id") %>" class="accordion-collapse collapse" data-bs-parent="#coursesAccordion">
                            <div class="accordion-body">

                                <div class="row mb-3">
                                    <div class="col-md-3">
                                        <asp:Image ID="imgCourse" runat="server" CssClass="course-image img-fluid" ImageUrl='<%# Eval("course_image") %>' />
                                    </div>
                                    <div class="col-md-9">
                                        <p><strong>Description:</strong> <%# Eval("course_description") %></p>
                                    </div>
                                </div>

                                <h4 class="text-secondary">Modules</h4>
                                <asp:Repeater ID="rptModules" runat="server">
                                    <HeaderTemplate><ul class="list-group mb-3"></HeaderTemplate>
                                    <ItemTemplate>
                                        <li class="list-group-item">
                                            <strong>Module <%# Eval("module_number") %>: <%# Eval("module_title") %></strong>
                                            <p><%# Eval("module_content") %></p>

                                            <h5 class="text-info">Videos</h5>
                                            <asp:Repeater ID="rptVideos" runat="server">
                                                <HeaderTemplate><ul class="list-group mb-2"></HeaderTemplate>
                                                <ItemTemplate>
                                                    <li class="list-group-item list-group-item-light"><i class="bi bi-play-circle-fill me-2"></i> <%# Eval("video_title") %></li>
                                                </ItemTemplate>
                                                <FooterTemplate></ul></FooterTemplate>
                                            </asp:Repeater>

                                            <h5 class="text-info">Quizzes</h5>
                                            <asp:Repeater ID="rptQuizzes" runat="server">
                                                <HeaderTemplate><ul class="list-group"></HeaderTemplate>
                                                <ItemTemplate>
                                                    <li class="list-group-item list-group-item-light">
                                                        <%# Eval("quiz_type") %> - <%# Eval("quiz_question") %>
                                                        <ul class="mb-0">
                                                            <li>A: <%# Eval("option_a") %></li>
                                                            <li>B: <%# Eval("option_b") %></li>
                                                            <li>C: <%# Eval("option_c") %></li>
                                                            <li>D: <%# Eval("option_d") %></li>
                                                            <li><strong>Answer:</strong> <%# Eval("correct_answer") %></li>
                                                        </ul>
                                                    </li>
                                                </ItemTemplate>
                                                <FooterTemplate></ul></FooterTemplate>
                                            </asp:Repeater>

                                        </li>
                                    </ItemTemplate>
                                    <FooterTemplate></ul></FooterTemplate>
                                </asp:Repeater>

                                <div class="mt-3">
                                    <asp:Button ID="btnEditCourse" runat="server" Text="Edit" CommandArgument='<%# Eval("id") %>' OnClick="btnEditCourse_Click" CssClass="btn btn-primary me-2"/>
                                    <asp:Button ID="btnDeleteCourse" runat="server" Text="Delete" CommandArgument='<%# Eval("id") %>' OnClick="btnDeleteCourse_Click" CssClass="btn btn-danger"/>
                                </div>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate></div></FooterTemplate>
            </asp:Repeater>
        </div>

        <!-- Footer -->
        <footer>
            &copy; 2025 MOOCs. All rights reserved.
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
