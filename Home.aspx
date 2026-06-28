<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MOOCs.Home" %>

<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" 
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" 
      integrity="sha512-Ku6e0N5sGJY6A8m5F27eRDCvG+8pFbvlz9EQ0OkgHCTax6q5H4mPhdlBp1qVYb3bFmjKJ7XJ8K9BkZg6k8qQlw==" 
      crossorigin="anonymous" referrerpolicy="no-referrer" />
  <title>Home Page</title>
    <link rel="icon" type="image/x-icon" href="images/Favicon-home.ico">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f9ff;
      color: #0a2472;
    }

   
    /* Slideshow */
    .slideshow {
    width: 100%;
    height: 550px;
    overflow: hidden;
    position: relative;
  }

  .slide-image {
    width: 100%;
    height: 550px;
    object-fit: cover;
    position: absolute;
    opacity: 0;
    transition: opacity 1s ease-in-out;
  }

  .slide-image.active {
    opacity: 1;
    z-index: 1;
  }

    @keyframes slideShow {
      0%, 25% { opacity: 1; }
      33%, 100% { opacity: 0; }
    }

    /* Grid Section */
    .grid-section {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      padding: 30px;
      background-color: #ffffff;
    }

    .grid-box {
      background: #e6f0ff;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }

    .grid-box:hover {
      transform: translateY(-5px);
    }

    .grid-box h3 {
      margin-top: 0;
      color: #004a99;
    }

    .grid-box p {
      margin-bottom: 0;
    }

    /* Event + Video Section */
    .event-video-section {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      padding: 30px;
      background-color: #f0f8ff;
    }

    .video-left, .video-right {
      flex: 1 1 45%;
      margin: 10px;
    }

    .video-left video {
      width: 100%;
      border-radius: 10px;
    }

    .video-right {
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 1px 5px rgba(0,0,0,0.1);
    }

    .video-right h2 {
      color: #004a99;
      margin-top: 0;
    }

    .video-right p {
      font-size: 1.1rem;
      line-height: 1.6;
    }

    .view-btn {
     display: inline-block;
     margin-top: 10px;
     padding: 10px 18px;
     background-color: #007bff;
     color: white;
     text-decoration: none;
     border-radius: 6px;
     font-weight: bold;
     transition: background-color 0.3s ease;
    }

     .view-btn:hover {
      background-color: #0056b3;
     }


    @media(max-width: 768px) {
      .event-video-section {
        flex-direction: column;
      }

    }

   @keyframes fadeIn {
     from { opacity: 0; transform: scale(0.9); }
     to { opacity: 1; transform: scale(1); }
   }
   .sidebar a:hover {
     background-color: #003580;
   }

  .tabs {
    display: flex;
    background-color: #0a2472;
    justify-content: center;
    padding: 10px 0;
    margin-top: 90px;
  }
  .tab {
    flex: 1;
    text-align: center;
    color: white;
    font-weight: bold;
    padding: 15px 0;
    background-color: #0a2472;
    border-right: 1px solid #0a2472;
  }

  .tab:last-child {
    border-right: none;
  }

  .content-wrapper {
    display: flex;
    justify-content: space-between;
    padding: 40px;
    background-color: #ffffff;
    flex-wrap: wrap;
    flex-grow: 1;
  }

  .left-section, .right-section {
    width: 48%;
    margin-bottom: 40px;
  }

  .left-section h3,
  .right-section h3 {
    color: #0a2472;
    margin-bottom: 15px;
  }

  .left-section p {
    font-size: 14px;
    line-height: 1.8;
    color: #333;
  }

  .mission-list {
    list-style: none;
    padding: 0;
  }

  .mission-list li {
    background-color: #0a2472;
    color: white;
    padding: 10px 15px;
    margin-bottom: 10px;
    border-radius: 5px;
    font-weight: bold;
  }

  .mission-list li:nth-child(2) {
    background-color: #0a2472;
  }

  .mission-list li:nth-child(3) {
    background-color: #0a2472;
  }


/* Footer Base */
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
}

/* Unified Header Styling */
h2, h3, h4, h5 {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-weight: 600;
    line-height: 1.3;
    color: #00c3ff;
    margin-bottom: 15px;
}



/* Specific Font Sizes */
h2 { font-size: 2rem;  }
h3 { font-size: 2rem; }
h4 { font-size: 2rem; }
h5 { font-size: 1.25rem; }
h6 { font-size: 1.25rem; }

