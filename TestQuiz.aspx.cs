using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MOOCs
{
    public partial class TestQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                waveContainer.Style["display"] = "none";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // =========================
            // 1. GROUP QUESTIONS
            // =========================

            var interestQuestions = new RadioButtonList[]
            {
                q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,
                q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24
            };

            var aptitudeQuestions = new RadioButtonList[]
            {
                q25,q26,q27,q28,q29,q30,q31,q32,q33,q34,q35,q36,
                q37,q38,q39,q40,q41,q42,q43,q44,q45,q46,q47,q48
            };

            var personalityQuestions = new RadioButtonList[]
            {
                q49,q50,q51,q52,q53,q54,q55,q56,q57,q58,q59,q60,
                q61,q62,q63,q64,q65,q66,q67,q68,q69,q70,q71,q72,q73,q74,q75
            };

            // =========================
            // 2. COMPUTE SCORES
            // =========================

            int interestScore = CountLikert(interestQuestions);
            int aptitudeScore = CountLikert(aptitudeQuestions);
            int personalityScore = CountLikert(personalityQuestions);

            // =========================
            // 3. COURSE MODEL
            // =========================

            var courses = new[]
            {
                new { Name="BSIT", Score=(interestScore*0.50)+(aptitudeScore*0.40)+(personalityScore*0.10)},
                new { Name="ACT (2-Year)", Score=(interestScore*0.45)+(aptitudeScore*0.40)+(personalityScore*0.15)},
                new { Name="BSABE", Score=(interestScore*0.50)+(aptitudeScore*0.30)+(personalityScore*0.20)},

                new { Name="BSED-English", Score=(interestScore*0.40)+(aptitudeScore*0.30)+(personalityScore*0.30)},
                new { Name="BSED-Math", Score=(interestScore*0.40)+(aptitudeScore*0.35)+(personalityScore*0.25)},
                new { Name="BSED-Science", Score=(interestScore*0.40)+(aptitudeScore*0.35)+(personalityScore*0.25)},
                new { Name="BEED", Score=(interestScore*0.35)+(aptitudeScore*0.30)+(personalityScore*0.35)},
                new { Name="BTLED-Home Economics", Score=(interestScore*0.40)+(aptitudeScore*0.30)+(personalityScore*0.30)},

                new { Name="BS Agribusiness", Score=(interestScore*0.45)+(aptitudeScore*0.30)+(personalityScore*0.25)},
                new { Name="BPA", Score=(interestScore*0.35)+(aptitudeScore*0.30)+(personalityScore*0.35)},
                new { Name="BS Office Administration", Score=(interestScore*0.35)+(aptitudeScore*0.30)+(personalityScore*0.35)},

                new { Name="BS Fisheries", Score=(interestScore*0.50)+(aptitudeScore*0.30)+(personalityScore*0.20)},
                new { Name="Diploma in Fisheries", Score=(interestScore*0.45)+(aptitudeScore*0.30)+(personalityScore*0.25)},
                new { Name="BS Marine Biology", Score=(interestScore*0.55)+(aptitudeScore*0.30)+(personalityScore*0.15)},
                new { Name="BS Environmental Science", Score=(interestScore*0.50)+(aptitudeScore*0.30)+(personalityScore*0.20)},

                new { Name="BS Social Work", Score=(interestScore*0.30)+(aptitudeScore*0.30)+(personalityScore*0.40)},
                new { Name="BS Criminology", Score=(interestScore*0.35)+(aptitudeScore*0.40)+(personalityScore*0.25)},

                new { Name="BS Agriculture", Score=(interestScore*0.50)+(aptitudeScore*0.30)+(personalityScore*0.20)},
                new { Name="BS Development Communication", Score=(interestScore*0.40)+(aptitudeScore*0.30)+(personalityScore*0.30)}
            };

            var sortedCourses = courses
                .OrderByDescending(c => c.Score)
                .ToList();

            int count = sortedCourses.Count;

            double maxScore = sortedCourses.Max(c => c.Score);

            if (count > 0)
            {
                var c1 = sortedCourses[0];
                double p1 = (c1.Score / maxScore) * 100;

                course1Name.InnerText = "⭐ " + c1.Name;
                course1Score.InnerText = $"{p1:F0}%";
                course1Progress.Style["width"] = p1 + "%";
            }

            if (count > 1)
            {
                var c2 = sortedCourses[1];
                double p2 = (c2.Score / maxScore) * 100;

                course2Name.InnerText = c2.Name;
                course2Score.InnerText = $"{p2:F0}%";
                course2Progress.Style["width"] = p2 + "%";
            }

            if (count > 2)
            {
                var c3 = sortedCourses[2];
                double p3 = (c3.Score / maxScore) * 100;

                course3Name.InnerText = c3.Name;
                course3Score.InnerText = $"{p3:F0}%";
                course3Progress.Style["width"] = p3 + "%";
            }


            waveDetails.InnerHtml = "";

            for (int i = 3; i < count; i++)
            {
                var c = sortedCourses[i];

                waveDetails.InnerHtml += $@"
                <li style='display:flex; justify-content:space-between;
                           padding:8px 0; border-bottom:1px solid #eee;'>
                    <span>{i + 1}. {c.Name}</span>
                </li>";
            }


            double totalAverage = (interestScore + aptitudeScore + personalityScore) / 3.0;

            waveScore.InnerText =
                $"Interest: {interestScore} | Aptitude: {aptitudeScore} | Personality: {personalityScore} | Avg: {totalAverage:F2}";


            waveContainer.Style["display"] = "block";
        }



        private int CountLikert(RadioButtonList[] questions)
        {
            int score = 0;

            foreach (var q in questions)
            {
                if (q != null && q.SelectedItem != null)
                {
                    score += Convert.ToInt32(q.SelectedValue);
                }
            }

            return score;
        }
    }
}