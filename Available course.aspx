<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Available course.aspx.cs" Inherits="MOOCs.Available_course" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAMAST Institutes & Courses</title>
     <link rel="icon" type="image/x-icon" href="images/Favicon-course.ico"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts - Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6; /* Light gray background */
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure body takes at least full viewport height */
        }
        main {
            flex-grow: 1; /* Allow main content to grow and push footer down */
        }
        /* Custom scrollbar for better aesthetics, if desired */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        .main-header {
         background:  #0a2472;
         color: white;
         box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
         padding: 16px 24px;
        }

        .header-container {
         max-width: 1200px;
         margin: 0 auto;
         position: relative;
         display: flex;
         justify-content: center;
         align-items: center;
         padding: 16px 0;
        }

        .header-title {
          position: absolute;
          left: 50%;
          transform: translateX(-50%);
          font-size: 1.5rem;
          font-weight: bold;
          text-decoration: none;
          color: white;
          letter-spacing: 1px;
        }

        .header-left {
          position: absolute;
          left: -150px;
         
        }

        .back-btn {
         color: white;
         text-decoration: none;
         transition: 0.3s;
        }

        .back-btn:hover {
          color: #60a5fa; /* hover:text-blue-400 */
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




    </style>
</head>
<body class="antialiased">
    <!-- Header Section -->
   <header class="main-header">
  <div class="header-container">
    <a href="#" class="header-title">SPAMAST</a>

    <div class="header-left">
      <a href="home.aspx" class="back-btn">
        <i class="fa-solid fa-arrow-left"></i> Back
      </a>
    </div>
  </div>
</header>


    <!-- Main Content Area -->
    <main class="container mx-auto p-4 sm:p-6 lg:p-8">
        <!-- Introduction Section -->
        <section class="text-center py-8 mb-10 bg-white rounded-xl shadow-md p-6">
            <h1 class="text-4xl sm:text-5xl font-extrabold text-gray-900 leading-tight">
                Academic Programs at SPAMAST
            </h1>
            <p class="mt-4 text-lg text-gray-700 max-w-2xl mx-auto">
                Discover a wide array of programs designed to equip students with the knowledge and skills needed for success in various fields.
                Each institute offers specialized courses tailored to industry demands and societal needs.
            </p>
        </section>

        <!-- Institutes Grid Container -->
        <div id="institutes-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <!-- Institute cards will be injected here by JavaScript -->
        </div>
    </main>

    <script>
        // Data for SPAMAST Institutes and their courses
        const institutesData = [
            {
                name: "ITED",
                imageUrl: "https://placehold.co/600x400/3b82f6/ffffff?text=ITED", // Blue
                courses: [
                    "Bachelor of Secondary Education - Major in English",
                    "Bachelor of Secondary Education - Major in Mathematics",
                    "Bachelor of Secondary Education - Major in Science",
                    "Bachelor of Elementary Education ",
                ]
            },
            {
                name: "IHS",
                imageUrl: "https://placehold.co/600x400/10b981/ffffff?text=IHS", // Green
                courses: [
                    "Bachelor of Science in Social Work (BSSW)",
                    "Bachelor of Science in Criminology (BSCrim)"
                ]
            },
            {

                name: "ICET",
                imageUrl: "https://placehold.co/600x400/f59e0b/ffffff?text=ICET", // Amber
                courses: [
                    "Bachelor of Science in Information Technology",
                    "Bachelor of Science in Agricultural Engineering",
                    "Association in Computer Technology",
                ]
            },
            {
                name: "IBMG",
                imageUrl: "https://placehold.co/600x400/f59e0b/ffffff?text=IBMG", // Amber
                courses: [
                    "Bachelor of Science in Office Administration (BSOA)",
                    "Bachelor of Science in Public Administration (BPA)",
                    "Bachelor of Science in Agri-bussness (BSAB)",
                ]
            },
            {
                name: "IFMS",
                imageUrl: "https://placehold.co/600x400/06b6d4/ffffff?text=IFMS", // Cyan
                courses: [
                    "Bachelor of Science in Fisheries ",
                    "Bachelor of Science in Marine Biology ",
                    "Bachelor of Science in Environmental Science "
                ]
            }
        ];

        // Get the grid container element
        const institutesGrid = document.getElementById('institutes-grid');

        // Function to create and append an institute card
        function createInstituteCard(institute) {
            // Create the main card div
            const card = document.createElement('div');
            card.className = 'bg-white rounded-xl shadow-lg overflow-hidden transform transition duration-300 hover:scale-105 hover:shadow-xl flex flex-col';

            // Create the image container
            const imgContainer = document.createElement('div');
            imgContainer.className = 'relative w-full h-48 sm:h-56 overflow-hidden';
            const img = document.createElement('img');
            img.src = institute.imageUrl;
            img.alt = `Image for ${institute.name}`;
            img.className = 'w-full h-full object-cover';
            img.onerror = function() {
                // Fallback image if the provided URL fails
                this.onerror=null;
                this.src='https://placehold.co/600x400/d1d5db/4b5563?text=Image+Unavailable';
            };
            imgContainer.appendChild(img);
            card.appendChild(imgContainer);

            // Create the content div
            const contentDiv = document.createElement('div');
            contentDiv.className = 'p-5 flex flex-col flex-grow';

            // Institute Name
            const instituteName = document.createElement('h3');
            instituteName.className = 'text-2xl font-bold text-gray-900 mb-3';
            instituteName.textContent = institute.name;
            contentDiv.appendChild(instituteName);

            // Courses List
            const coursesList = document.createElement('ul');
            coursesList.className = 'list-disc list-inside text-gray-700 flex-grow text-base space-y-1';
            institute.courses.forEach(course => {
                const listItem = document.createElement('li');
                listItem.className = 'leading-relaxed';
                listItem.textContent = course;
                coursesList.appendChild(listItem);
            });
            contentDiv.appendChild(coursesList);

            card.appendChild(contentDiv);
            institutesGrid.appendChild(card);
        }

        // Loop through the data and create cards for each institute
        document.addEventListener('DOMContentLoaded', () => {
            institutesData.forEach(institute => {
                createInstituteCard(institute);
            });

            // Set current year in footer
            document.getElementById('current-year').textContent = new Date().getFullYear();
        });
    </script>

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

</body>
</html>

