<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="MOOCs._default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MOOCs</title>
     <link rel="icon" type="image/x-icon" href="images/Favicon-landing.ico"/>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

     <style>
    
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #0a2472;
            padding: 35px 55px;
            color: white;
        }

                .nav-links a {
            font-family: 'Poppins', sans-serif;
            color: #ffffff;
            text-decoration: none;
            margin: 0 15px;
            font-size: 22px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            position: relative;
        }


            .nav-links a::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: -4px;
                width: 0;
                height: 3px;
                background-color: #00b4d8; /* accent color */
                transition: width 0.3s ease;
            }

            .nav-links a:hover::after {
                width: 100%;
            }

            .nav-links a:hover {
                color: #00b4d8; 
                text-shadow: 0 0 10px rgba(0, 180, 216, 0.7);
            }

        /* Banner Section */
        .banner {
            position: relative;
            height: 80vh;
            overflow: hidden;
        }

        .banner-video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .banner-text button {
            padding: 18px 30px; /* mas dako ang sulod */
            margin: 15px 15px 0 0;
            border: none;
            border-radius: 12px; /* mas rounded */
            font-size: 25px; /* mas dako ang text */
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 6px 10px rgba(0,0,0,0.15);
        }

        /* MOOCS BUTTON */
        .moocs-btn {
            background-color: #0a2472; 
            color: #fff;
        }

        .moocs-btn:hover {
            background: linear-gradient(135deg, #17b3f8, #00c6ff);
            transform: translateY(-3px) scale(1.05); /* mas interactive */
        }

        /* QUIZ BUTTON */
        .quiz-btn {
            background-color: #ff7f50; 
            color: #fff;
        }

        .quiz-btn:hover {
            background: linear-gradient(135deg, #17b3f8, #00c6ff);
            transform: translateY(-3px) scale(1.05);
        }

        /* What We Offer Section */
            .what-we-offer-section {
                padding: 60px 40px;
                background-color: #f8f9fa;
                text-align: center;
            }

              .section {
            padding: 50px 20px;
            text-align: center;
        }

    .services-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 30px;
    }

    .service-item {
        background-color: #e3f2fd;
        border-radius: 15px;
        padding: 30px;
        cursor: pointer;
        transition: transform 0.3s, box-shadow 0.3s;
    }

    .service-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
    }

    .icon-container {
        font-size: 40px;
        margin-bottom: 10px;
        color: #007bff;
    }

    .service-title {
        font-weight: bold;
        font-size: 20px;
        margin-bottom: 10px;
    }

    /* MODAL STYLES */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background: rgba(0,0,0,0.5);
        animation: fadeIn 0.3s;
    }

    @keyframes fadeIn {
        from {opacity: 0;}
        to {opacity: 1;}
    }

    .modal-content {
        background: white;
        margin: 10% auto;
        padding: 30px;
        border-radius: 10px;
        width: 80%;
        max-width: 600px;
        text-align: left;
        position: relative;
        animation: slideDown 0.3s;
    }

    @keyframes slideDown {
        from {transform: translateY(-20px); opacity: 0;}
        to {transform: translateY(0); opacity: 1;}
    }

    .close-btn {
        position: absolute;
        top: 10px;
        right: 15px;
        font-size: 25px;
        color: #333;
        cursor: pointer;
    }

    .close-btn:hover {
        color: #007bff;
    }

        @media (max-width: 768px) {
            .services-grid {
                flex-direction: column;
                align-items: center;
            }

            .banner-text h2 {
                font-size: 32px;
            }

            .signup-btn, .login-btn {
                font-size: 16px;
                padding: 10px 20px;
            }
        }

        /* General Reset */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
body {
    background: #f5f7fa;
    color: #333;
    line-height: 1.6;
}

.section {
    padding: 50px 40px;
    margin: 0 auto 60px auto;
    border-radius: 8px;
    width: 1500px;

}

/* Background Colors */
.blue-bg {
    background-color: #1e90ff;
    color: white;
    
}

.red-bg {
    background-color: #dc3545;
    color: white;
}

/* Content Row Flex */
.content-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    flex-wrap: wrap;
}

/* Image Styling */
.content-image img {
    max-width: 100%;
    height: auto;
    border-radius: 8px;
    box-shadow: 0 8px 15px rgba(0,0,0,0.1);
}

/* Text Area */
.content-text {
    flex: 1 1 300px;
}



