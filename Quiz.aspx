<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="MOOCs.Quiz" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz</title>
      <link rel="icon" type="image/x-icon" href="images/favicon-quiz.ico"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
   <style>
        body {
            background: #0a2472;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .quiz-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            padding: 40px;
            width: 1000px;
            transition: all 0.4s ease;
            margin-top: 50px;
            position: relative;
        }
        .quiz-header h2 {
            font-size: 2rem;
            color: #0a2472;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .progress {
            height: 12px;
            background-color: #e9ecef;
            border-radius: 50px;
            overflow: hidden;
        }
        .progress-bar {
            transition: width 0.4s ease-in-out;
            background-color: #007bff;
        }
        .question {
            font-size: 1.25rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 20px;
        }
        .options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .option {
            border: 2px solid #ced4da;
            border-radius: 12px;
            padding: 15px 20px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: 0.3s;
            text-align: center;
            font-weight: 500;
        }
        .option:hover {
            background-color: #e2e6ea;
            border-color: #007bff;
        }
        .option.selected {
            background-color: #95c3f5;
            border-color: #0d6efd;
            color: #084298;
        }
        .quiz-footer {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .timer {
            font-weight: bold;
            color: #495057;
        }
        #next-btn {
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: 500;
            display: none;
        }
        .results {
            text-align: center;
            padding: 40px 20px;
        }
        .score {
            font-size: 1.8rem;
            font-weight: 600;
            color: #0a2472;
            margin-bottom: 10px;
        }
        .results p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        /* Countdown overlay */
        #countdown-overlay {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.85);
            color: white;
            font-size: 3rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        @media (max-width: 768px) {
            .options {
                grid-template-columns: 1fr;
            }
            .quiz-container {
                padding: 30px 20px;
            }
            .quiz-header h2 {
                font-size: 1.6rem;
            }
        }


@media (max-width: 600px) {
    .quiz-container {
        width: 95%;
        padding: 20px 15px;
        margin-top: 30px;
    }

    .quiz-header h2 {
        font-size: 1.4rem;
    }

    .question {
        font-size: 1.1rem;
    }

    .options {
        gap: 10px;
    }

    .option {
        padding: 12px 15px;
        font-size: 0.95rem;
    }

    .quiz-footer {
        flex-direction: column;
        gap: 15px;
        align-items: stretch;
    }

    #next-btn {
        width: 100%;
        text-align: center;
        display: block;
    }

    .timer {
        font-size: 1rem;
        text-align: center;
    }

    .results {
        padding: 30px 15px;
    }

    .score {
        font-size: 1.5rem;
    }

    #countdown-overlay {
        font-size: 2rem;
    }
}