/* Responsive Adjustments */
@media (max-width: 768px) {
    h2 { font-size: 1.6rem; }
    h3 { font-size: 1.4rem; }
    h4 { font-size: 1.2rem; }
    h5 { font-size: 1rem; }
    h { font-size: 1rem; }
}



  .center-text {
  text-align: center;
  margin: 20px 0; /* Optional: Adds spacing around the text */
}

   /* Sidebar link styles */
        .sidebar-link {
            padding: 15px 40px;
            text-decoration: none;
            color: white;
            display: block;
            transition: background 0.3s;
        }

        .sidebar-link:hover {
            background-color: white;
        }

        /* Slide-in modal container */
        .slide-modal {
            position: fixed;
            top: 0;
            right: -400px; /* hidden by default */
            width: 340px;
            height: 95%;
            background-color: #f4f9ff;
            box-shadow: -4px 0 15px rgba(0, 0, 0, 0.5);
            overflow-y: auto;
            transition: right 0.4s ease;
            padding: 30px;
            z-index: 9999;
        }

        .slide-modal.active {
            right: 0;
        }

        .slide-modal h2 {
            margin-top: 0;
            color: #0dcaf0;
        }

        .close-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 25px;
            color: black;
            cursor: pointer;
        }

.grid-section {
  display: flex;
  gap: 20px;
  flex-wrap: nowrap;
  overflow-x: auto;
  padding: 10px;
}

.grid-box {
  flex: 0 0 250px;
  background: #f5f5f5;
  padding: 72px;
  border-radius: 30px;
  text-align: center;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

.grid-box h3 { margin-bottom: 10px; }

.view-btn {
  padding: 8px 16px;
  background-color: #0a2472;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.view-btn:hover
{ background-color: #0056b3;

}



/* Modal */
.modal { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6); justify-content: center; align-items: center; z-index: 1000; }
.modal[aria-hidden="false"] { display: flex; }
.modal-content { background: white; padding: 20px; max-width: 90%; border-radius: 8px; position: relative; max-height: 90vh; overflow-y: auto; }
.close { position: absolute; top: 10px; right: 15px; font-size: 30px; cursor: pointer; }



    .institute-grid {
     height: 200px;
     display: flex;
     justify-content: center;
     flex-wrap: wrap;
     gap: 20px;
     margin-top: 30px;
    }

    .institute-item {
      width: 200px;
      height: 220px;
      background-color: #ffffff;
      border-radius: 15px;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      text-align: center;
      transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1); /* Smooth & elegant */
      cursor: pointer;
      padding: 20px 15px;
      position: relative;
    }

    .institute-item:hover {
      transform: scale(1.05); /* Slight zoom effect */
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
      background-color: #f0faff; /* Subtle background tint */
    }


    .institute-item img {
      width: 120px;
      height: 120px;
      object-fit: cover;
      border-radius: 50%;
      margin-bottom: 10px;
      transition: transform 0.3s;
    }

    .institute-item:hover img {
      transform: scale(1.5);
    }

    .institute-item p {
      font-weight: bold;
      color: #333;
      margin-bottom: 10px;
    }

    .view-btn {
      background-color:#0a2472;
      color: white;
      border: none;
      padding: 6px 14px;
      border-radius: 20px;
      cursor: pointer;
      transition: background-color 0.5s ease;
      font-size: 14px;
    }

    .view-btn:hover {
      background-color: #0056b3;
    }

    @media (max-width: 600px) {
    .institute-item {
      width: 100%;
      max-width: 300px;
     }
    }
/* Modal */
.modal {
  display: none;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 90%;
  margin-top: 2%;
  z-index: 999;
}

