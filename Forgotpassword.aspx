<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgotpassword.aspx.cs" Inherits="MOOCs.Forgotpassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #0a2472, #007bff);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border-radius: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card shadow p-4" style="width: 400px;">
            <h4 class="text-center fw-bold mb-3">🔐 Forgot Password</h4>
            <p class="text-center text-muted mb-4">
                Enter your email to receive OTP
            </p>

            <!-- EMAIL -->
            <div class="mb-3">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                    Placeholder="Enter your email"></asp:TextBox>
            </div>

            <!-- SEND OTP -->
            <div class="d-grid mb-3">
                <asp:Button ID="btnSendOTP" runat="server" Text="Send OTP"
                    CssClass="btn btn-primary"
                    OnClick="btnSendOTP_Click" />
            </div>

            <!-- OTP SECTION -->
            <asp:Panel ID="pnlOTP" runat="server" Visible="false">
                <div class="mb-3">
                    <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control"
                        Placeholder="Enter OTP"></asp:TextBox>
                </div>

                <div class="d-grid mb-3">
                    <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify OTP"
                        CssClass="btn btn-success"
                        OnClick="btnVerifyOTP_Click" />
                </div>
            </asp:Panel>

            <!-- MESSAGE -->
            <asp:Label ID="lblMessage" runat="server" CssClass="text-center d-block"></asp:Label>

            <div class="text-center mt-3">
                <a href="Login.aspx">← Back to Login</a>
            </div>
        </div>
    </form>
</body>
</html>
