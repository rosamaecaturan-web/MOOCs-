<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Module.aspx.cs" Inherits="MOOCs.Module" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Module</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
   
    <style>
     .navbar 
     { 
         background: linear-gradient(90deg, #0d6efd, #0a58ca); 

     }
     .navbar-brand 
     { 
         font-size: 2rem; transition: transform 0.2s ease-in-out; 

     }
     .navbar-brand:hover
     { 
         transform: scale(1.05);

     }
     .nav-link 
     { 
         color: #f8f9fa !important; transition: color 0.2s, background-color 0.2s; border-radius: 8px; 

     }
     .nav-link:hover 
     {
         background-color: rgba(255, 255, 255, 0.15);

     }
     .nav-link.active 
     { 
         background-color: rgba(255, 255, 255, 0.25); font-weight: bold; 

     }
     .footer 
     { 
         margin-top: 40px; padding: 15px 0;

     }

   
.back-arrow i {
    font-size: 2.5rem;     
    line-height: 1;
    transition: transform 0.2s, color 0.2s;
     
}


     @keyframes heartbeat {
        0% { transform: scale(1); }
        20% { transform: scale(1.1); }
        40% { transform: scale(1); }
        60% { transform: scale(1.1); }
        80% { transform: scale(1); }
        100% { transform: scale(1); }
     }
     .heartbeat 
     { 
         animation: heartbeat 1.5s infinite; 

     }

     .heartbeat {
         animation: heartbeat 1.5s infinite;
     }

      @keyframes heartbeat {
         0% { transform: scale(1); }
         25% { transform: scale(1.1); }
         40% { transform: scale(0.95); }
         60% { transform: scale(1.05); }
         100% { transform: scale(1); }
      }

      .glow-btn {
         animation: glow 2s ease-in-out infinite alternate;
         box-shadow: 0 0 10px #0d6efd;
         border: none;
         color: white !important;
         background-color: #0d6efd !important;
      }

      @keyframes glow {
        from { box-shadow: 0 0 10px #0d6efd, 0 0 20px #0d6efd; }
        to { box-shadow: 0 0 25px #0a58ca, 0 0 45px #0a58ca; }
      }

      .fade-in {
         animation: fadeIn 1.5s ease-in;
      }

      @keyframes fadeIn {
         from { opacity: 0; transform: translateY(20px); }
         to { opacity: 1; transform: translateY(0); }
      }

    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <form id="form1" runat="server" class="flex-grow-1 d-flex flex-column">
    <div class="header" style="display: flex; justify-content: space-between; align-items: center; background-color: #0a2472; color: white; padding: 20px 20px;">
    <a href="course.aspx" style="font-size: 36px; cursor: pointer; text-decoration: none; color: inherit;">
        &#8592; <!-- ← back arrow -->
    </a>
    <h1 style="margin: 0; text-align: center; flex: 1;">Learning Module</h1>
</div>
        <main class="container mt-5 flex-grow-1">
            <asp:Panel ID="pnlCourse" runat="server" CssClass="card shadow-sm p-4">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <asp:Image ID="imgCourse" runat="server" CssClass="img-fluid rounded shadow-sm" />
                    </div>
                    <div class="col-md-8">
                        <h2><asp:Label ID="lblCourseName" runat="server" CssClass="fw-bold"></asp:Label></h2>
                        <p class="text-muted"><asp:Label ID="lblCourseDescription" runat="server"></asp:Label></p>

                        <div class="mt-4">


                           <asp:Repeater ID="rptModules" runat="server">


    <ItemTemplate>
        <div class="module-item mb-3 p-3 border rounded shadow-sm">
            <h5>Module <%# Eval("module_number") %></h5>

            <asp:Button 
                ID="btnModule" 
                runat="server" 
                Text='<%# Convert.ToBoolean(Eval("IsLocked")) ? "Locked" : "Open Module" %>' 
                CssClass='<%# Convert.ToBoolean(Eval("IsLocked")) ? "btn btn-secondary disabled" : "btn btn-primary" %>'
                Enabled='<%# !Convert.ToBoolean(Eval("IsLocked")) %>'
                CommandArgument='<%# Eval("module_id") %>'
                OnCommand="btnModule_Command" />

            <asp:Button 
                ID="btnQuiz" 
                runat="server" 
                Text="Take Quiz"
                Visible="false"
                CssClass="btn btn-success ms-2"
                CommandArgument='<%# Eval("module_id") + "|" + Eval("module_number") + "|" + Eval("course_code") %>'
                OnCommand="btnQuiz_Command" />
        </div>


    </ItemTemplate>
</asp:Repeater>
<asp:Panel ID="pnlCertificate" runat="server" CssClass="text-center mt-4 fade-in" Visible="false">
    <asp:Button 
        ID="btnCertificate" 
        runat="server" 
        Text="🎓 Generate Certificate"
        CssClass="btn btn-warning btn-lg fw-bold heartbeat glow-btn"
        OnClick="btnCertificate_Click" />
</asp:Panel>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlModuleDetails" runat="server" CssClass="mt-4" Visible="false">
                <h4 class="text-primary">📘 Module Title:</h4>
                <asp:Label ID="lblModuleTitle" runat="server" CssClass="fw-bold d-block mb-3 text-center" Style="font-size: 24px;" />
                <h5 class="text-secondary">📝 Module Content:</h5>
                <asp:Literal ID="litModuleContent" runat="server" Mode="PassThrough" />
                <h5 class="text-info mt-3">📎 Attached File:</h5>
                <asp:Literal ID="litFileViewer" runat="server" Mode="PassThrough" />
                <h5 class="text-success mt-4">🎥 Video Title:</h5>
                <asp:Label ID="lblVideoTitle" runat="server" CssClass="fw-bold d-block mb-3 text-center" Style="font-size: 24px;" />
                <asp:Literal ID="litVideo" runat="server" Mode="PassThrough" />
            </asp:Panel>
        </main>
    </form>


    <footer class="bg-dark text-white text-center py-4 mt-auto">
        <div class="container">
            <p class="mb-0">© 2025 My Learning Platform | All Rights Reserved</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