.modal-content {
  background-color: white;
  padding: 20px;
  width: 90%;
  height: 90%;
  overflow: auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.internal-close-btn {
  padding: 8px 16px;
  background-color: crimson;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.internal-close-btn:hover {
  background-color: darkred;
}

/* Cards */
.cards-container {
  display: flex;
  justify-content: space-between;
  width: 100%;
  margin-bottom: 20px;
  gap: 20px;

}

.card {
  flex: 1;
  background-color: #f1f1f1;
  padding: 15px;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  text-align: center;
}

/* Slideshow */
.slideshow-wrapper {
  display: flex;
  gap: 30px;
  overflow-x: hidden;
  padding: 20px;
  width: 100%;
}

.slide-img {
  width: 300px;
  height: auto;
  flex-shrink: 0;
  border-radius: 10px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  cursor: pointer;
}

.slide-img:hover {
  transform: scale(1.1);
  box-shadow: 0 4px 50px rgba(0, 0, 0, 0.3);
  z-index: 1;
}

/* Fullscreen Image Viewer */
.image-viewer {
  display: none;
  justify-content: center;
  align-items: center;
  position: fixed;
  z-index: 9999;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.9);
}

.image-viewer img {
  max-width: 90%;
  max-height: 90%;
  border-radius: 12px;
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
}

.close-viewer {
  position: absolute;
  top: 20px;
  right: 40px;
  font-size: 40px;
  color: white;
  cursor: pointer;
  font-weight: bold;
  z-index: 10000;
}
.modal-content {
  position: relative;
}

.internal-close-btn {
  position: absolute;
  top: 15px;
  right: 20px;
}

@media (max-width: 480px) {
    .slideshow, .slide-image {
        height: 300px;
    }

    .grid-box, .institute-item {
        flex: 0 0 90%;
        padding: 40px 20px;
    }

    .event-video-section .video-left,
    .event-video-section .video-right {
        flex: 1 1 100%;
        margin: 5px 0;
    }

    .content-wrapper {
        padding: 20px;
    }

    .left-section, .right-section {
        width: 100%;
        margin-bottom: 20px;
    }

    .tabs {
        flex-direction: column;
        gap: 5px;
    }

    .tab {
        border-right: none;
        padding: 12px 0;
    }

    .cards-container {
        flex-direction: column;
        gap: 15px;
    }

    .slideshow-wrapper {
        gap: 15px;
        padding: 10px;
        overflow-x: scroll;
    }

    .slide-img {
        width: 90%;
        height: auto;
    }

    .mission-list li {
        font-size: 14px;
        padding: 8px 12px;
    }

    .view-btn {
        font-size: 12px;
        padding: 6px 12px;
    }

    .slide-modal {
        width: 90%;
        padding: 20px;
    }

    .modal-content {
        width: 95%;
        height: 85%;
    }

    .institute-grid {
        justify-content: center;
    }

    .institute-item img {
        width: 100px;
        height: 100px;
    }

    h2 { font-size: 1.5rem; }
    h3 { font-size: 1.2rem; }
    h4 { font-size: 1.1rem; }
    h5, h6 { font-size: 1rem; }
}

</style>

</head>
<body>

  <!-- Header -->
<div class="header" style="display: flex; justify-content: space-between; align-items: center; background-color: #0a2472; color: white; padding: 20px 20px;">
  <span class="menu-toggle" onclick="toggleSidebar()" style="font-size: 24px; cursor: pointer;">&#9776;</span> <!-- ☰ icon -->
   <h1 style="margin: 0; text-align: center; flex: 1;">Student Dashboard</h1>
</div>

<!-- Sidebar -->
<div id="sidebar" class="sidebar"
     style="height: 100%; width: 0; position: fixed; top: 0; left: 0;
            background-color: #001f54; overflow-x: hidden; transition: 0.3s;
            padding-top: 60px; z-index: 1000;">

    <!-- Close Button -->
    <a href="javascript:void(0)" class="closebtn" onclick="toggleSidebar()"
       style="position: absolute; top: 10px; right: 20px; font-size: 36px;
              text-decoration: none; color: white;">&times;</a>

    <!-- Sidebar Links -->
    <a href="Student page.aspx" class="sidebar-link"
       style="padding: 20px 40px; text-decoration: none; color: white; display: block;">👤 Profile</a>

    <a href="#" class="sidebar-link" onclick="openSlide('contact')"
       style="padding: 20px 40px; text-decoration: none; color: white; display: block;">📞 Contact</a>

    <a href="#" class="sidebar-link" onclick="openSlide('about')"
       style="padding: 20px 40px; text-decoration: none; color: white; display: block;">ℹ️ About</a>

    <a href="Available course.aspx" class="sidebar-link"
      style="padding: 20px 40px; text-decoration: none; color: white; display: block;">
      📚 View Courses
      </a>


    <!-- Contact Slide -->
    <div id="contact" class="slide-modal">
        <span class="close-btn" onclick="closeSlide('contact')">&times;</span>
        <h2>Contact Us</h2>
        <p>If you’d like to reach out, please contact us through:</p>
        <ul>
            <li>Email: support@example.com</li>
            <li>Phone: +63 912 345 6789</li>
            <li>Address: Malita, Davao Occidental</li>
        </ul>
    </div>

    <!-- About Slide -->
    <div id="about" class="slide-modal">
    <span class="close-btn" onclick="closeSlide('about')">&times;</span>
    <h2>About</h2>
    <p>
        This system helps manage online courses efficiently and promotes sustainability through digital learning. 
        It provides easy access to course materials, modules, and assessments all in one convenient platform.
    </p>
    <h3 style="color:#0dcaf0;">✅ Do’s</h3>
    <ul>
        <li>Use your account responsibly and keep your login information secure.</li>
        <li>Regularly check for new modules, quizzes, and announcements.</li>
        <li>Submit your activities and assessments before the deadline.</li>
        <li>Report any technical issues or errors to the system administrator.</li>
    </ul>
    <h3 style="color:#ff4d4d;">❌ Don’ts</h3>
    <ul>
        <li>Do not share your account credentials with others.</li>
        <li>Do not upload irrelevant or inappropriate content.</li>
        <li>Do not attempt to manipulate or hack the system.</li>
        <li>Do not ignore updates or feedback from instructors.</li>
        <li>Do not use the system for non-academic purposes.</li>
    </ul>
    <p>
        By following these guidelines, users can ensure a safe, productive, and sustainable digital learning environment.
    </p>
</div>


    <script>
        function openSlide(id) {
            document.getElementById(id).classList.add("active");
        }

        function closeSlide(id) {
            document.getElementById(id).classList.remove("active");
        }
    </script>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        if (sidebar.style.width === "250px") {
            sidebar.style.width = "0";
        } else {
            sidebar.style.width = "250px";
        }
    }
