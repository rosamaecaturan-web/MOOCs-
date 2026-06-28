<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RenderPdfAsImages.aspx.cs" Inherits="MOOCs.RenderPdfAsImages" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PDF Viewer</title>

    <style>
        body {
            margin: 0;
            padding: 20px;
            background: #f8f9fa;
        }
    </style>

    <script>
        // Disable right click
        document.addEventListener("contextmenu", e => e.preventDefault());

        // Disable Ctrl+S / Ctrl+P / PrintScreen
        document.addEventListener("keydown", function (e) {
            if ((e.ctrlKey && (e.key === 's' || e.key === 'p')) || e.key === 'PrintScreen') {
                e.preventDefault();
            }
        });
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:Literal ID="litViewer" runat="server" Mode="PassThrough" />
    </form>
</body>
</html>