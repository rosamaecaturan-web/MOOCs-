<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditCourse.aspx.cs" Inherits="MOOCs.EditCourse" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Edit Course</title>
      <link rel="icon" type="image/x-icon" href="images/favicon-edit.ico"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server">
        <div class="container mt-4">

            <h2 class="mb-4">Edit Course</h2>

            <!-- COURSE DETAILS -->
            <div class="card mb-4 p-3">
                <h4>Course Information</h4>
                <asp:Image ID="imgCourse" runat="server" Width="200" CssClass="img-thumbnail mb-3" />
                <div class="mb-3">
                    <label>Course Code</label>
                    <asp:TextBox ID="txtCourseCode" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="mb-3">
                    <label>Course Name</label>
                    <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label>Description</label>
                    <asp:TextBox ID="txtCourseDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                </div>
            </div>

            <!-- MODULE LIST -->
            <div class="card mb-4 p-3">
                <h4>Modules</h4>
                <asp:Repeater ID="rptModules" runat="server">
                    <HeaderTemplate>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Module Title</th>
                                    <th>Content</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><asp:HiddenField ID="hfModuleId" runat="server" Value='<%# Eval("module_id") %>' /></td>
                            <td><asp:TextBox ID="txtModuleTitle" runat="server" CssClass="form-control" Text='<%# Eval("module_title") %>' /></td>
                        <td>
                            <asp:TextBox ID="txtModuleContent" runat="server" CssClass="form-control" 
                            Text='<%# Eval("module_content") %>' TextMode="MultiLine" Rows="6" />
                       </td>


                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- VIDEO LIST -->
            <div class="card mb-4 p-3">
                <h4>Videos</h4>
                <asp:Repeater ID="rptVideos" runat="server">
                    <HeaderTemplate>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Video Title</th>
                                    <th>File</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><asp:HiddenField ID="hfVideoId" runat="server" Value='<%# Eval("video_id") %>' /></td>
                            <td><asp:TextBox ID="txtVideoTitle" runat="server" CssClass="form-control" Text='<%# Eval("video_title") %>' /></td>
                            <td><a href='<%# Eval("video_file_path") %>' target="_blank">View Video</a></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- QUIZ LIST -->
            <div class="card mb-4 p-3">
                <h4>Quizzes</h4>
                <asp:Repeater ID="rptQuizzes" runat="server">
    <HeaderTemplate>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Module #</th>
                    <th>Type</th>
                    <th>Question</th>
                    <th>Correct Answer</th> <!-- New column -->
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td>
                <asp:HiddenField ID="hfQuizId" runat="server" Value='<%# Eval("id") %>' />
            </td>
            <td>
                <asp:DropDownList ID="ddlQuizType" runat="server" CssClass="form-select" SelectedValue='<%# Eval("quiz_type") %>'>
                    <asp:ListItem Value="MCQ" Text="MCQ" />
                    <asp:ListItem Value="TF" Text="True/False" />
                    <asp:ListItem Value="FIB" Text="Fill in the Blank" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="txtQuizQuestion" runat="server" CssClass="form-control" Text='<%# Eval("quiz_question") %>' TextMode="MultiLine" Rows="2" />
            </td>
            <td>
                <asp:TextBox ID="txtCorrectAnswer" runat="server" CssClass="form-control" Text='<%# Eval("correct_answer") %>' />
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

                <!-- Save button OUTSIDE the Repeater -->
                <div class="mb-4">
                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-success" OnClick="btnSaveChanges_Click" />
                </div>
            </div>

        </div>
    </form>
</body>

</html>
