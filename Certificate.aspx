<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Certificate.aspx.cs" Inherits="MOOCs.Certificate" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Certificate</title>

    <link rel="icon" type="image/x-icon" href="images/Favicon-cert.ico" />
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f5f7fa;
        }

        /* ===== HERO WITH BG IMAGE ===== */
        .hero {
            background:
              linear-gradient(rgba(15,23,42,.85), rgba(15,23,42,.85)),
              url('images/spa.jpg') center/cover no-repeat;
            color: white;
            padding: 80px 20px 140px;
            text-align: center;
            position: relative;
        }

        .hero-content {
            max-width: 760px;
            margin: auto;
            animation: fadeSlide 1s ease forwards;
        }

        @keyframes fadeSlide {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

       

        @keyframes float {
            0%,100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .hero-text {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 30px;
            display: block;
        }

        /* ===== BUTTONS (ANIMATED) ===== */
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            min-width: 170px;
            transition: all 0.3s ease;
            animation: popIn 0.8s ease forwards;
        }

        .btn:nth-child(1){ animation-delay: .2s }
        .btn:nth-child(2){ animation-delay: .4s }
        .btn:nth-child(3){ animation-delay: .6s }
        .btn:nth-child(4){ animation-delay: .8s }

        @keyframes popIn {
            from { opacity: 0; transform: scale(.8); }
            to { opacity: 1; transform: scale(1); }
        }

        .btn-view { background: #22c55e; color: #fff; }
        .btn-generate { background: #f59e0b; color: #fff; }
        .btn-pdf { background: #ef4444; color: #fff; }
        .btn-home { background: #3b82f6; color: #fff; }

        .btn:hover {
            transform: translateY(-3px);
            opacity: 0.9;
        }

        /* ===== SVG WAVE ===== */
        .wave {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            overflow: hidden;
            line-height: 0;
        }

        .wave svg {
            width: calc(100% + 1.3px);
            height: 100px;
        }

        .wave path {
            fill: #f5f7fa;
        }

        /* ===== PREVIEW ===== */
        .preview-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 20px 60px;
        }

        .preview {
            max-width: 100%;
            display: none;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0,0,0,.15);
        }

        .preview.show {
            display: block;
            animation: fadeIn .8s ease forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(.95); }
            to { opacity: 1; transform: scale(1); }
        }


        /* ===== FEATURES ===== */
.features {
    background: #f5f7fa;
    display: flex;
    justify-content: center;
    gap: 80px;
    padding: 60px 20px;
    text-align: center;
    flex-wrap: wrap;
}

.feature-box {
    max-width: 220px;
}

.feature-box i {
    font-size: 58px;
    color:  #0a2472;
    margin-bottom: 15px;
}

.feature-box h4 {
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 6px;
    color: #111827;
}

.feature-box p {
    font-size: 14px;
    color: #0a2472;
}

/* MOBILE */
@media (max-width: 768px) {
    .features {
        gap: 40px;
    }
}

    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="hero">
        <div class="hero-content">

        
            <asp:Label ID="lblMessage" runat="server" CssClass="hero-text" />

            <div class="btn-group">
                <asp:Button ID="btnView" runat="server"
                    Text="View Certificate"
                    CssClass="btn btn-view"
                    OnClick="btnView_Click"
                    Visible="false" />

                <asp:Button ID="btnGenerate" runat="server"
                    Text="Generate Certificate"
                    CssClass="btn btn-generate"
                    OnClick="btnGenerate_Click"
                    Visible="false" />

             

                <asp:Button ID="btnHome" runat="server"
                    Text="🏠 Student Profile"
                    CssClass="btn btn-home"
                    PostBackUrl="~/Student page.aspx" />
            </div>
        </div>

        <!-- SVG WAVE -->
        <div class="wave">
            <svg viewBox="0 0 500 150" preserveAspectRatio="none">
                <path d="M0.00,49.98 C150.00,150.00 350.00,-50.00 500.00,49.98 L500.00,150.00 L0.00,150.00 Z"></path>
            </svg>
        </div>
    </div>

    <!-- PREVIEW -->
    <div class="preview-wrapper">
        <asp:Image ID="imgPreview" runat="server" CssClass="preview" />
    </div>

    <!-- FEATURES SECTION -->
<div class="features">
    <div class="feature-box">
        <i class="fa-solid fa-file-lines"></i>
        <h4>Document your skills</h4>
        <p>Improve your career</p>
    </div>

    <div class="feature-box">
        <i class="fa-solid fa-graduation-cap"></i>
        <h4>Study at your own pace</h4>
        <p>Save time and money</p>
    </div>

   <div class="feature-box">
    <i class="fa-solid fa-globe"></i>
    <h4>Learn Anywhere</h4>
    <p>Access courses anytime, anywhere</p>
</div>

</div>


</form>
</body>
</html>
