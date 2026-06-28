<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestQuiz.aspx.cs" Inherits="MOOCs.TestQuiz" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz UI</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background:  #007bff;
            margin: 0;
            padding: 20px 0;
        }


      .quiz-box {
            width: 90%;
            background: rgba(255, 255, 255, 0.42);
            border-radius: 15px;
            padding: 30px;
            box-sizing: border-box;
            margin: 0 auto 20px;

            position: relative;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
       }


        .quiz-box::before {
            content: "";
            position: absolute;
            top: 5px;
            left: 20px;
            right: 20px;
            bottom: 15px;
            border: 8px solid #9ca3af;
            border-radius: 12px;
            pointer-events: none;
    
        }
        .quiz-box h1 {
            text-align: center;
            margin-bottom: 10px;
        }
        .quiz-title {
            font-size: 20px;
            font-weight: 800;
            text-align: center;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }

        .quiz-subtitle {
            font-size: 10px;
            font-weight: 400;
            text-align: center;
            line-height: 1.5;
            max-width: 100px;
            margin: 0 auto 20px auto;
        }

        .question {
            background: rgba(255, 255, 255, 0.6);
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;

            height: 200px;
            overflow-y: auto;

            display: flex;
            flex-direction: column;
            justify-content: flex-start;

            box-sizing: border-box;

            border: 2px solid #007bff; /* 👉 LINE FRAME */
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            justify-content: space-between;
            margin-inline-end:10px;
            margin-inline-start:10px;

        }

        .col-md-6 {
            flex: 1 1 calc(50% - 20px); /* 2 columns */
            max-width: calc(50% - 20px);
            box-sizing: border-box;
        }

        /* Tablet view */
        @media (max-width: 992px) {
            .col-md-6 {
                flex: 1 1 100%; /* 1 column */
                max-width: 100%;
            }
        }
       

        .question h4 {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .choices {
            flex-grow: 1;
            padding-right: 20px;
     
        }
        .choices input[type="radio"] {
           
            margin-inline-start: 24px;
           
        }

        /* BUTTON */
        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-submit {
            display: inline-block;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            background-color: #0a2472;
            color: #fff;
            border: none;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background-color: #007bff;
        }
   
        .wave-container {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 50px 20px;
            background: linear-gradient(135deg, #17b3f8, #00c6ff);
            color: white;
            text-align: center;
            overflow-y: auto;
            z-index: 9999;
            opacity: 0;
            transition: opacity 0.5s ease;
            font-family: 'Segoe UI', sans-serif;
            margin-inline-end: 50px;
        }

        .wave-container.show {
            opacity: 1;

        }

        /* Title and Subtitle */
        .wave-title {
            font-size: 40px;
            font-weight: 700;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.3);
            margin-bottom: 10px;
        }



        .wave-subtitle {
            font-size: 22px;
            margin-bottom: 40px;
            color: #e0f7ff;
        }


        #waveDetails {
            list-style: none;
            padding: 0;
            margin: 5px 0;
            font-family: 'Segoe UI', sans-serif;

        }

        #waveDetails li {
            background: #f4f8ff;
            margin-bottom: 10px;
            padding: 10px 12px;
            border-left: 5px solid #007bff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            transition: 0.3s ease;
            font-size: 17px;
            width: 100%; 
        }

        #waveDetails li:hover {
            background: #e6f0ff;
            transform: translateX(5px);
        }

        #waveDetails li strong {
            color: #0a2472;
            font-size: 15px;
        }
        /* Score Bar */
        .score-bar-container {
            position: relative;
            width: 60%;
            height: 25px;
            margin: 0 auto 40px;
            background: rgba(255,255,255,0.2);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }

        .score-bar {
            width: 0%;
            height: 100%;
            background: linear-gradient(90deg, #ffcb05, #ff5c5c);
            border-radius: 15px;
            transition: width 1s ease-in-out;
        }

        .score-percent {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            font-weight: bold;
            color: white;
        }

        /* Cards */
        .card-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-bottom: 100px;
        }

        .card {
            background: #fff;
            color: #000;
            padding: 30px 50px;
            border-radius: 20px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
            width: 500px;
        }
        @keyframes scaleIn {
            to { transform: scale(1); }
        }

       .retry-btn {
            display: inline-block; /* para dili mag full width */
            margin: 10px 10px 10px 0; /* spacing between buttons */
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 10px;
            border: none;
            background: #fff;
            color: #0a2472;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .retry-btn:hover {
            background: #ffcb05;
            color: #fff;
            transform: scale(1.05);
        }
        .course-text {
            color: #000 !important; /* force black */
        }

        .quiz-header {
            background: #0a2472;  
            padding: 15px;       
            border-radius: 0;       
            text-align: center;
            margin-inline-start: -2%;
            margin-top: -45px;
            margin-bottom: 50px;
            width: 104%;          
            position: relative;  
            left: 0;               
            box-sizing: border-box; 
            color: #ffffff;
         }


        .quiz-logo {
            position: absolute;
            left: 50px;
            top: 50%;
            transform: translateY(-50%);
    
            width: 140px;
            height: 140px;

            object-fit: cover;
            object-position: center; 
        }
        .courses-card-modern {
            background: rgba(255,255,255,0.6);
            color: #000;
            border-radius: 20px;
            padding: 30px 40px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', sans-serif;
            width: 100%;
            max-width: 700px;
            margin-top: -70px;
   
        }

        .courses-card-modern h5 {
            text-align: left; 
            font-size: 1.5em;
            font-weight: 500;
            color:#0a2472;
            margin-bottom: 30px;
        }

        .courses-card-modern ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* two columns */
            gap: 5px 10px;
            justify-items: start; /* left-align items in card */
        }

        .courses-card-modern li {
            display: flex;
            justify-content: space-between;
            background: #fff;
            padding: 12px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            font-weight: 600;
       
        }

        .courses-card-modern li:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }

        .course-name {
            color: #333;
        }

        .course-score {
            font-weight: 700;
            color: #007bff;
        }


        .modern-bulletin {
            width: 90%;
            max-width: 700px;
            background: rgba(255,255,255,0.6);
            backdrop-filter: blur(10px);
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        /* Title */
        .bulletin-title {
            margin-bottom: 20px;
            font-weight: bold;
            color: #0a2472;
        }

        /* Card */
        .course-card {
            background: #fff;
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: 0.3s;
        }

        .course-card:hover {
            transform: translateY(-3px);
        }

        /* Info */
        .course-info {
            display: flex;
            align-items: center;
            gap: 15px;
            justify-content: space-between;
        }

        .course-rank {
            font-size: 22px;
        }

        .course-name {
            display: block;
            font-weight: bold;
            color: #333;
        }

        .course-score {
            font-size: 14px;
            color: #666;
        }


        .progress-bar {
            width: 100%;
            height: 25px;
            background: #e9ecef;
            border-radius: 50px;
            margin-top: 12px;
            overflow: hidden;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
        }


        .progress::after {
            content: "";
            position: absolute;
            top: 0;
            left: -40%;
            width: 40%;
            height: 100%;
            background: rgba(255,255,255,0.4);
            transform: skewX(-20deg);
            animation: shine 2s infinite;
        }

        @keyframes shine {
            0% { left: -40%; }
            100% { left: 120%; }
        }

        .progress {
            height: 10px;
            width: 0%;
            border-radius: 5px;
            transition: width 0.5s ease;
        }

        .gold {
            background: linear-gradient(90deg, #FFD700, #FFB300, #FFC107);
        }

        .silver {
            background: linear-gradient(90deg, #B0BEC5, #90A4AE, #CFD8DC);
        }

        .bronze {
            background: linear-gradient(90deg, #CD7F32, #A97142, #8D5524);
        }

        .progress[style*="width"] {
            box-shadow: 0 0 12px rgba(0,0,0,0.2);
        }

        .gold[style*="width"] {
            box-shadow: 0 0 12px rgba(255, 193, 7, 0.6);
        }

        .silver[style*="width"] {
            box-shadow: 0 0 12px rgba(144, 164, 174, 0.5);
        }

        .bronze[style*="width"] {
            box-shadow: 0 0 12px rgba(141, 85, 36, 0.5);
        }
</style>
</head>
<body>
<form id="form1" runat="server">
   <div class="quiz-box">
   <div class="quiz-header">
    <img src="images/LOGO.png" alt="MOOCs Logo" class="quiz-logo"/>
    <h1>Quiz Assessment</h1>
</div>
       <div id="quizPage1">
    <div class="row">
        <div class="col-md-6">

            <div class="question">
                <h4>1. I enjoy working with computers</h4>
                <asp:RadioButtonList ID="q1" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>2. I enjoy teaching others</h4>
                <asp:RadioButtonList ID="q2" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>3. I like solving math problems</h4>
                <asp:RadioButtonList ID="q3" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <div class="col-md-6">

            <div class="question">
                <h4>4. I enjoy outdoor activities</h4>
                <asp:RadioButtonList ID="q4" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>5. I enjoy creative activities</h4>
                <asp:RadioButtonList ID="q5" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>6. I enjoy science experiments</h4>
                <asp:RadioButtonList ID="q6" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>
     <!-- QUIZ PAGE 2 -->
<div id="quizPage2" style="display:none;">
    <div class="row">
        <div class="col-md-6">

            <div class="question">
                <h4>7. I enjoy organizing activities</h4>
                <asp:RadioButtonList ID="q7" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>8. I like working with numbers</h4>
                <asp:RadioButtonList ID="q8" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>9. I enjoy writing or communication</h4>
                <asp:RadioButtonList ID="q9" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <div class="col-md-6">

            <div class="question">
                <h4>10. I enjoy helping people</h4>
                <asp:RadioButtonList ID="q10" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>11. I enjoy working with machines</h4>
                <asp:RadioButtonList ID="q11" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>12. I like learning new technologies</h4>
                <asp:RadioButtonList ID="q12" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>
       <!-- QUIZ PAGE 3 -->
<div id="quizPage3" style="display:none;">
    <div class="row">
        <div class="col-md-6">

            <div class="question">
                <h4>13. I enjoy speaking in public</h4>
                <asp:RadioButtonList ID="q13" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>14. I enjoy working with communities</h4>
                <asp:RadioButtonList ID="q14" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>15. I enjoy business-related activities</h4>
                <asp:RadioButtonList ID="q15" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <div class="col-md-6">

            <div class="question">
                <h4>16. I enjoy research and investigation</h4>
                <asp:RadioButtonList ID="q16" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>17. I enjoy environmental activities</h4>
                <asp:RadioButtonList ID="q17" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>18. I enjoy working with children</h4>
                <asp:RadioButtonList ID="q18" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>
        </div>
    </div>
</div>
       <!-- QUIZ PAGE 4 -->
<div id="quizPage4" style="display:none;">
    <div class="row">
        <div class="col-md-6">

            <div class="question">
                <h4>19. I enjoy working with plants and animals</h4>
                <asp:RadioButtonList ID="q19" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>20. I enjoy leadership roles</h4>
                <asp:RadioButtonList ID="q20" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>21. I enjoy planning projects</h4>
                <asp:RadioButtonList ID="q21" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <div class="col-md-6">

            <div class="question">
                <h4>22. I enjoy technical tasks</h4>
                <asp:RadioButtonList ID="q22" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>23. I enjoy helping solve social problems</h4>
                <asp:RadioButtonList ID="q23" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>24. I enjoy marine or water-related activities</h4>
                <asp:RadioButtonList ID="q24" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>

<!-- QUIZ PAGE 5 -->
<div id="quizPage5" style="display:none;">
  <div class="row">
    <div class="col-md-6">

        <div class="question">
            <h4>25. I enjoy hands-on activities</h4>
            <asp:RadioButtonList ID="q25" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList> 
        </div>

        <div class="question">
            <h4>26. I easily understand computer concepts</h4>
            <asp:RadioButtonList ID="q26" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

        <div class="question">
            <h4>27. I am good at explaining lessons</h4>
            <asp:RadioButtonList ID="q27" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

    </div>

    <div class="col-md-6">

        <div class="question">
            <h4>28. I am good at mathematics</h4>
            <asp:RadioButtonList ID="q28" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

        <div class="question">
            <h4>29. I learn science concepts easily</h4>
            <asp:RadioButtonList ID="q29" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

        <div class="question">
            <h4>30. I can solve technical problems</h4>
            <asp:RadioButtonList ID="q30" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

    </div>
  </div>
</div>

<!-- QUIZ PAGE 6 -->
<div id="quizPage6" style="display:none;">
  <div class="row">
    <div class="col-md-6">

        <div class="question">
            <h4>31. I communicate clearly in writing</h4>
            <asp:RadioButtonList ID="q31" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList> 
        </div>

        <div class="question">
            <h4>32. I am good at organizing tasks</h4>
            <asp:RadioButtonList ID="q32" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

        <div class="question">
            <h4>33. I analyze problems carefully</h4>
            <asp:RadioButtonList ID="q33" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

    </div>

    <div class="col-md-6">

        <div class="question">
            <h4>34. I understand environmental issues</h4>
            <asp:RadioButtonList ID="q34" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

        <div class="question">
            <h4>35. I learn new skills quickly</h4>
            <asp:RadioButtonList ID="q35" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

        <div class="question">
            <h4>36. I understand business concepts</h4>
            <asp:RadioButtonList ID="q36" runat="server" CssClass="choices">
                <asp:ListItem Text="Strongly Agree" Value="5" />
                <asp:ListItem Text="Agree" Value="4" />
                <asp:ListItem Text="Neutral" Value="3" />
                <asp:ListItem Text="Disagree" Value="2" />
                <asp:ListItem Text="Strongly Disagree" Value="1" />
            </asp:RadioButtonList>
        </div>

    </div>
  </div>
</div>

<!-- QUIZ PAGE 7 -->
<div id="quizPage7" style="display:none;">
    <div class="row">
        <div class="col-md-6">

            <div class="question">
                <h4>37. I work well with people</h4>
                <asp:RadioButtonList ID="q37" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList> 
            </div>

            <div class="question">
                <h4>38. I am good at decision making</h4>
                <asp:RadioButtonList ID="q38" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>39. I can lead group activities</h4>
                <asp:RadioButtonList ID="q39" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <div class="col-md-6">

            <div class="question">
                <h4>40. I pay attention to details</h4>
                <asp:RadioButtonList ID="q40" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>41. I can work independently</h4>
                <asp:RadioButtonList ID="q41" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>42. I adapt easily to new situations</h4>
                <asp:RadioButtonList ID="q42" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>
 
<!-- QUIZ PAGE 8 -->
<div id="quizPage8" style="display:none;">
    <div class="row">
        <div class="col-md-6">

            <div class="question">
                <h4>43. I manage time effectively</h4>
                <asp:RadioButtonList ID="q43" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList> 
            </div>

            <div class="question">
                <h4>44. I am good at research</h4>
                <asp:RadioButtonList ID="q44" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>45. I can understand complex topics</h4>
                <asp:RadioButtonList ID="q45" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <div class="col-md-6">

            <div class="question">
                <h4>46. I work well under pressure</h4>
                <asp:RadioButtonList ID="q46" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>47. I am good at communication</h4>
                <asp:RadioButtonList ID="q47" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>48. I am good at teamwork</h4>
                <asp:RadioButtonList ID="q48" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>

<!-- QUIZ PAGE 9 -->
<div id="quizPage9" style="display:none;">
    <div class="row">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>49. I am creative in solving problems</h4>
                <asp:RadioButtonList ID="q49" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>50. I learn technical skills quickly</h4>
                <asp:RadioButtonList ID="q50" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

              <div class="question">
              <h4>51. I enjoy helping others</h4>
              <asp:RadioButtonList ID="q51" runat="server" CssClass="choices">
                  <asp:ListItem Text="Strongly Agree" Value="5" />
                  <asp:ListItem Text="Agree" Value="4" />
                  <asp:ListItem Text="Neutral" Value="3" />
                  <asp:ListItem Text="Disagree" Value="2" />
                  <asp:ListItem Text="Strongly Disagree" Value="1" />
              </asp:RadioButtonList>
          </div>

        </div>

        <!-- RIGHT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>52. I like working with people</h4>
                <asp:RadioButtonList ID="q52" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>53. I am patient</h4>
                <asp:RadioButtonList ID="q53" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>54. I am organized</h4>
                <asp:RadioButtonList ID="q54" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>

    <!-- QUIZ PAGE 10 -->
<div id="quizPage10" style="display:none;">
    <div class="row">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>55. I am responsible</h4>
                <asp:RadioButtonList ID="q55" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>56. I am confident</h4>
                <asp:RadioButtonList ID="q56" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>57. I am creative</h4>
                <asp:RadioButtonList ID="q57" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <!-- RIGHT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>58. I am curious</h4>
                <asp:RadioButtonList ID="q58" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>59. I am hardworking</h4>
                <asp:RadioButtonList ID="q59" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>60. I am adaptable</h4>
                <asp:RadioButtonList ID="q60" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>


<!-- QUIZ PAGE 11 -->
<div id="quizPage11" style="display:none;">
    <div class="row">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>61. I enjoy teamwork</h4>
                <asp:RadioButtonList ID="q61" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>62. I enjoy leadership</h4>
                <asp:RadioButtonList ID="q62" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>63. I like challenges</h4>
                <asp:RadioButtonList ID="q63" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <!-- RIGHT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>64. I stay calm under pressure</h4>
                <asp:RadioButtonList ID="q64" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>65. I am detail-oriented</h4>
                <asp:RadioButtonList ID="q65" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>66. I am motivated</h4>
                <asp:RadioButtonList ID="q66" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>

<!-- QUIZ PAGE 12 -->
<div id="quizPage12" style="display:none;">
    <div class="row">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>67. I enjoy social interaction</h4>
                <asp:RadioButtonList ID="q67" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>68. I am independent</h4>
                <asp:RadioButtonList ID="q68" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>69. I like structured work</h4>
                <asp:RadioButtonList ID="q69" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

        <!-- RIGHT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>70. I enjoy problem solving</h4>
                <asp:RadioButtonList ID="q70" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>71. I am persistent</h4>
                <asp:RadioButtonList ID="q71" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>72. I enjoy learning new things</h4>
                <asp:RadioButtonList ID="q72" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>
    </div>
</div>    
       
       
       
  <!-- QUIZ PAGE 13 -->
<div id="quizPage13" style="display:none;">
    <div class="row">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="question">
                <h4>73. I am disciplined</h4>
                <asp:RadioButtonList ID="q73" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>74. I take initiative</h4>
                <asp:RadioButtonList ID="q74" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

            <div class="question">
                <h4>75. I am goal-oriented</h4>
                <asp:RadioButtonList ID="q75" runat="server" CssClass="choices">
                    <asp:ListItem Text="Strongly Agree" Value="5" />
                    <asp:ListItem Text="Agree" Value="4" />
                    <asp:ListItem Text="Neutral" Value="3" />
                    <asp:ListItem Text="Disagree" Value="2" />
                    <asp:ListItem Text="Strongly Disagree" Value="1" />
                </asp:RadioButtonList>
            </div>

        </div>

    </div>
</div>


 
        <div class="button-container">
            <asp:Button ID="btnPrev" runat="server" Text="Previous" CssClass="btn btn-secondary"
                        OnClientClick="showPrevPage(); return false;" Style="display:none; margin-right:10px;" />
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-primary"
                        OnClientClick="handleNext(); return false;" />
          <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz" CssClass="btn btn-success"
                         OnClick="btnSubmit_Click" />
        </div>
    </div>

    <div id="waveContainer" runat="server" class="wave-container">
    <h2 id="waveTitle" runat="server" class="wave-title">Quiz Completed!</h2>
    <h3 id="waveSubtitle" runat="server" class="wave-subtitle">Here’s how you did:</h3>

    <div style="display:flex; flex-direction:column; align-items:flex-start; gap:30px; margin-top:20px; padding-left:50px;">
        <div class="card score-card" style="background: #fff; color: #000; padding: 10px 15px; border-radius: 15px; min-width:120px; text-align:center; box-shadow:0 4px 10px rgba(0,0,0,0.2);">
            <h5 style="margin-bottom:5px;">Your Score</h5>
            <p id="waveScore" runat="server" class="score-number" style="font-size:1.5em; font-weight:bold; margin:0;">0/18</p>
        </div>

   <div class="course-bulletin modern-bulletin">
    <h3 class="bulletin-title">Course Recommendations</h3>
    <div class="course-card first-place">
        <div class="course-info">
            <span class="course-rank">🥇</span>
            <div>
                <span id="course1Name" runat="server" class="course-name">-</span>
                <span id="course1Score" runat="server" class="course-score">0%</span>
            </div>
        </div>
        <div class="progress-bar">
            <div id="course1Progress" runat="server" class="progress gold"></div>
        </div>
    </div>
    <div class="course-card second-place">
        <div class="course-info">
            <span class="course-rank">🥈</span>
            <div>
                <span id="course2Name" runat="server" class="course-name">-</span>
                <span id="course2Score" runat="server" class="course-score">0%</span>
            </div>
        </div>
        <div class="progress-bar">
            <div id="course2Progress" runat="server" class="progress silver"></div>
        </div>
    </div>
    <div class="course-card third-place">
        <div class="course-info">
            <span class="course-rank">🥉</span>
            <div>
                <span id="course3Name" runat="server" class="course-name">-</span>
                <span id="course3Score" runat="server" class="course-score">0%</span>
            </div>
        </div>
        <div class="progress-bar">
            <div id="course3Progress" runat="server" class="progress bronze"></div>
        </div>
    </div>
</div>
</div>


        <div style="display:flex; justify-content:flex-end; width:100%; height: 78%; margin-top:-590px;">
            <div class="card courses-card-modern" style="max-width:700px; margin-inline-end: 70px; width:100%;">
               <h5 style="font-weight:bold; color:#0a2472;">Total Score Of Each Courses</h5>
                <ul id="waveDetails" runat="server">
                    <li><span class="course-name">IT</span><span class="course-score">5/6 ✅</span></li>
                    <li><span class="course-name">Agriculture</span><span class="course-score">4/6</span></li>
                    <li><span class="course-name">Education</span><span class="course-score">3/6</span></li>
                </ul>
            </div>
        </div>

<div style="display:flex; justify-content:flex-start;">
    <button type="button" class="retry-btn" onclick="resetQuiz()">
        Retry Quiz 
    </button>

    <button type="button" class="retry-btn" onclick="goHome()">
        Back to Home 
    </button>
</div>
    <canvas id="confettiCanvas"></canvas>
</div>
<asp:ScriptManager ID="ScriptManager1" runat="server" />


</form>

   <script>
       let currentPage = 1;
       const totalPages = 13;

       function updateButtons() {
           const btnPrev = document.getElementById('<%= btnPrev.ClientID %>');
        const btnNext = document.getElementById('<%= btnNext.ClientID %>');
        const btnSubmit = document.getElementById('<%= btnSubmit.ClientID %>');

           btnPrev.style.display = currentPage > 1 ? 'inline-block' : 'none';
           if (currentPage < totalPages) {
               btnNext.style.display = 'inline-block';
               btnSubmit.style.display = 'none';
           } else {
               btnNext.style.display = 'none';
               btnSubmit.style.display = 'inline-block';
           }
           window.scrollTo({ top: 0, behavior: 'smooth' });
       }
       function showPage(page) {
           for (let i = 1; i <= totalPages; i++) {
               const pageDiv = document.getElementById('quizPage' + i);
               if (pageDiv) {
                   pageDiv.style.display = (i === page) ? 'block' : 'none';
               }
           }
           currentPage = page;
           updateButtons();
       }
       function showPrevPage() {
           if (currentPage > 1) showPage(currentPage - 1);
       }
       function handleNext() {
           if (currentPage < totalPages) showPage(currentPage + 1);
       }

       function goHome() {
           window.location.href = "default.aspx"; 
       }

       function resetQuiz() {
           currentPage = 1;
           showPage(currentPage);

           document.querySelectorAll("input[type=radio], input[type=checkbox]").forEach(el => {
               el.checked = false;
           });

           document.querySelectorAll("input[type=text], textarea").forEach(el => {
               el.value = "";
           });

           const wave = document.getElementById('waveContainer');
           if (wave) {
               wave.style.display = "none";
               wave.classList.remove('show');
           }

           window.scrollTo({ top: 0, behavior: 'smooth' });
           }
           window.onload = function () {
               showPage(currentPage);

           const wave = document.getElementById('waveContainer');

           if (wave && wave.style.display === 'block') {
               setTimeout(() => {
                   wave.classList.add('show');
               }, 100);

               // 👉 OPTIONAL: animate score bar
               const scoreText = document.getElementById('waveScore').innerText;

               if (scoreText.includes('/')) {
                   const score = parseInt(scoreText.split('/')[0]);
                   const percent = (score / 18) * 100;

                   document.getElementById('scoreBar').style.width = percent + "%";
                   document.getElementById('scorePercent').innerText = percent.toFixed(1) + "%";
               }
           }
       };
   </script>


</body>
</html>