<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="MOOCs.Signup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Signup Page</title>
    <link rel="icon" type="image/x-icon" href="images/favicon-signup.ico"/>

    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background-color: #bbecf5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .signup-container {
            display: flex;
            background-color: #3584f1;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            max-width: 960px;
            width: 100%;
        }

        .left-panel {
            flex: 1;
            background-color: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .left-panel img {
            max-width: 80%;
        }

        .right-panel {
            flex: 1;
            padding: 40px 30px;
            background-color: rgba(255, 255, 255, 0.7);
        }

        .signup-card {
            max-width: 420px;
            margin: auto;
        }

        h4 {
            font-size: 30px;
            font-weight: 700;
            color: #0a2472;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-control {
            height: 48px;
            border-radius: 8px;
            margin-bottom: 12px;
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #555;
        }

        .btn-primary {
            background-color: #6c63ff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            width: 100%;
        }

        .back-to-login {
            display: block;
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
            color: #6c63ff;
        }

        @media (max-width: 768px) {
            .signup-container {
                flex-direction: column;
            }

            .left-panel {
                display: none;
            }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">
    <div class="signup-container">
        <!-- LEFT -->
        <div class="left-panel">
            <img src="images/LogoMoocs.png" alt="Logo" />
        </div>

        <!-- RIGHT -->
        <div class="right-panel">
            <div class="signup-card">
                <h4>REGISTER HERE</h4>

              <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="error-label" />


                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlRole_SelectedIndexChanged">
    <asp:ListItem Text="Select Role" Value="" />
    <asp:ListItem Text="Student" Value="student" />
    <asp:ListItem Text="Faculty" Value="faculty" />
    <asp:ListItem Text="Admin" Value="admin" />
</asp:DropDownList>

                <!-- COMMON -->
                <div id="commonFields" style="display:none;">
                    
                    <div id="facultyField" style="display:none;">
                        <asp:TextBox ID="facultyId" runat="server"
                            CssClass="form-control" Placeholder="Faculty Secret Code" />
                    </div>
                   
                   <asp:TextBox ID="firstName" runat="server" 
                       CssClass="form-control" Placeholder="First Name" />

                    <asp:TextBox ID="lastName" runat="server" 
                        CssClass="form-control" Placeholder="Last Name" />

                    <asp:TextBox ID="email" runat="server"
                        CssClass="form-control" Placeholder="Email Address" />

                    <!-- PASSWORD -->
                    <div class="password-wrapper">
                        <asp:TextBox ID="password" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            Placeholder="Password" />
                        <i class="fa fa-eye" onclick="togglePassword('<%= password.ClientID %>', this)"></i>
                    </div>

                    <!-- CONFIRM PASSWORD -->
                    <div class="password-wrapper">
                        <asp:TextBox ID="confirmPassword" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            Placeholder="Confirm Password" />
                        <i class="fa fa-eye" onclick="togglePassword('<%= confirmPassword.ClientID %>', this)"></i>
                    </div>
                </div>


<!-- Faculty Pending Approval Modal -->
<div class="modal fade" id="facultyModal" tabindex="-1" aria-labelledby="facultyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-info text-white">
        <h5 class="modal-title" id="facultyModalLabel">Registration Pending</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="facultyModalBody">
        <!-- Message injected by C# -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
      </div>
    </div>
  </div>
</div>


                <asp:Button ID="btnSignUp" runat="server"
                    Text="Sign Up"
                    CssClass="btn btn-primary mt-2"
                    OnClick="btnSignUp_Click" />

                <a href="Login.aspx" class="back-to-login">
                    Already have an account? Login
                </a>
            </div>
        </div>
    </div>
</form>

<script>
    function showFields() {
        var ddl = document.getElementById('<%= ddlRole.ClientID %>');
        var common = document.getElementById('commonFields');
        var faculty = document.getElementById('facultyField');
        var admin = document.getElementById('adminField');

        common.style.display = ddl.value ? 'block' : 'none';
        faculty.style.display = ddl.value === 'faculty' ? 'block' : 'none';
        admin.style.display = ddl.value === 'admin' ? 'block' : 'none';
    }

    function togglePassword(inputId, icon) {
        var input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }

    window.onload = showFields;
</script>
    
</body>
</html>
