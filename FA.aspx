<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FA.aspx.cs" Inherits="MOOCs.FA" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Signup Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
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
        .left-panel, .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .left-panel {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 30px;
        }
        .left-panel img {
            max-width: 80%;
            height: auto;
        }
        .right-panel {
            padding: 40px 30px;
            background-color: rgba(255, 255, 255, 0.6);
        }
        .signup-card {
            width: 100%;
            max-width: 400px;
        }
        .signup-card h4 {
            font-family: 'Quicksand', sans-serif;
            font-size: 32px;
            font-weight: 700;
            color: #0a2472;
            text-align: center;
            margin-bottom: 20px;
            text-transform: uppercase;
        }
        .form-control {
            border: 1px solid #ccc;
            border-radius: 8px;
            height: 50px;
            margin-bottom: 10px;
        }
        .btn-primary {
            background-color: #6c63ff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #574b90;
        }
        .back-to-login {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            color: #6c63ff;
            text-align: center;
        }
        .back-to-login:hover {
            text-decoration: underline;
        }
        @media (max-width: 768px) {
            .signup-container { flex-direction: column; }
            .left-panel { display: none; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <div class="left-panel">
                  <img src="images/Lo.png" alt="Course Navigator Logo" />
            </div>
            <div class="right-panel">
                <div class="signup-card">
                    <h4>REGISTER HERE!</h4>
                    
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control" AutoPostBack="false" onchange="showFields()">
                        <asp:ListItem Text="Select Role" Value="" />
                        <asp:ListItem Text="Faculty" Value="faculty" />
                        <asp:ListItem Text="Admin" Value="admin" />
                    </asp:DropDownList>

                    <div id="commonFields" style="display:none;">
                        <asp:TextBox ID="fullName" runat="server" CssClass="form-control" Placeholder="Full Name" /><br />
                        <asp:TextBox ID="email" runat="server" CssClass="form-control" Placeholder="Email" /><br />
                        <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password" /><br />
                        <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Confirm Password" /><br />
                    </div>

                    <div id="facultyField" style="display:none;">
                        <asp:TextBox ID="facultyId" runat="server" CssClass="form-control" Placeholder="Faculty ID" /><br />
                    </div>

                    <!-- Hidden Admin ID -->
                    <asp:TextBox ID="adminId" runat="server" CssClass="form-control" Text="ADMIN001" Visible="false" />

                    <script>
                        function showFields() {
                            var ddl = document.getElementById('<%= ddlRole.ClientID %>');
                            var commonDiv = document.getElementById('commonFields');
                            var facultyDiv = document.getElementById('facultyField');
                            if (ddl.value === 'faculty') {
                                commonDiv.style.display = 'block';
                                facultyDiv.style.display = 'block';
                            } else if (ddl.value === 'admin') {
                                commonDiv.style.display = 'block';
                                facultyDiv.style.display = 'none';
                            } else {
                                commonDiv.style.display = 'none';
                                facultyDiv.style.display = 'none';
                            }
                        }
                        window.onload = showFields;
                    </script>

                    <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="btn btn-primary" OnClick="btnSignUp_Click" /><br />
                    <a href="login.aspx" class="back-to-login">Already have an account? Login</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
