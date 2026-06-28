<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forminfo.aspx.cs" Inherits="MOOCs.forminfo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Info</title>

    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
        }

        :root {
            --primary: #17b3f8;
            --secondary: #0094ff;
            --white: #ffffff;
        }

                /* WAVE CONTAINER IMPROVED */
        .wave-container {
            background: linear-gradient(135deg, #17b3f8, #00c6ff);
            color: #fff;
            padding: 100px 20px 140px 20px;
            text-align: center;
            border-bottom-left-radius: 50% 20%;
            border-bottom-right-radius: 50% 20%;
            animation: fadeIn 1s ease-in-out;
        }

        /* TEXT */
        .wave-container h2 {
            font-size: 30px;
            margin-bottom: 10px;
        }

        .wave-container h3 {
            font-size: 26px;
            margin-bottom: 50px;
        }

        /* CARDS */
        .card-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
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
            width: 220px;
        }

        /* ICON STYLE */
        .card span {
            display: block;
            margin-top: 10px;
        }

        /* HOVER EFFECT */
        .card:hover {
            transform: translateY(-10px) scale(1.05);
            background: #000;
            color: #fff;
        }

        /* SELECTED EFFECT */
        .card.selected {
            background: #000;
            color: #fff;
            transform: scale(1.05);
        }

        /* BUTTON */
        .btn-next {
            display: none;
            margin-top: 40px;
            padding: 15px 50px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 30px;
            border: none;
            background: #fff;
            color: #000;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        .btn-next:hover {
            transform: scale(1.1);
        }

        /* ANIMATION */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* INSTRUCTIONS */
        .instructions-container {
            display: none;
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: #fff;
        }

        .title {
            font-size: 36px;
            margin-bottom: 15px;
        }

        .desc {
            font-size: 18px;
            max-width: 700px;
            margin: auto;
            margin-bottom: 30px;
        }

        .steps {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }

        .step-card {
            background: #fff;
            color: #000;
            padding: 20px;
            border-radius: 15px;
            width: 220px;
        }

                /* SHARED STYLE (pwede nimo reuse) */
        .btn-main, .btn-submit {
            background: #fff;
            color: #000;
            padding: 12px 25px;
            font-size: 16px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
            font-weight: 600;
        }

        /* SAME HOVER AS CARD */
        .btn-main:hover, .btn-submit:hover {
            background: #000;
            color: #fff;
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
        }

        .quiz-box {
            text-align: center;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #777;
            margin-bottom: 20px;
        }


        .spinner {
            width: 60px;
            height: 60px;
            border: 6px solid #ffffff;
            border-top: 6px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            100% { transform: rotate(360deg); }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

   <div class="wave-container" id="waveContainer">
    <h2 id="waveTitle">👋 Welcome!</h2>
    <h3 id="waveSubtitle">Before we start, tell us which best describes you.</h3>

    <div class="card-container">
        <div class="card" id="yesCard" onclick="selectCard('yes')">
            🎓 <br />
            <span>Incoming College Student</span>
        </div>

        <div class="card" id="noCard" onclick="selectCard('no')">
            🏠 <br />
            <span>Not a Student</span>
        </div>
    </div>

    <button type="button" id="nextBtn" class="btn-next" onclick="goNext()">Next →</button>
</div>

    <!-- INSTRUCTIONS PAGE -->
    <div id="instructionsDiv" class="instructions-container">

        <h1 class="title">📘 Instructions</h1>

        <p class="desc">
            You will take a short assessment to help identify which college course best suits you 
            based on your knowledge, interests, and skills.
        </p>

        <div class="quiz-box">
    <h1>🧠 Quiz Assessment</h1>

    <p class="desc">
        📘 Remembering, Understanding, and HOTS Level Questions <br><br>
        This section contains mixed questions to test your basic knowledge and recall skills.
        Remembering and Understanding questions are worth <strong>1 point</strong>, while 
        Higher Order Thinking Skills (HOTS) questions are worth <strong>2 points</strong>.
        The total score for all questions is <strong>180 points</strong>.
    </p>
</div>


        <div class="steps">
            <div class="step-card">
                <h3>1️⃣ Choose</h3>
                <p>Select answers that match your interest.</p>
            </div>

            <div class="step-card">
                <h3>2️⃣ Answer</h3>
                <p>Answer honestly based on your knowledge.</p>
            </div>

            <div class="step-card">
                <h3>3️⃣ Discover</h3>
                <p>Get course recommendations.</p>
            </div>
        </div>

        <p class="desc">
            No right or wrong answers. Just be yourself!
        </p>

        <button type="button" class="btn-main" onclick="startQuiz()"> Start </button>
    </div>
    <div id="loadingScreen" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background: linear-gradient(135deg, #17b3f8, #0094ff); color:#fff; justify-content:center; align-items:center;  flex-direction:column; z-index:9999; ">
    <div class="spinner"></div>
    <h2 style="margin-top:20px;">GET READY...</h2>
   </div>
    <footer class="footer">
        Powered by: <strong>MOOCs</strong>
    </footer>

</form>

<script>
    let step = 1;
    let selectedAnswer = null;

    function selectCard(card) {

        // If NO → direct redirect
        if (card === 'no') {
            window.location.href = "default.aspx";
            return;
        }

        // Reset all cards
        document.getElementById('yesCard').style.backgroundColor = '#fff';
        document.getElementById('yesCard').style.color = '#000';
        document.getElementById('noCard').style.backgroundColor = '#fff';
        document.getElementById('noCard').style.color = '#000';

        // Highlight selected
        document.getElementById(card + 'Card').style.backgroundColor = '#000';
        document.getElementById(card + 'Card').style.color = '#fff';

        selectedAnswer = card;

        // Show next button (ONLY for YES)
        document.getElementById('nextBtn').style.display = 'inline-block';
    }

    function goNext() {
        const wave = document.getElementById('waveContainer');
        const instructions = document.getElementById('instructionsDiv');

       if (step === 1) {
            if (selectedAnswer === 'yes') {

                wave.style.transition = "opacity 0.5s";
                wave.style.opacity = "0";

                setTimeout(() => {
                    wave.style.display = "none";
                    instructions.style.display = "block";
                }, 500);

            } else {
                window.location.href = "default.aspx";
            }
        }
    }
    function startQuiz() {
        const loader = document.getElementById("loadingScreen");

        // Show loading screen
        loader.style.display = "flex";

        // Redirect after 3 seconds
        setTimeout(function () {
            window.location.href = "TestQuiz.aspx";
        }, 3000);
    }
</script>

</body>
</html>