</script>

 <div class="slideshow">
  <img class="slide-image" src="images/44.png" alt="Slide 1" />
  <img class="slide-image" src="images/56.jpg" alt="Slide 2" />
  <img class="slide-image" src="images/57.jpg" alt="Slide 3" />
  <img class="slide-image" src="images/58.jpeg" alt="Slide 4" />
  <img class="slide-image" src="images/59.png" alt="Slide 5" />
</div>

<script>
  let slideIndex = 0;
  const slides = document.querySelectorAll(".slide-image");

  function showSlides() {
    slides.forEach((slide, index) => {
      slide.classList.remove("active");
    });

    slideIndex++;
    if (slideIndex > slides.length) {
      slideIndex = 1;
    }

    slides[slideIndex - 1].classList.add("active");
    setTimeout(showSlides, 3000); // Change slide every 3 seconds
  }

  // Start the slideshow
  showSlides();
</script>
<!-- Grid Section -->
<div class="grid-section">
  <div class="grid-box">
    <h3>Courses</h3>
    <p>Discover tailored courses designed to match your interests and career goals.</p>
    <a href="course.aspx" class="view-btn">View</a>
  </div>

  <div class="grid-box">
    <h3>Achievements</h3>
    <p>Be inspired by our students’ academic, sports, and research excellence.</p>
    <button class="view-btn btn btn-primary" data-type="achievements">View</button>
  </div>

  <div class="grid-box">
    <h3>Activities</h3>
    <p>Engage in vibrant extracurricular activities that boost your skills and confidence.</p>
    <button class="view-btn btn btn-primary" data-type="activities">View</button>
  </div>

  <div class="grid-box">
    <h3>Job Opportunities</h3>
    <p>Explore job listings and internships to jumpstart your professional journey.</p>
    <button class="view-btn btn btn-primary" data-type="jobs">View</button>
  </div>
</div>

<!-- Modal -->
<div id="popupModal" class="modal" aria-hidden="true">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2 id="modalTitle">Details</h2>
    <p id="modalDescription">More info will be displayed here.</p>

    <!-- Image gallery container -->
    <div id="modalImageContainer" style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center;"></div>

    <!-- Video gallery container -->
    <div id="modalVideoContainer" style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center;"></div>

    <!-- Two-column job list container -->
    <div id="modalJobContainer" style="display: flex; gap: 50px; justify-content: center; flex-wrap: wrap; margin-top:20px;">
      <ul id="modalJobListLeft" style="list-style-type: disc; padding-left: 20px;"></ul>
      <ul id="modalJobListRight" style="list-style-type: disc; padding-left: 20px;"></ul>
    </div>
  </div>
</div>



