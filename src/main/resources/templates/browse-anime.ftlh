<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AniWatch - Browse Anime</title>

  <!-- Stylesheets -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

  <style>
    :root {
      --primary-color: #3498db;
      --primary-dark: #2980b9;
      --secondary-color: #2c3e50;
      --dark-bg: #1a1e25;
      --card-bg: #2c3e50;
      --text-light: #ecf0f1;
      --text-muted: #bdc3c7;
      --success: #2ecc71;
      --warning: #f1c40f;
      --danger: #e74c3c;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #1a1e25 0%, #2c3e50 100%);
      color: var(--text-light);
      line-height: 1.6;
      min-height: 100vh;
    }

    /* Navigation Bar */
    .topnav {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1000;
    }

    .logo {
      font-size: 28px;
      font-weight: 700;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      margin: 0;
    }

    .logo-link {
      text-decoration: none;
    }

    .nav-links {
      display: flex;
      gap: 20px;
      align-items: center;
    }

    .nav-links a {
      color: var(--text-light);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      position: relative;
      padding: 5px 0;
    }

    .nav-links a:before {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      transition: width 0.3s;
    }

    .nav-links a:hover:before {
      width: 100%;
    }

    .dropdown {
                  position: relative;
                  display: inline-block;
                  margin-bottom: 11px;
                }

                .dropdown-menu {
                  display: none;
                  position: absolute;
                  background-color: #222!important;
                  min-width: 160px;
                  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                  z-index: 1;
                  border-radius: 8px;
                  margin-top: 4px!important;
                  margin-right: -84px!important;
                }

                .dropdown:hover .dropdown-menu {
                  display: block;
                }

                .dropdown-menu a {
                  color: white;
                  padding: 12px 16px;
                  text-decoration: none;
                  display: block;
                }

                .dropdown-menu a:hover {
                  background-color: #495057;
                }

                .fa-user {
                margin-top: 14.5px;
                }

    /* Content Styles */
    .content {
      padding-top: 100px;
      padding-bottom: 50px;
    }

    /* Page Header */
    .page-header {
      text-align: center;
      margin-bottom: 40px;
      position: relative;
    }

    .page-header h2 {
      font-weight: 700;
      font-size: 36px;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .page-header h2:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 3px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
    }

    .page-header p {
      color: var(--text-muted);
      font-size: 18px;
      max-width: 600px;
      margin: 0 auto;
    }

    /* Search Bar */
    .search-bar {
      max-width: 800px;
      margin: 0 auto 50px;
      position: relative;
    }

    .search-bar .form-control {
      background-color: rgba(52, 73, 94, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 50px;
      padding: 15px 25px;
      color: var(--text-light);
      font-size: 16px;
      transition: all 0.3s;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .search-bar .form-control:focus {
      background-color: rgba(52, 73, 94, 0.5);
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
    }

    .search-bar .form-control::placeholder {
      color: rgba(255, 255, 255, 0.5);
    }

    .search-bar:before {
      content: '\f002';
      font-family: 'Font Awesome 5 Free';
      font-weight: 900;
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--primary-color);
      font-size: 20px;
      z-index: 1;
    }

    /* Section Headings */
    .section-heading {
      margin-bottom: 30px;
      position: relative;
      display: flex;
      align-items: center;
    }

    .section-heading h2 {
      font-weight: 600;
      font-size: 28px;
      color: var(--text-light);
      margin: 0;
      position: relative;
      padding-left: 15px;
    }

    .section-heading h2:before {
      content: '';
      position: absolute;
      left: 0;
      top: 0;
      height: 100%;
      width: 4px;
      background: linear-gradient(to bottom, #3498db, #9b59b6);
      border-radius: 2px;
    }

    /* Anime Cards */
    .anime-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.3s ease;
      height: 100%;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      margin-bottom: 20px;
    }

    .anime-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .anime-card img {
      width: 100%;
      height: 350px;
      object-fit: cover;
      transition: all 0.5s;
    }

    .anime-card:hover img {
      transform: scale(1.05);
    }

    .anime-card .card-body {
      padding: 20px;
      background: rgba(26, 30, 37, 0.9);
    }

    .anime-card .card-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 8px;
      color: var(--text-light);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .anime-card .card-text {
      font-size: 14px;
      color: var(--text-muted);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    /* Swiper Customization */
    .swiper {
      padding-bottom: 60px !important;
      padding-top: 10px;
    }

    .swiper-slide {
      height: auto;
    }

    .swiper-button-next,
    .swiper-button-prev {
      color: var(--primary-color) !important;
      background-color: rgba(26, 30, 37, 0.7);
      width: 40px !important;
      height: 40px !important;
      border-radius: 50%;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .swiper-button-next:after,
    .swiper-button-prev:after {
      font-size: 20px !important;
    }

    /* Genres Section */
    .genres-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.3) 0%, rgba(52, 73, 94, 0.3) 100%);
      border-radius: 12px;
      padding: 30px;
      margin-top: 50px;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .genres-grid {
      display: grid;
      grid-template-columns: repeat(5, 1fr);
      gap: 15px;
    }

    .genres-grid a {
      display: flex;
      align-items: center;
      color: var(--text-light);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      padding: 10px;
      border-radius: 8px;
      background-color: rgba(52, 73, 94, 0.4);
      border: 1px solid rgba(255, 255, 255, 0.05);
    }

    .genres-grid a:hover {
      background-color: rgba(52, 152, 219, 0.2);
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .genres-grid a span {
      color: var(--primary-color);
      margin-right: 8px;
      font-weight: bold;
    }

    /* Footer Styles */
    .footer-section {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      padding: 40px 0 20px;
      margin-top: 80px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      text-align: center;
    }

    .social-links {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin-bottom: 20px;
    }

    .social-links a {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background-color: rgba(52, 73, 94, 0.5);
      transition: all 0.3s;
    }

    .social-links a:hover {
      transform: translateY(-5px);
      background-color: var(--primary-color);
    }

    .social-links img {
      width: 25px;
      height: 25px;
      object-fit: contain;
    }

    .footer-section p {
      color: var(--text-muted);
      margin-top: 20px;
    }

    /* Animation for card loading */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .anime-card {
      animation: fadeInUp 0.5s ease-out forwards;
    }

    /* Responsive adjustments */
    @media (max-width: 991px) {
      .genres-grid {
        grid-template-columns: repeat(3, 1fr);
      }

      .page-header h2 {
        font-size: 30px;
      }
    }

    @media (max-width: 767px) {
      .topnav {
        padding: 10px 15px;
      }

      .logo {
        font-size: 24px;
      }

      .nav-links {
        gap: 10px;
      }

      .page-header h2 {
        font-size: 26px;
      }

      .genres-grid {
        grid-template-columns: repeat(2, 1fr);
      }

      .search-bar .form-control {
        padding: 12px 20px;
      }
    }
  </style>
</head>

<body>
  <#import "/fragments/auth-modals.ftlh" as auth>

  <!-- Top Navigation Bar -->
  <div class="topnav">
    <a href="/home" class="logo-link">
      <h1 class="logo">AniWatch</h1>
    </a>
    <div class="nav-links">
      <#if isAuthenticated?? && isAuthenticated>
        <div class="dropdown">
          <a href="#" class="dropbtn">
            <i class="fas fa-user"></i> ${username!}
          </a>
          <div class="dropdown-menu">
            <#if isProvider?? && isProvider>
              <a href="/provider-profile/${providerId!}">My Profile</a>
              <a href="/watchlists/new">Create Watchlist</a>
            <#else>
              <a href="/user-profile/${userId!}">My Profile</a>
            </#if>
            <a href="/logout">Logout</a>
          </div>
        </div>
      <#else>
        <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
      </#if>
      <a href="/watchlists/watchlist-list">Watchlist library</a>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <div class="page-header">
        <h2>Browse Anime</h2>
        <p>Discover anime to add to your watchlists</p>
      </div>

      <!-- Search Bar -->
      <div class="search-bar">
        <input type="text" id="searchInput" class="form-control" placeholder="Search anime by title, genre, or studio..." />
      </div>

      <!-- Anime Suggestions Section -->
      <div class="section-heading">
        <h2>Your Anime Suggestions</h2>
      </div>

      <div class="swiper mySwiper">
        <div class="swiper-wrapper">
          <#if animeList?has_content>
            <#list animeList as anime>
              <div class="swiper-slide">
                <div class="anime-card">
                  <img src="${anime.imageUrl}" alt="${anime.title}" />
                  <div class="card-body">
                    <h5 class="card-title">${anime.title}</h5>
                    <p class="card-text">Alternate Title: ${anime.alternateTitle}</p>
                  </div>
                </div>
              </div>
            </#list>
          <#else>
            <div class="col-12 text-center">
              <p>No anime available at the moment.</p>
            </div>
          </#if>
        </div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
      </div>

      <!-- Genres Section -->
      <div class="genres-section">
        <div class="section-heading">
          <h2>Explore by Genre</h2>
        </div>
        <div class="genres-grid">
          <a href="#"><span>></span>Action</a>
          <a href="#"><span>></span>Adventure</a>
          <a href="#"><span>></span>Avant Garde</a>
          <a href="#"><span>></span>Award Winning</a>
          <a href="#"><span>></span>Boys Love</a>
          <a href="#"><span>></span>Comedy</a>
          <a href="#"><span>></span>Drama</a>
          <a href="#"><span>></span>Fantasy</a>
          <a href="#"><span>></span>Girls Love</a>
          <a href="#"><span>></span>Gourmet</a>
          <a href="#"><span>></span>Horror</a>
          <a href="#"><span>></span>Mystery</a>
          <a href="#"><span>></span>Romance</a>
          <a href="#"><span>></span>Sci-Fi</a>
          <a href="#"><span>></span>Slice of Life</a>
          <a href="#"><span>></span>Sports</a>
          <a href="#"><span>></span>Supernatural</a>
          <a href="#"><span>></span>Suspense</a>
          <a href="#"><span>></span>Isekai</a>
          <a href="#"><span>></span>Place-holder</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer-section">
    <div class="container">
      <div class="social-links">
        <a href="https://discord.com/" target="_blank">
          <img src="/pics/discord-logo.png" alt="Discord" />
        </a>
        <a href="https://www.instagram.com/" target="_blank">
          <img src="/pics/instagram-logo.png" alt="Instagram" />
        </a>
        <a href="https://www.reddit.com/" target="_blank">
          <img src="/pics/reddit-logo.jpeg" alt="Reddit" />
        </a>
        <a href="https://twitter.com/" target="_blank">
          <img src="/pics/x-logo.jpeg" alt="Twitter" />
        </a>
      </div>
      <p>&copy; 2025 AniWatch</p>
    </div>
  </footer>

  <!-- Auth Modals -->
  <@auth.authModals/>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="/js/main.js"></script>
  <script src="/js/login-registration.js"></script>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Search functionality
      const searchInput = document.getElementById('searchInput');
      if (searchInput) {
        searchInput.addEventListener('input', function() {
          // Add search functionality here
          // This would typically filter anime cards based on search input
        });
      }
    });
  </script>
</body>
</html>