@media (max-width: 400px) {
    .quiz-header h2 {
        font-size: 1.2rem;
    }

    .question {
        font-size: 1rem;
    }

    .option {
        font-size: 0.85rem;
        padding: 10px 12px;
    }

    .score {
        font-size: 1.3rem;
    }

    #countdown-overlay {
        font-size: 1.6rem;
    }
}

    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        <div class="container mt-5">
            <div class="quiz-container card p-4">
                <h3>Answer the Question</h3>
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>

                <asp:Repeater ID="rptQuiz" runat="server" OnItemDataBound="rptQuiz_ItemDataBound">
                    <ItemTemplate>
                        <div class="quiz-question mb-3" data-question-index='<%# Container.ItemIndex %>' style='<%# Container.ItemIndex == 0 ? "" : "display:none;" %>'>
                            <h5><%# (Container.ItemIndex + 1) + ". " + Eval("quiz_question") %></h5>

                            <!-- MCQ -->
                            <asp:Panel ID="pnlMCQ" runat="server" Visible="false">
                                <div class="options" data-correct='<%# Eval("correct_answer") %>'>
                                    <div class="option" data-letter="A" data-answer='<%# Eval("option_a") %>'>A. <%# Eval("option_a") %></div>
                                    <div class="option" data-letter="B" data-answer='<%# Eval("option_b") %>'>B. <%# Eval("option_b") %></div>
                                    <div class="option" data-letter="C" data-answer='<%# Eval("option_c") %>'>C. <%# Eval("option_c") %></div>
                                    <div class="option" data-letter="D" data-answer='<%# Eval("option_d") %>'>D. <%# Eval("option_d") %></div>
                                </div>
                            </asp:Panel>

                       
                            <asp:Panel ID="pnlTF" runat="server" Visible="false">
                                <div class="options" data-correct='<%# Eval("correct_answer") %>'>
                                    <div class="option" data-answer="True">True</div>
                                    <div class="option" data-answer="False">False</div>
                                </div>
                            </asp:Panel>

                       
                            <asp:Panel ID="pnlFIB" runat="server" Visible="false">
                                <input type="text" class="fib-input form-control mt-2" placeholder="Enter your answer..." data-correct='<%# Eval("correct_answer") %>' />
                            </asp:Panel>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div id="timer">Time: 20s</div>
                    <button type="button" class="btn btn-primary" id="next-btn" style="display:none;">Next</button>
                </div>
            </div>
        </div>

    </form>

    <script>
        (function () {
            let currentQuestion = 0;
            let score = 0;
            let timeLeft = 30;
            let timer;

            function queryAll(selector) {
                return Array.prototype.slice.call(document.querySelectorAll(selector));
            }

            function shuffleArray(array) {
                for (let i = array.length - 1; i > 0; i--) {
                    const j = Math.floor(Math.random() * (i + 1));
                    [array[i], array[j]] = [array[j], array[i]];
                }
                return array;
            }


            function shuffleQuestions() {
                const container = document.querySelector('.quiz-container');
                const questions = Array.from(container.querySelectorAll('.quiz-question'));

                shuffleArray(questions);

                questions.forEach((q, index) => {
                    q.style.display = 'none';
                    q.setAttribute('data-question-index', index);

                    // 🔹 FIX QUESTION NUMBER (h5)
                    const h5 = q.querySelector('h5');
                    if (h5) {
                        const text = h5.textContent;
                        const cleanText = text.replace(/^\d+\.\s*/, ''); // remove old number
                        h5.textContent = (index + 1) + '. ' + cleanText;
                    }

                    container.insertBefore(q, document.getElementById('timer').parentElement);
                });

                currentQuestion = 0;
            }


            function updateUI() {
                const questions = queryAll('.quiz-question');
                questions.forEach(q => q.style.display = 'none');
                if (questions.length === 0) return;

                const question = questions[currentQuestion];
                question.style.display = 'block';

                // Shuffle options if any
                const optsPanel = question.querySelector('.options');
                if (optsPanel) {
                    const opts = Array.from(optsPanel.querySelectorAll('.option'));
                    shuffleArray(opts);
                    opts.forEach(o => optsPanel.appendChild(o));
                }

                document.getElementById('next-btn').style.display = 'none';
                startTimer();
                bindCurrentQuestion();
            }

            function startTimer() {
                clearInterval(timer);
                timeLeft = 30;
                document.getElementById('timer').textContent = `Time: ${timeLeft}s`;
                timer = setInterval(() => {
                    timeLeft--;
                    document.getElementById('timer').textContent = `Time: ${timeLeft}s`;
                    if (timeLeft <= 0) {
                        clearInterval(timer);
                        goNext();
                    }
                }, 1000);
            }

            function bindCurrentQuestion() {
                const question = queryAll('.quiz-question')[currentQuestion];
                if (!question) return;

                const optionsPanel = question.querySelector('.options');
                const correct = optionsPanel ? optionsPanel.getAttribute('data-correct') || '' : '';

                // MCQ and True/False
                if (optionsPanel) {
                    const opts = question.querySelectorAll('.option');
                    opts.forEach(o => {
                        o.classList.remove('selected', 'correct', 'wrong');
                        // Remove any previously added span
                        const existingSpan = o.querySelector('span.correct-answer-label');
                        if (existingSpan) existingSpan.remove();

                        o.onclick = function () {
                            // Disable all options after click
                            opts.forEach(x => x.onclick = null);
                            opts.forEach(x => x.classList.remove('selected'));
                            this.classList.add('selected');

                            const chosenText = (this.getAttribute('data-answer') || '').trim();
                            const chosenLetter = (this.getAttribute('data-letter') || '').trim();
                            const correctVal = correct.trim();

                            const isCorrect = (correctVal.toLowerCase() === chosenText.toLowerCase()) ||
                                (correctVal.toUpperCase() === chosenLetter.toUpperCase());

                            if (isCorrect) {
                                this.classList.add('correct');
                                score++;
                                appendCorrectLabel(this);
                            } else {
                                this.classList.add('wrong');
                                // Show correct option
                                opts.forEach(x => {
                                    const txt = (x.getAttribute('data-answer') || '').trim();
                                    const letter = (x.getAttribute('data-letter') || '').trim();
                                    if (correctVal.toLowerCase() === txt.toLowerCase() || correctVal.toUpperCase() === letter.toUpperCase()) {
                                        x.classList.add('correct');
                                        appendCorrectLabel(x);
                                    }
                                });
                            }

                            document.getElementById('next-btn').style.display = 'inline-block';
                        };
                    });
                }

                // Fill-in-the-Blank
                const fib = question.querySelector('.fib-input');
                if (fib) {
                    fib.value = '';
                    const existingSpan = question.querySelector('span.correct-answer-label');
                    if (existingSpan) existingSpan.remove();

                    fib.oninput = function () {
                        document.getElementById('next-btn').style.display = fib.value.trim().length > 0 ? 'inline-block' : 'none';
                    };
                }
            }

            function appendCorrectLabel(element) {
                if (!element.querySelector('span.correct-answer-label')) {
                    const span = document.createElement('span');
                    span.className = 'ms-2 text-success fw-bold correct-answer-label';
                    span.textContent = `(Correct Answer)`;
                    element.appendChild(span);
                }
            }

            function goNext() {
                clearInterval(timer);

                const question = queryAll('.quiz-question')[currentQuestion];
                const fib = question ? question.querySelector('.fib-input') : null;
                if (fib) {
                    const a = fib.value.trim().toLowerCase();
                    const c = (fib.getAttribute('data-correct') || '').trim().toLowerCase();
                    if (a === c && a !== '') {
                        score++;
                    }
                    // Show correct answer for FIB
                    const existingSpan = question.querySelector('span.correct-answer-label');
                    if (!existingSpan) {
                        const span = document.createElement('span');
                        span.className = 'd-block text-success fw-bold correct-answer-label mt-2';
                        span.textContent = `(Correct Answer: ${fib.getAttribute('data-correct')})`;
                        question.appendChild(span);
                    }
                }

                currentQuestion++;
                const questions = queryAll('.quiz-question');
                if (currentQuestion < questions.length) {
                    updateUI();
                } else {
                    showResults();
                }
            }

            const courseCode = '<%= Request.QueryString["courseCode"] %>';
    const moduleNumber = parseInt('<%= Request.QueryString["moduleNumber"] %>');

            function showResults() {
                const questions = queryAll('.quiz-question');
                const total = questions.length;
                const percent = total === 0 ? 0 : (score / total) * 100;
                const passed = percent >= 50;

                const container = document.querySelector('.quiz-container');

                PageMethods.SaveQuizResult(score, total, courseCode, moduleNumber,
                    function (response) {
                        console.log("SaveQuizResult response:", response);
                        if (response === "success" && passed) goToNextModulePrompt();
                    },
                    function (error) { console.error("Error saving quiz result:", error); }
                );

                let buttons = '';
                if (passed) {
                    buttons = `
                <button class="btn btn-success me-2" onclick="goToNextModulePrompt()">Next Module</button>
                <button class="btn btn-secondary" onclick="exitQuiz()">Exit</button>
            `;
                } else {
                    buttons = `<button class="btn btn-danger" onclick="location.reload()">Restart</button>`;
                }

                container.innerHTML = `
            <div class="results text-center p-4">
                <h3>Your score: ${score}/${total} (${percent.toFixed(2)}%)</h3>
                <p>${passed ? '🎉 Congratulations! You passed.' : 'You did not pass. Try again.'}</p>
                ${buttons}
            </div>
        `;

                window.exitQuiz = function () {
                    container.innerHTML = `
                <div class="text-center p-5">
                    <h3>Thank you for taking the quiz!</h3>
                    <p>You may now return to the main course page.</p>
                    <button type="button" class="btn btn-primary" onclick="window.location.href='course.aspx'">Back to Course</button>
                </div>
            `;
                };

                window.goToNextModulePrompt = function () {
                    container.innerHTML = `
                <div class="text-center p-5">
                    <h3>Great job completing this module!</h3>
                    <p>Would you like to proceed to the next module?</p>
                    <div class="mt-3">
                        <button type="button" class="btn btn-success me-2" onclick="goToNextModule()">Yes, Proceed</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href='Course.aspx'">No, Go Back</button>
                    </div>
                </div>
            `;
                };

                window.goToNextModule = function () {
                    const nextModule = moduleNumber + 1;
                    container.innerHTML = `
                <div class="text-center p-5">
                    <h3>Loading Next Module...</h3>
                    <p>Please wait a moment.</p>
                </div>
            `;
                    setTimeout(() => {
                        window.location.href = `Module.aspx?courseCode=${courseCode}&moduleNumber=${nextModule}`;
                    }, 1000);
                };
            }

            document.getElementById('next-btn').addEventListener('click', goNext);
            document.addEventListener('DOMContentLoaded', function () {
                shuffleQuestions();
                updateUI();
            });
        })();
    </script>


</body>
</html>