<script>
    (function () {
        const modal = document.getElementById("popupModal");
        const modalTitle = document.getElementById("modalTitle");
        const modalDescription = document.getElementById("modalDescription");

        const modalImageContainer = document.getElementById("modalImageContainer");
        const modalVideoContainer = document.getElementById("modalVideoContainer");

        const jobListLeft = document.getElementById("modalJobListLeft");
        const jobListRight = document.getElementById("modalJobListRight");

        const closeBtn = modal.querySelector(".close");

        function setContent(type) {

            // Reset all modal containers
            modalImageContainer.innerHTML = "";
            modalVideoContainer.innerHTML = "";
            jobListLeft.innerHTML = "";
            jobListRight.innerHTML = "";

            modalDescription.style.fontSize = "20px";
            modalDescription.style.textAlign = "justify";
            modalDescription.style.lineHeight = "1.6";

            switch (type) {

                case 'achievements':
                    modalTitle.textContent = "Achievements";
                    modalDescription.textContent = "This gallery highlights School journeys, success stories, and opportunities waiting for you. See how our graduates from SPAMAST have excelled academically, in research, sports, and community service.";

                    const achievementImages = ["images/1.png", "images/4.png", "images/5.png", "images/6.png", "images/7.png", "images/8.png"];
                    achievementImages.forEach(src => {
                        const img = document.createElement("img");
                        img.src = src;
                        img.style.width = "400px";
                        img.style.borderRadius = "5px";
                        img.style.margin = "5px";
                        modalImageContainer.appendChild(img);
                    });
                    break;

                case 'activities':
                    modalTitle.textContent = "Activities";
                    modalDescription.textContent =
                        "We offer clubs, student councils, music and arts programs, community outreach, and more.";

                    const activityVideos = [
                        { src: "video/F.mp4", description: "Student Council Event Highlights showcases recorded highlights of student council activities. Users can watch event videos directly on the website or mobile device, with easy play controls for a smooth viewing experience. Only one video plays at a time to avoid overlap, ensuring clear audio and better focus." },
                        { src: "video/hiyas.mp4", description: "This video highlights the Art and Music Club performance during the SPAMAST founding anniversary. It features creative presentations, live music, and cultural performances that celebrate the institution’s history and student talent." },
                        { src: "video/spamast.mp4", description: "This video features the SPAMAST Intramurals activity, showcasing various sports events, team competitions, and student participation. It highlights school spirit, teamwork, and physical fitness during the intramurals celebration." }
                    ];

                    modalVideoContainer.innerHTML = "";

                    activityVideos.forEach((item, index) => {
                        // Card container
                        const card = document.createElement("div");
                        card.style.width = "100%";
                        card.style.maxWidth = "900px";
                        card.style.margin = "20px auto";
                        card.style.padding = "20px";
                        card.style.background = "#f4f9ff";
                        card.style.borderRadius = "12px";
                        card.style.boxShadow = "0 2px 8px rgba(0,0,0,0.1)";
                        card.style.display = "flex";
                        card.style.alignItems = "center";
                        card.style.gap = "20px";

                        // Alternate left / right
                        card.style.flexDirection = index % 2 === 0 ? "row" : "row-reverse";

                        // Video
                        const vid = document.createElement("video");
                        vid.src = item.src;
                        vid.controls = true;
                        vid.style.width = "55%";
                        vid.style.borderRadius = "10px";

                        vid.addEventListener("play", () => {
                            modalVideoContainer.querySelectorAll("video").forEach(v => {
                                if (v !== vid) v.pause();
                            });
                        });

                        // Description
                        const desc = document.createElement("p");
                        desc.textContent = item.description;
                        desc.style.fontSize = "20px";
                        desc.style.color = "#0a2472";
                        desc.style.width = "45%";
                        desc.style.margin = "0";
                        desc.style.textAlign = "left";

                        // Append
                        card.appendChild(vid);
                        card.appendChild(desc);
                        modalVideoContainer.appendChild(card);
                    });
                    break;



                case 'jobs':
                    modalTitle.textContent = "Job Opportunities";
                    modalDescription.textContent = "Browse internships and career opportunities related to SPAMAST courses.";

                    // Job lists
                    const jobsLeftList = [
                        "Software Developer Internship - TechCorp", // BSIT
                        "Network Administrator Trainee - NetSolutions",
                        "Web Developer Intern - Creative Web Studio",
                        "Data Analyst Intern - SPAMAST Research Lab",
                        "Hotel Management Trainee - Grand SPAMAST Hotel", // BSHM
                        "Front Office Assistant Intern - Luxury Resorts",
                        "Food & Beverage Service Intern - Gourmet Kitchens"
                    ];

                    const jobsRightList = [
                        "Accounting Assistant - SPAMAST Accounting Firm", // BSA
                        "Financial Analyst Intern - FinCorp",
                        "Business Development Intern - Global Solutions",
                        "Police Trainee - Local Police Department", // BSCRIM
                        "Investigation Assistant Intern - Crime Lab",
                        "Student Teacher / Practicum - Local Schools", // BSED
                        "Educational Program Assistant - Community Learning Center"
                    ];

                    jobsLeftList.forEach(job => {
                        const li = document.createElement("li");
                        li.textContent = job;
                        li.style.marginBottom = "8px";
                        li.style.fontSize = "25px";
                        jobListLeft.appendChild(li);
                    });

                    jobsRightList.forEach(job => {
                        const li = document.createElement("li");
                        li.textContent = job;
                        li.style.marginBottom = "8px";
                        li.style.fontSize = "25px";
                        jobListRight.appendChild(li);
                    });
                    break;

                default:
                    modalTitle.textContent = "Information";
                    modalDescription.textContent = "Details not available.";
            }
        }

        function openPopup(type) {
            setContent(type);
            modal.setAttribute("aria-hidden", "false");
        }

        function closeModal() {
            modal.setAttribute("aria-hidden", "true");
            modalVideoContainer.querySelectorAll("video").forEach(v => v.pause());
        }

        document.querySelectorAll("[data-type]").forEach(btn => {
            btn.addEventListener("click", () => openPopup(btn.dataset.type));
        });

        closeBtn.addEventListener("click", closeModal);
        modal.addEventListener("click", e => { if (e.target === modal) closeModal(); });
        document.addEventListener("keydown", e => { if (e.key === "Escape") closeModal(); });

    })();
</script>


  <!-- Event + Video Section -->
 <div class="event-video-section">
  <div class="video-left">
    <video controls width="150%" height="auto">
      <source src="video/hiyas.mp4" type="video/mp4" />
      Your browser does not support the video tag.
    </video>
  </div>
    <div class="video-right">
      <h2>Empowering Your Future</h2>
      <p>
        This video highlights real student journeys, success stories, and opportunities waiting for you.
        Dive deep into programs that align with your passions, talents, and future goals.
        Let your journey start here choose wisely, plan purposefully, and rise confidently.
        Each student has a unique path, and this is your chance to discover yours. Whether you're dreaming of becoming a healthcare professional,
        a tech expert, a business leader, or a creative artist there’s a program that fits your ambition.
        Our institution is built to guide you toward making that dream a reality.
        Hear from graduates who turned challenges into triumphs, mentors who sparked breakthroughs, and peers who became lifelong friends. 
        Their stories are more than just testimonials they’re proof that with the right support and determination, success is within your reach.
        Your future starts with a decision today. Explore, engage, and evolve. Step into a learning environment where innovation meets inspiration. 
        We believe in your potential now it’s time for you to believe in it, too.
      </p>
    </div>
  </div>
     <!-- Event + Video Section -->
