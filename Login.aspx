<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MOOCs.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>

    <!-- Icons & Fonts -->
    <link rel="icon" type="image/x-icon" href="images/Favicon-login.ico" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <!-- Bootstrap -->
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

        .login-container {
            display: flex;
            background-color: #3584f1;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            max-width: 960px;
            width: 100%;
        }

        .left-panel,
        .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .left-panel {
            background-color: rgba(255,255,255,0.1);
            padding: 30px;
        }

        .left-panel img {
            max-width: 80%;
            height: auto;
        }

        .right-panel {
            padding: 40px 30px;
            background-color: rgba(255,255,255,0.8);
        }

        .login-card {
            width: 100%;
            max-width: 400px;
        }

        .login-card h4 {
            color: #333;
            margin-bottom: 30px;
            font-weight: 600;
            text-align: center;
        }

        .form-control {
            border-radius: 8px;
            height: 50px;
            margin-bottom: 15px;
        }

        .input-group-text {
            background-color: transparent;
            border: none;
            font-size: 18px;
            color: #666;
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

        @media (max-width: 768px) {
            .login-container {
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

    <div class="login-container">

        <!-- LEFT PANEL -->
        <div class="left-panel">
            <img src="images/LogoMoocs.png" alt="Logo" />
        </div>

        <!-- RIGHT PANEL -->
        <div class="right-panel">
            <div class="login-card">

                <h4>LOGIN</h4>
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block text-center mb-3" />

                <!-- EMAIL -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <asp:TextBox ID="txtLoginId" runat="server" CssClass="form-control" Placeholder="Email" />
                </div>

                <!-- PASSWORD -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password" />
                </div>

                <!-- LOGIN BUTTON -->
                <asp:Button ID="btnLogin" runat="server"
                    CssClass="btn btn-primary mb-3"
                    Text="Login"
                    OnClick="btnLogin_Click" />

                <!-- FORGOT PASSWORD LINK -->
                <div class="text-center">
                    <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                        Forgot password?
                    </a>
                </div>

                <!-- FORGOT PASSWORD MODAL -->
                <div class="modal fade" id="forgotPasswordModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <div class="modal-header">
                                <h5 class="modal-title">Forgot Password</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">
                                <asp:Label ID="lblForgotPwdMessage" runat="server" CssClass="text-danger mb-2 d-block" />

                                <!-- STEP 1: EMAIL -->
                                <asp:Panel ID="stepEmail" runat="server" Visible="true">
                                    <label>Email address</label>
                                    <asp:TextBox ID="txtForgotEmail" runat="server"
                                        CssClass="form-control"
                                        Placeholder="Enter your registered email" />

                                    <asp:Button ID="btnSendOTP" runat="server"
                                        CssClass="btn btn-primary mt-2"
                                        Text="Send OTP"
                                        OnClick="btnSendOTP_Click" />
                                </asp:Panel>

                                <!-- STEP 2: OTP + NEW PASSWORD -->
                                <asp:Panel ID="stepOTP" runat="server" Visible="false">

                                    <label>Enter OTP</label>
                                    <asp:TextBox ID="txtOTP" runat="server"
                                        CssClass="form-control"
                                        Placeholder="Enter OTP" />

                                    <small class="text-muted">
                                        OTP expires in
                                        <asp:Label ID="lblOTPCountdown" runat="server" Text="5:00" /> minutes
                                    </small>

                                    <asp:Button ID="btnResendOTP" runat="server"
                                        CssClass="btn btn-link p-0 d-block"
                                        Text="Resend OTP"
                                        OnClick="btnResendOTP_Click" />

                                    <label>New Password</label>
                                    <asp:TextBox ID="txtNewPassword" runat="server"
                                        CssClass="form-control"
                                        TextMode="Password" />

                                    <label>Confirm New Password</label>
                                    <asp:TextBox ID="txtConfirmNewPassword" runat="server"
                                        CssClass="form-control"
                                        TextMode="Password" />

                                    <asp:Button ID="btnChangePassword" runat="server"
                                        CssClass="btn btn-success mt-2"
                                        Text="Change Password"
                                        OnClick="btnChangePassword_Click" />
                                </asp:Panel>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            </div>

                        </div>
                    </div>
                </div>

                <hr />

                <!-- SIGNUP -->
                <div class="text-center">
                    <p>Don't have an account?</p>
                    <asp:Button ID="btnSignup" runat="server"
                        CssClass="btn btn-outline-secondary w-100"
                        Text="Create an account"
                        OnClick="btnSignup_Click" />
                </div>

            </div>
        </div>
    </div>

</form>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