/* Paragraphs */
p {
    margin-bottom: 20px;
    font-size: 1rem;
}

/* Buttons */
.btn {
    padding: 12px 28px;
    font-size: 1rem;
    font-weight: 600;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    display: inline-block;
}

/* Button colors */
.red-btn {
    background-color: #e55353;
    color: white;
   
}

.red-btn:hover {
    background-color: #c43d3d;
}

.dark-btn {
    background-color: #343a40;
    color: white;
}

.dark-btn:hover {
    background-color: #23272b;
}

/* Columns Section */
.features-how-it-works {
    display: flex;
    gap: 40px;
    justify-content: center;
    flex-wrap: wrap;
}

.features-how-it-works .column {
    flex: 1 1 400px;
    background: #fff;
    padding: 25px 30px;
    border-radius: 10px;
    box-shadow: 0 5px 12px rgba(0,0,0,0.1);
    color: #444;
}

@media screen and (max-width: 768px) {
    .content-row {
        flex-direction: column;
        text-align: center;
    }

    .content-text {
        flex: none;
    }

    .features-how-it-works {
        flex-direction: column;
    }
}
.footer {
    background-color: #111;
    color: #fff;
    padding: 40px 0;
    font-family: Arial, sans-serif;
}

/* Container Layout */
.footer-container {
    max-width: 1100px;
    margin: auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 30px;
    align-items: flex-start;
}

/* Each Column */
.footer-column h2,
.footer-column h3 {
    margin-bottom: 10px;
}

.footer-column p {
    color: #ccc;
    font-size: 14px;
}

/* Statcounter Styling */
.statcounter-wrapper {
    margin-top: 10px;
}

.statcounter img {
    max-width: 120px;
    border: 1px solid #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(255,255,255,0.3);
}