<div class="event-video-section">
 <div class="video-left">
   <video controls width="150%" height="auto">
     <source src="video/spamast.mp4" type="video/mp4" />
     Your browser does not support the video tag.
   </video>
 </div>
   <div class="video-right">
     <h2>School For Your Future</h2>
     <p>
       The Southern Philippines Agri-Business and Marine and Aquatic School of Technology (SPAMAST)
       is a state-run higher education institution located in Malita, Davao Occidental. 
       It is committed to providing quality education, research, and extension services, 
       particularly in the fields of agriculture, fisheries, marine sciences, business, and technology. 
       SPAMAST plays a vital role in developing skilled professionals who can contribute to sustainable rural and economic development, 
       especially in underserved communities. With its focus on innovation, community involvement, and academic excellence, 
       SPAMAST continues to empower students to become responsible leaders and contributors to nation-building.
     </p>
   </div>
 </div>
<!-- Institute Grid -->
<div class="institute-grid">
  <div class="institute-item" onclick="openModal('IHS')">
    <img src="images/IHS logo.jpg" alt="IHS Logo">
    <p>IHS</p>
    <button class="view-btn">View</button>
  </div>
  <div class="institute-item" onclick="openModal('ITED')">
    <img src="images/ITED logo.jpg" alt="ITED Logo">
    <p>ITED</p>
    <button class="view-btn">View</button>
  </div>
  <div class="institute-item" onclick="openModal('ICET')">
    <img src="images/ICET logo.jpg" alt="ICET Logo">
    <p>ICET</p>
    <button class="view-btn">View</button>
  </div>
  <div class="institute-item" onclick="openModal('IBMG')">
    <img src="images/IBMG logo.jpg" alt="IBMG Logo">
    <p>IBMG</p>
    <button class="view-btn">View</button>
  </div>
  <div class="institute-item" onclick="openModal('IFMS')">
    <img src="images/IFMS logo.jpg" alt="IFMS Logo">
    <p>IFMS</p>
    <button class="view-btn">View</button>
  </div>
  <div class="institute-item" onclick="openModal('IASDC')">
    <img src="images/IASDC logo.jpg" alt="IASDC Logo">
    <p>IASDC</p>
    <button class="view-btn">View</button>
  </div>
</div>

<div id="fullscreenModal" class="modal">
  <div class="modal-content">
    <button class="internal-close-btn" onclick="closeModal()">✕</button>


    <h2 id="modalTitle"></h2>

    <!-- Cards Section -->
    <div class="cards-container">
      <div class="card left-card" id="leftCard"></div>
      <div class="card right-card" id="rightCard"></div>
    </div>

    <!-- Slideshow -->
    <div class="slideshow-wrapper"></div>
  </div>
</div>

<!-- Fullscreen Image Viewer -->
<div id="imageViewer" class="image-viewer">
  <span class="close-viewer" onclick="closeImageViewer()">&times;</span>
  <img id="viewerImage" src="" alt="Full View">
</div>