/* Logo Image Column */
.footer-image {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.footer-image img {
    width: 180px;
    height: auto;
    object-fit: contain;
}

/* Footer Bottom */
.footer-bottom {
    text-align: center;
    color: #777;
    margin-top: 30px;
    font-size: 0.9rem;
    border-top: 1px solid #333;
    padding-top: 15px;
}



/* Responsive */
@media (max-width: 768px) {
    .footer-container {
        text-align: center;
        justify-content: center;
    }
    
    .footer-image {
        justify-content: center;
    }
    
    .statcounter-wrapper {
        margin-top: 20px;
    }
}

h2, h3, h4, h5 {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-weight: 600;
    line-height: 1.3;
    color: #00c3ff;
    margin-bottom: 15px;
}


.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.modal-box {
    background: white;
    padding: 100px;
    width: 700px;
    border-radius: 10px;
    text-align: center;
    position: relative;
    box-shadow: 0px 4px 15px rgba(0,0,0,0.2);
}

.modal-close {
    position: absolute;
    top: 8px;
    right: 15px;
    font-size: 22px;
    cursor: pointer;
}

@media (max-width: 768px) {
    h2 { font-size: 1.6rem; }
    h3 { font-size: 1.4rem; }
    h4 { font-size: 1.2rem; }
    h5 { font-size: 1rem; }
    h { font-size: 1rem; }
}



/* ================= RESPONSIVE ADDITION ONLY ================= */

/* Prevent horizontal scroll */
html, body {
    overflow-x: hidden;
}

/* Fix fixed width section (without removing your original code) */
@media (max-width: 1600px) {
    .section {
        width: 100% !important;
        max-width: 1200px;
    }
}

/* Tablet adjustments */
@media (max-width: 992px) {

    .navbar {
        flex-direction: column;
        padding: 20px;
        text-align: center;
    }

    .nav-links a {
        display: block;
        margin: 10px 0;
        font-size: 18px;
    }

    .banner-text h2 {
        font-size: 36px;
    }

    .modal-box {
        width: 90%;
        padding: 40px;
    }
}

/* Mobile adjustments */
@media (max-width: 768px) {

    /* Banner */
    .banner {
        height: 60vh;
    }

    .banner-text h2 {
        font-size: 28px;
        padding: 0 15px;
    }

    .signup-btn,
    .login-btn {
        font-size: 15px;
        padding: 8px 18px;
    }

    /* Services grid fix (you used grid not flex) */
    .services-grid {
        grid-template-columns: 1fr !important;
    }

    /* Content row stack */
    .content-row {
        flex-direction: column !important;
        text-align: center;
    }

    .content-text {
        text-align: center;
    }

    /* Modal fix */
    .modal-box {
        width: 95% !important;
        padding: 25px !important;
    }
}

.quiz-btn {
    background-color: #28a745;
    color: white;
    padding: 10px 20px;
    border: none;
    margin: 5px;
    cursor: pointer;
    border-radius: 5px;
}

.quiz-btn:hover {
    background-color: #218838;
}
/* Extra small phones */
@media (max-width: 480px) {

    .banner-text h2 {
        font-size: 22px;
    }

    .service-item {
        padding: 20px;
    }

    .icon-container {
        font-size: 30px;
    }

    .modal-box {
        padding: 20px !important;
    }
}

    </style>
</head>

<body>
    <form id="form1" runat="server">
        
        <div class="navbar">
        </div>

        <div class="banner">
            <video class="banner-video" autoplay loop muted playsinline>
                <source src="video/F.mp4" type="video/mp4" />
            </video>
            <div class="banner-overlay">
                <div class="banner-text">
                    <h2>LEARN ANYTIME, ANYWHERE</h2>

                    <!-- ACCESS MOOCs Button -->
                    <button type="button" class="moocs-btn" onclick="window.location.href='login.aspx'">
                        ACCESS MOOCs
                    </button>
                    <button type="button" class="quiz-btn" onclick="window.location.href='forminfo.aspx'">
                        KNOW YOURSELF
                    </button>
                </div>
            </div>
        </div>

 
        <div class="what-we-offer-section">
            <h2 class="section-title">WHAT WE OFFER</h2>
            <p class="section-subtitle">Explore our services that help enhance your educational journey.</p>
            <div class="services-grid">
             <div class="service-item" 
     onclick="openModal('Video Courses', 'Access high-quality video lectures from top instructors anytime, anywhere. Explore how your school brings each course to life through engaging student activities from hands-on projects and group discussions to real classroom demonstrations captured on video. See how lessons are developed, modules are prepared, and how instructors guide students through practical, interactive learning experiences that show the full process of creating each course.')">

    <div class="icon-container"><i class="fas fa-video"></i></div>
    <div class="service-title">Video Courses</div>
    <p class="service-description">Access high-quality video lectures from top instructors anytime, anywhere.</p>
</div>
               <div class="service-item" 
     onclick="openModal('Certification', 'Get certified upon course completion to boost your resume and career prospects. Each certificate reflects the skills, knowledge, and hands-on activities you completed throughout the course, including projects, assessments, and real school-based tasks. These certifications help showcase your learning experience and demonstrate your readiness for future academic or career opportunities.')">

    <div class="icon-container"><i class="fas fa-certificate"></i></div>
    <div class="service-title">Certification</div>
    <p class="service-description">Boost your resume with our certificate programs.</p>
</div>
             <div class="service-item" 
     onclick="openModal('Expert Faculty', 'Learn from highly qualified and experienced faculty members in every subject. Our instructors bring real industry knowledge and academic expertise into every lesson, guiding students through meaningful activities, practical demonstrations, and hands-on projects. They are dedicated to supporting your learning journey, ensuring that each course is engaging, clear, and connected to real-world applications.')">

    <div class="icon-container"><i class="fas fa-chalkboard-teacher"></i></div>
    <div class="service-title">Expert Faculty</div>
    <p class="service-description">Learn from expert instructors.</p>
</div>
            </div>
        </div>



        <section class="section start-business blue-bg">
       <h3>Start Building Your Future Today</h3>
<p>Join thousands of learners taking their first step toward a brighter future. Explore expert-led courses and gain the skills you need to thrive.</p>
<div class="content-row">
    <div class="content-image">
        <img src="images/bu.jpg" alt="Inspired Students" class="img-fluid mb-3" style="border-radius: 10px; height: 250px; width: 100%; object-fit: cover;"/>
    </div>
    <div class="content-text">
        <p>"Our programs are designed to equip you with practical knowledge and real-world skills. Let’s shape your future one lesson at a time. With a curriculum built around industry needs and a learning environment that encourages growth, we empower you to turn your passion into purpose. Whether you're just starting out or looking to upskill, your journey to success begins here. This is more than just education it’s the foundation for your future career, your ambitions, and your impact on the world. Discover what you’re capable of and start building the life you’ve always imagined."</p>
        <button class="btn red-btn">Start Learning</button>
    </div>
</div>
    </section>

 <section class="section big-opportunity red-bg">
    <h4>Simple Way With Big Opportunity</h4>
    <p>Unlock your potential through accessible and impactful learning designed specifically for students who want to make a difference.</p>
    <div class="content-row">
        <div class="content-text">
            <p>
                Whether you're starting your academic journey or looking to level up your skills, our platform offers a simple path to major opportunities.
                We provide flexible learning options, industry recognized courses, and the tools you need to grow your confidence and your career. 
                As a student, you deserve more than just a degree you deserve a future filled with possibilities. Take your next step today.
            </p>
            <button class="btn dark-btn">Join as a Student</button>
        </div>
        <div class="content-image">
            <img src="images/P.jpg" alt="Inspired Students" class="img-fluid mb-3" style="border-radius: 10px; height: 250px; width: 100%; object-fit: cover;"/>
        </div>
    </div>
</section>



<section class="section">
    <h2>Possible Courses</h2>
    <p class="section-subtitle">Explore a wide range of academic and professional courses designed to fit your interests and career goals.</p>
    <div class="services-grid">
        <div class="service-item" data-title="Information Technology" data-desc="**Information Technology (IT)** is the study and application of computer systems, software, and networks used to process and manage information. It involves designing, developing, and maintaining technology solutions that help organizations and individuals store, retrieve, and share data efficiently. Students in this field learn about programming, web development, cybersecurity, database management, and networking. Information Technology plays a vital role in modern society by driving innovation, improving communication, and supporting digital transformation across industries. Careers in IT include roles such as software developer, network administrator, systems analyst, web designer, and IT support specialist.
">
            <div class="icon-container"><i class="fas fa-laptop-code"></i></div>
            <div class="service-title">Information Technology</div>
            <p class="service-description">Dive into programming, cybersecurity, networking, and software development.</p>
        </div>

        <div class="service-item" data-title="Office Administration" data-desc="Office Administration is the study and practice of managing the day-to-day operations of an organization or business. It focuses on developing skills in organizing, planning, communication, and coordination to ensure smooth office workflows. Students in this field learn how to handle administrative tasks such as record keeping, scheduling, correspondence, and customer service. They also gain knowledge in office technology, management principles, and professional etiquette. A strong background in office administration prepares individuals to work efficiently in business, government, or educational settings as secretaries, office managers, administrative assistants, or executive support staff.">
            <div class="icon-container"><i class="fas fa-building"></i></div>
            <div class="service-title">Office Administration</div>
            <p class="service-description">Develop administrative, communication, and organizational skills for business environments.</p>
        </div>

        <div class="service-item" data-title="Marine Biology" data-desc="Marine Biology is the branch of science that studies life in the oceans and other saltwater environments. It explores how marine organisms such as fish, corals, whales, plankton, and sea plants live, grow, and interact with each other and their surroundings. Marine biologists study ocean ecosystems, from the smallest microorganisms to the largest marine mammals, to understand how ocean life contributes to Earth’s overall balance. This field also examines the effects of human activities like pollution, overfishing, and climate change on marine environments. Ultimately, marine biology plays a vital role in conserving marine biodiversity and protecting the health of our planet’s oceans..">
            <div class="icon-container"><i class="fas fa-water"></i></div>
            <div class="service-title">Marine Biology</div>
            <p class="service-description">Study marine ecosystems, oceanography, and aquatic life conservation.

            </p>
            
        </div>
       
    </div>
</section>
<div id="serviceModal" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <span class="modal-close" onclick="closeModal()">&times;</span>

        <h2 id="modalTitle">Service Title</h2>
        <p id="modalDescription">Full details about the service will appear here.</p>
    </div>
</div>

        <script>
            function openModal(title, description) {
                document.getElementById("modalTitle").innerText = title;
                document.getElementById("modalDescription").innerText = description;

                document.getElementById("serviceModal").style.display = "flex";
            }

            function closeModal() {
                document.getElementById("serviceModal").style.display = "none";
            }
        </script>

<section class="section" style="background-color: #009ccf; color: white;">
    <h2>About Us</h2>
    <div class="content-row">
        <div class="content-image">
            <img src="images/bu.jpg" alt="About Us" style="border-radius: 10px; height: 250px; width: 100%; object-fit: cover;"/>
        </div>
        <div class="content-text">
            <p>
                At SeaPath College, we believe your future begins with the right course. Our mission is to help you discover educational paths that align with your passions, strengths, and long-term goals. Whether you're exploring new fields or advancing in your current career, we’re here to guide your journey.
            </p>
            <p>
                Our platform offers clear insights into each program, including career outcomes, skill development, and practical applications. From technology to the sciences, education to public service we help you make informed decisions about your education and future.
            </p>
            <button class="btn dark-btn" onclick="window.location.href='signup.aspx'">View More</button>
        </div>
    </div>
</section>


<section class="section features-how-it-works">
    <div class="column">
        <h5>Future-Focused Features</h5>
        <p>Empowering you with tools and programs that prepare you for tomorrow's world.</p>
        <p>
            Our future courses are designed around emerging technologies, industry trends, and real-world challenges. 
            for all coming college student, we equip students to know better for the future knowledge. Personalized learning paths, expert instructors, and interactive content ensure 
            you're not just learning you’re building your career step by step.
        </p>
    </div>
    <div class="column">
        <h6>How It Works</h6>
        <p>Explore → Learn → Succeed</p>
        <p>
            Start by browsing our website of innovative courses tailored to your career goals.  
            Get hands on with advance knowledge of that course. Our support doesn't end at the last module learing resources and mentorship are here to guide your next steps.
        </p>
    </div>
</section>
<footer id="footer" class="footer">

   <!-- Visitor Counter Section (Left Aligned) -->
<div class="visitor-counter" style="text-align:center; margin:30px 0 30px 20px; max-width:260px; background-color:#2c2c2c; color:white; padding:25px; border-radius:15px; border:1px solid #555; box-shadow: 0 6px 20px rgba(255,255,255,0.15); font-family:Arial, sans-serif; float:left;">
    <h4 style="margin:0 0 15px 0; font-size:20px; font-weight:bold; color:#ffffff; text-shadow: 0 0 5px rgba(255,255,255,0.3);">
        Visitor Counter
    </h4>

    <!-- Statcounter Script -->
    <script type="text/javascript">
        var sc_project = 13208451;
        var sc_invisible = 0;
        var sc_security = "9e811adc";
        var scJsHost = "https://";
        document.write("<sc" + "ript type='text/javascript' src='" +
            scJsHost +
            "statcounter.com/counter/counter.js'></" + "script>");
    </script>

    <noscript>
        <div class="statcounter" style="margin-top:10px;">
            <a title="Web Analytics" href="https://statcounter.com/" target="_blank">
                <img class="statcounter"
                     src="https://c.statcounter.com/13208451/0/9e811adc/0/"
                     alt="Web Analytics"
                     referrerPolicy="no-referrer-when-downgrade"
                     style="width:100%; height:auto; border:none;"/>
            </a>
        </div>
    </noscript>
</div>
    <div class="footer-container">
        <div class="footer-column">
            <h2>MOOCs Learning Hub</h2>
            <p>Learn. Grow. Succeed.</p>
        </div>

        <div class="footer-column">
            <h3>Contact Us</h3>
            <p>Email: info@moocs.edu</p>
            <p>Phone: 09603160606</p>
        </div>

        <div class="footer-column footer-image">
            <img src="images/LOGO.png" alt="MOOCs Logo" />
        </div>
    </div>

    <div class="footer-bottom">
        &copy; 2025 MOOCs. All rights reserved.
    </div>
</footer>
          <script>
              document.addEventListener("DOMContentLoaded", function () {
                  const signupBtn = document.querySelector(".signup-btn");
                  if (signupBtn) {
                      signupBtn.addEventListener("click", function (e) {
                          e.preventDefault();
                          window.location.href = "signup.aspx";
                      });
                  }

                  const loginBtn = document.querySelector(".login-btn");
                  if (loginBtn) {
                      loginBtn.addEventListener("click", function (e) {
                          e.preventDefault();
                          window.location.href = "login.aspx";
                      });
                  }

                  // Simulate user login status
                  let isLoggedIn = false;

                  const allButtons = document.querySelectorAll("button");

                  allButtons.forEach(btn => {
                      s
                      if (btn.classList.contains("signup-btn") ||
                          btn.classList.contains("login-btn") ||
                          btn.classList.contains("test-btn") ||
                          btn.classList.contains("quiz-btn")) {
                          return; 
                      }

                      btn.addEventListener("click", function (e) {
                          e.preventDefault();

                          if (isLoggedIn) {
                              window.location.href = btn.getAttribute("data-target");
                          } else {
                              alert("Please login or signup first!");
                              window.location.href = "login.aspx";
                          }
                      });
                  });

              });
          </script>
    </form>
</body>
</html>