<!-- Script -->
<script>
    const instituteData = {
        IHS: {
            title: "IHS",
            leftCard: "IHS offers comprehensive programs in Criminology and Social Work, designed to equip students with theoretical knowledge and practical skills in criminal justice, social welfare, community development, and human behavior. Core course content includes criminology, law enforcement, forensic studies, social work practice, ethics, research methods, and community engagement. Students actively participate in fieldwork, research projects, internships, and community outreach programs, allowing them to apply classroom learning to real-world situations and develop professional competencies in public safety, social services, and community development.",
            rightCard: "IHS students and faculty have received recognition and awards for excellence in research, community service, academic performance, and professional practice. These achievements reflect the strength of the program’s curriculum, emphasizing practical experience, ethical practice, social responsibility, and impactful community engagement. Through fieldwork, internships, and collaborative initiatives, IHS continues to produce graduates who are competent, socially responsible, and prepared to contribute meaningfully to criminology and social work sectors.",
            images: ["images/IHS.jpg", "images/IHS1.jpg", "images/IHS2.jpg", "images/IHS3.jpg", "images/IHS4.jpg", "images/IHS5.jpg", "images/IHS6.jpg", "images/IHS7.jpg", "images/IHS8.jpg"]
        },
        ITED: {
            title: "ITED",
            leftCard: "ITED focuses on comprehensive Education programs for aspiring teachers, designed to develop both pedagogical knowledge and practical teaching skills. Core course content includes educational theory, curriculum development, instructional strategies, classroom management, educational technology, assessment methods, and community-based learning. Students actively participate in teaching practice, seminars, workshops, and community education projects, allowing them to apply theory in real classroom settings and develop the skills needed for effective teaching and leadership in education.",
            rightCard: "ITED students and faculty have received recognition and awards for excellence in teaching, innovative lesson design, curriculum development, and community outreach initiatives. These achievements reflect the strength of the program’s core curriculum, emphasizing practical teaching experience, creativity, educational research, and impactful community engagement. Through hands-on practice and collaborative projects, ITED continues to produce competent, innovative, and socially responsible educators.",
            images: ["images/ITED.jpg", "images/ITED 1.jpg", "images/ITED 2.jpg", "images/ITED 3.png", "images/ITED 4.jpg", "images/ITED 5.jpg", "images/ITED 6.jpg", "images/ITED 7.jpg", "images/ITED 8.jpg"]
        },
        ICET: {
            title: "ICET",
            leftCard: "ICET offers comprehensive programs in Engineering and Technology, designed to provide students with strong theoretical foundations and practical skills in various engineering fields. Core course content includes mechanical, electrical, and civil engineering principles, electronics, computer-aided design, robotics, programming, and project management. Students actively participate in hands-on projects, technical competitions, laboratory experiments, and research activities, allowing them to apply classroom knowledge to real-world engineering challenges while developing problem-solving and innovative thinking skills.",
            rightCard: "ICET students and faculty have earned recognition and awards in innovation, robotics, technical competitions, and industry-relevant research projects. These accomplishments reflect the strength of the program’s curriculum, emphasizing practical skills, creativity, and research excellence. Through projects, competitions, and collaborative initiatives with industry, ICET continues to produce graduates who are competent, innovative, and ready to contribute to the engineering and technology sectors.",
            images: ["images/ICET.jpg", "images/ICET 1.jpg", "images/ICET 2.jpg", "images/ICET 3.jpg", "images/ICET 4.jpg", "images/ICET 5.jpg", "images/ICET 6.jpg", "images/ICET 7.jpg", "images/ICET 8.jpg"]
        },
        IBMG: {
            title: "IBMG",
            leftCard: "IBMG offers comprehensive programs in Public Administration, Office Administration, and Agribusiness, designed to equip students with practical and theoretical knowledge in management, governance, business operations, and agricultural entrepreneurship. Core course content includes leadership development, organizational management, business planning, financial literacy, office systems, agribusiness management, project development, and community engagement. Students actively participate in internships, workshops, research projects, and community development initiatives, applying their skills to real-world situations while enhancing their professional competencies and social responsibility.",
            rightCard: "IBMG students and faculty have received recognition and awards for excellence in leadership, entrepreneurship, innovative business solutions, and community service. These achievements reflect the strength of the program’s core curriculum, emphasizing practical skills, problem-solving, innovation, and effective community engagement. Through internships, business projects, and outreach programs, IBMG continues to prepare graduates who are competent, socially responsible, and capable of contributing meaningfully to the business and public sectors.",
            images: ["images/IBMG.jpg", "images/IBMG 1.jpg", "images/IBMG 2.jpg", "images/IBMG 3.jpg", "images/IBMG 4.jpg", "images/IBMG 5.jpg", "images/IBMG 6.jpg", "images/IBMG 7.jpg", "images/IBMG 8.jpg"]
        },
        IFMS: {
            title: "IFMS",
            leftCard: "IFMS offers comprehensive programs in Marine and Fisheries Science designed to equip students with knowledge and practical skills in marine biology, fisheries management, aquaculture, oceanography, and environmental conservation. The core course content covers sustainable fisheries practices, marine ecosystem studies, aquatic resource management, coastal and community development, research methodology, and applied aquaculture techniques. Students actively participate in field research, aquaculture projects, coastal community initiatives, and hands-on laboratory work, allowing them to apply theoretical learning to real-world challenges in marine science.",
            rightCard: "IFMS students and faculty have received recognition and awards for excellence in marine research, sustainable fisheries practices, and community service. These achievements highlight the strength of the program’s core curriculum, which emphasizes scientific research, environmental stewardship, practical skills, and impactful community engagement. Through research projects, coastal outreach programs, and sustainable aquaculture initiatives, IFMS continues to contribute significantly to marine science, resource conservation, and the development of competent, socially responsible graduates.",
            images: ["images/IFMS.jpg", , "images/IFMS 1.jpg", "images/IFMS 2.jpg", "images/IFMS 3.jpg", "images/IFMS 4.jpg", "images/IFMS 5.jpg", "images/IFMS 6.jpg", "images/IFMS 7.jpg", "images/IFMS 8.jpg"]
        },
        IASDC: {
            title: "IASDC",
            leftCard: "IASDC offers comprehensive programs in Arts and Social Development designed to develop creativity, cultural awareness, and social responsibility. The core course content includes cultural and heritage studies, performing and visual arts, creative expression, social research, community development, leadership, and civic engagement. Students are trained to analyze social issues, promote cultural preservation, and use artistic platforms to inspire positive change. Learning is enriched through active participation in cultural events, art exhibits, workshops, outreach programs, and community service projects, allowing students to apply theoretical knowledge in real-world settings.",
            rightCard: "IASDC students and faculty consistently receive recognition and awards for excellence in the arts, cultural contributions, and social development initiatives. These achievements highlight the strength of the program’s core curriculum, which emphasizes artistic excellence, innovation, leadership, and meaningful community involvement. Through performances, exhibitions, research projects, and outreach activities, IASDC continues to make a significant impact on both the academic community and society, fostering graduates who are culturally grounded, socially aware, and committed to service.",
            images: ["images/IASDC.jpg", "images/IASDC 1.jpg", "images/IASDC 2.jpg", "images/IASDC 2.jpg", "images/IASDC 3.jpg", "images/IASDC 4.jpg", "images/IASDC 5.jpg", "images/IASDC 6.jpg", "images/IASDC 7.jpg", "images/IASDC 8.jpg"]
        }
    };

    let autoSlideInterval;

    function openModal(instituteKey) {
        const modal = document.getElementById("fullscreenModal");
        const title = document.getElementById("modalTitle");
        const wrapper = document.querySelector(".slideshow-wrapper");
        const leftCard = document.getElementById("leftCard");
        const rightCard = document.getElementById("rightCard");

        const data = instituteData[instituteKey];

        modal.style.display = "flex";
        title.innerText = data.title;
        leftCard.innerText = data.leftCard || "";
        rightCard.innerText = data.rightCard || "";

        wrapper.innerHTML = "";
        const combinedImages = data.images.concat(data.images); // smooth loop

        combinedImages.forEach(src => {
            const img = document.createElement("img");
            img.src = src;
            img.className = "slide-img";
            img.onclick = () => showFullscreenImage(src);
            wrapper.appendChild(img);
        });

        wrapper.scrollLeft = 0;

        clearInterval(autoSlideInterval);
        autoSlideInterval = setInterval(() => {
            wrapper.scrollLeft += 1;
            if (wrapper.scrollLeft >= wrapper.scrollWidth / 2) wrapper.scrollLeft = 0;
        }, 10);
    }

    function closeModal() {
        document.getElementById("fullscreenModal").style.display = "none";
        clearInterval(autoSlideInterval);
    }

    function showFullscreenImage(src) {
        const viewer = document.getElementById("imageViewer");
        const img = document.getElementById("viewerImage");
        img.src = src;
        viewer.style.display = "flex";
    }

    function closeImageViewer() {
        document.getElementById("imageViewer").style.display = "none";
    }
</script>

  <div class="tabs">
    <div class="tab">MOOCs</div>
    <div class="tab">SCHOOL</div>
  </div>

  <!-- Content -->
  <div class="content-wrapper">
    <div class="left-section">
      <h3>WELCOME TO THIS WEBSITE</h3>
     <p>To use this website effectively for learning, start by exploring the various sections available. Begin with the tabs at the top, where you can easily navigate between different topics, such as Accounting or Migration, depending on your interests. Each section offers valuable information and resources designed to enhance your learning experience. For example, in the grid section, you'll find engaging content like articles, videos, and tutorials that you can explore at your own pace. Additionally, the event and video sections offer a mix of multimedia content that makes learning more interactive. If you want to dive deeper, the footer provides links for subscribing to newsletters and accessing additional resources. Remember to check out the social media icons for updates and community engagement. By using the interactive features and resources available on this website, you’ll be able to learn and grow efficiently.
</p>
    </div>
    <div class="right-section">
      <h3>OUR MISSION :</h3>
      <ul class="mission-list">
        <li>Deliver the best quality of work and personalised services</li>
        <li>Maximise client value and satisfaction</li>
        <li>Provide a Course</li>
      </ul>
    </div>
  </div>

          <!-- FOOTER -->
       <footer id="footer" class="footer">
    <div class="footer-container">
        
        <!-- Logo + Tagline -->
        <div class="footer-column">
            <h2>MOOCs Learning Hub</h2>
            <p>Learn. Grow. Succeed.</p>
        </div>

        <!-- Contact -->
        <div class="footer-column">
            <h3>Contact Us</h3>
            <p>Email: info@moocs.edu</p>
            <p>Phone: 09603160606</p>
        </div>

        <!-- Logo Image -->
        <div class="footer-column footer-image">
            <img src="images/Lo.png" alt="MOOCs Logo" />
        </div>
    </div>

    <div class="footer-bottom">
        &copy; 2025 MOOCs. All rights reserved.
    </div>
</footer>

    <script type="text/javascript">
        window.onload = function () {
            // Prevent cached back navigation
            if (performance && performance.navigation.type === 2) {
                location.href = 'login.aspx';
            }
        };

        window.onpageshow = function (event) {
            if (event.persisted) {
                location.href = 'login.aspx';
            }
        };
    </script>
    <script>
        // Select all video elements on the page
        const videos = document.querySelectorAll("video");

        videos.forEach(video => {
            // When a video starts playing
            video.addEventListener("play", () => {
                videos.forEach(v => {
                    if (v !== video) {
                        v.pause(); // pause other videos
                        // Optional: mute other videos instead of pausing
                        // v.muted = true;
                    }
                });
            });

            // Optional: if you want to automatically unmute the playing video
            video.addEventListener("play", () => {
                video.muted = false;
            });
        });
    </script>


</body>
</html>
