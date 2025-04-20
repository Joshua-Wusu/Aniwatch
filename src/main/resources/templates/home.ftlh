<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

    /* Hero Section */
    .hero-section {
      background: linear-gradient(rgba(26, 30, 37, 0.8), rgba(44, 62, 80, 0.8)), url('/pics/hero-bg.jpg');
      background-size: cover;
      background-position: center;
      padding: 120px 0;
      margin-bottom: 60px;
      position: relative;
      border-radius: 15px;
      overflow: hidden;
    }

    .hero-section:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(52, 152, 219, 0.3) 0%, rgba(155, 89, 182, 0.3) 100%);
      z-index: 0;
    }

    .hero-content {
      position: relative;
      z-index: 1;
      max-width: 800px;
      margin: 0 auto;
    }

    .hero-section h1 {
      font-size: 48px;
      font-weight: 700;
      margin-bottom: 20px;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
    }

    .hero-section p {
      font-size: 18px;
      opacity: 0.9;
      margin-bottom: 30px;
    }

    /* Section Heading */
    .section-heading {
      text-align: center;
      margin-bottom: 40px;
      position: relative;
    }

    .section-heading h2 {
      font-weight: 700;
      font-size: 32px;
      margin-bottom: 10px;
      position: relative;
      display: inline-block;
    }

    .section-heading h2:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 3px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
    }

    /* Cards */
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

    /* Watchlist Card */
    .watchlist-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.3s ease;
      height: 100%;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      margin-bottom: 20px;
    }

    .watchlist-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .watchlist-thumbnail {
      width: 100%;
      height: 180px;
      object-fit: cover;
      transition: all 0.5s;
    }

    .watchlist-card:hover .watchlist-thumbnail {
      transform: scale(1.05);
    }

    .watchlist-card-body {
      padding: 20px;
      background: rgba(26, 30, 37, 0.9);
    }

    .provider-info {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }

    .provider-info a {
          color: var(--text-light);
          text-decoration: none;
          font-weight: 600;
          transition: all 0.3s;
        }

        .provider-info a:hover {
          color: var(--primary-color);
        }

    .watchlist-card-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 10px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      color: var(--text-light);
      padding: 5px 10px;
      background: rgba(52, 73, 94, 0.5);
      border-radius: 5px;
      text-align: center;
    }

    .profile-image {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--primary-color);
      margin-right: 10px;
    }

    .watchlist-card-text {
      font-size: 14px;
      color: var(--text-muted);
    }

    .watchlist-metadata {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
      padding: 8px 0;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .views-counter {
      font-size: 14px;
      color: var(--text-muted);
      display: flex;
      align-items: center;
    }

    .views-counter i {
      margin-right: 5px;
      color: var(--primary-color);
    }

    .rating-container {
      display: flex;
      align-items: center;
    }

    .rating-container .text-warning {
      color: var(--warning) !important;
      margin-right: 5px;
    }

    .btn-group {
      display: flex;
      gap: 10px;
    }

    .btn {
      padding: 8px 16px;
      font-weight: 500;
      border-radius: 6px;
      transition: all 0.3s;
    }

    .btn-outline-light {
      border: 1px solid rgba(255, 255, 255, 0.5);
      color: var(--text-light);
    }

    .btn-outline-light:hover {
      background-color: rgba(255, 255, 255, 0.1);
      border-color: var(--text-light);
    }

    .btn-primary {
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
      border: none;
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, #2980b9 0%, #2573a7 100%);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
    }

    .btn-danger {
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      border: none;
    }

    .btn-danger:hover {
      background: linear-gradient(135deg, #c0392b 0%, #a93226 100%);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
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

    /* Welcome Section */
    .welcome-section {
      text-align: center;
      padding: 60px 0;
      background: linear-gradient(rgba(26, 30, 37, 0.7), rgba(44, 62, 80, 0.7)), url('/pics/pattern-bg.jpg');
      background-size: cover;
      background-position: center;
      border-radius: 15px;
      margin: 60px 0;
      position: relative;
    }

    .welcome-section:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(52, 152, 219, 0.2) 0%, rgba(155, 89, 182, 0.2) 100%);
      border-radius: 15px;
    }

    .welcome-content {
      position: relative;
      z-index: 1;
    }

    .welcome-section h2 {
      font-size: 36px;
      font-weight: 700;
      margin-bottom: 15px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      display: inline-block;
    }

    .welcome-section p {
      font-size: 18px;
      max-width: 600px;
      margin: 0 auto;
      color: var(--text-light);
    }

    /* Responsive Adjustments */
    @media (max-width: 991px) {
      .hero-section h1 {
        font-size: 36px;
      }

      .welcome-section h2 {
        font-size: 28px;
      }

      .section-heading h2 {
        font-size: 26px;
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
        gap: 15px;
      }

      .hero-section {
        padding: 80px 0;
      }

      .hero-section h1 {
        font-size: 30px;
      }

      .hero-section p {
        font-size: 16px;
      }

      .section-heading h2 {
        font-size: 24px;
      }

      .welcome-section h2 {
        font-size: 24px;
      }

      .welcome-section p {
        font-size: 16px;
      }

      .social-links a {
        width: 40px;
        height: 40px;
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
                  <a href="/watchlists/watchlist-list">Watchlists library</a>
                  <a href="/browse-anime">Browse Anime</a>
              <#else>
                  <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                  <a href="/watchlists/watchlist-list">Watchlists library</a>
                  <a href="/browse-anime">Browse Anime</a>
              </#if>
          </div>
      </div>

  <!-- Main Content -->
  <div class="content">
    <!-- Hero Section -->
    <div class="container">
      <div class="hero-section">
        <div class="hero-content text-center">
          <h1>Discover and track your favorite anime and manga!</h1>
          <p>Join our community of anime enthusiasts to create, share and discover the best watchlists.</p>
        </div>
      </div>
    </div>

    <!-- Anime Data Section -->
    <div class="container">
      <div class="section-heading">
        <h2>Popular ${currentSeason} Anime</h2>
        <p>Trending series this season that everyone's watching</p>
      </div>

      <div class="swiper mySwiper">
        <div class="swiper-wrapper">
          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/Solo-Leveling.jpg" alt="Solo Leveling">
              </div>
              <div class="card-body">
                <h5 class="card-title">Solo Leveling</h5>
                <p class="card-text">Alternate Title: Ore dake Level Up na Ken</p>
              </div>
            </div>
          </div>

          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/The-Apothecary-Diaries.jpg" alt="The Apothecary Diaries">
              </div>
              <div class="card-body">
                <h5 class="card-title">The Apothecary Diaries</h5>
                <p class="card-text">Alternate Title: Kusuriya no Hitorigoto</p>
              </div>
            </div>
          </div>

          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/One-Piece.jpg" alt="One Piece">
              </div>
              <div class="card-body">
                <h5 class="card-title">One Piece</h5>
                <p class="card-text">Alternate Title: One Piece</p>
              </div>
            </div>
          </div>

          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/ReZero.jpg" alt="Re:Zero">
              </div>
              <div class="card-body">
                <h5 class="card-title">Re:ZERO - Starting Life in Another World</h5>
                <p class="card-text">Alternate Title: Re:Zero kara Hajimeru Isekai Seikatsu</p>
              </div>
            </div>
          </div>

          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/Orb.jpg" alt="Orb: On the Movements of the Earth">
              </div>
              <div class="card-body">
                <h5 class="card-title">Orb: On the Movements of the Earth</h5>
                <p class="card-text">Alternate Title: Chi. Chikyuu no Undou ni Tsuite</p>
              </div>
            </div>
          </div>

          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/Shangri-La-Frontier.jpg" alt="Shangri-La Frontier">
              </div>
              <div class="card-body">
                <h5 class="card-title">Shangri-La Frontier</h5>
                <p class="card-text">Alternate Title: Shangri-La Frontier: Kusoge Hunter, Kamige ni Idoman to su</p>
              </div>
            </div>
          </div>

          <div class="swiper-slide">
            <div class="anime-card">
              <div class="card-img-container">
                <img src="/pics/Dr.Stone.jpg" alt="Dr. Stone">
              </div>
              <div class="card-body">
                <h5 class="card-title">Dr. Stone</h5>
                <p class="card-text">Alternate Title: Dr. Stone: Science Future</p>
              </div>
            </div>
          </div>
        </div>

        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
      </div>
    </div>

    <!-- Welcome Section -->
    <div class="container">
      <div class="welcome-section">
        <div class="welcome-content">
          <h2>Welcome to AniWatch</h2>
          <p>Find the Anime Watchlist that fits exactly what you're looking for!</p>
        </div>
      </div>
    </div>

    <!-- Featured Watchlists Section -->
    <div class="container">
      <div class="section-heading">
        <h2>Featured Watchlists</h2>
        <p>Curated collections from our top providers</p>
      </div>

      <div class="swiper mySwiper2">
        <div class="swiper-wrapper">
          <#if featuredWatchlists?has_content>
            <#list featuredWatchlists as watchlist>
              <div class="swiper-slide watchlist-item">
                <div class="watchlist-card">
                  <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="${watchlist.title}" class="watchlist-thumbnail" onerror="this.src='/pics/default-watchlist.jpg';">
                  <div class="watchlist-card-body">
                    <h5 class="watchlist-card-title">${watchlist.title}</h5>
                    <div class="provider-info">
                      <img src="${watchlist.avatar!'/pics/default-profile.jpg'}" alt="Provider" class="profile-image">
                      <span class="watchlist-card-text">By: <a href="/provider-profile/${providerId!}" class="text-light">${watchlist.providerUsername}</a></span>
                    </div>
                    <div class="watchlist-metadata">
                      <div class="views-counter">
                        <i class="fas fa-eye"></i> ${watchlist.views!'0'} views
                      </div>
                      <div class="rating-container">
                        <span class="text-warning">
                          <#assign stars = (watchlist.rating?has_content && watchlist.rating gt 0)?then(watchlist.rating?round, 0)>
                          <#list 1..5 as i>
                            <#if i <= stars>★<#else>☆</#if>
                          </#list>
                        </span>
                        (${(watchlist.rating?has_content)?then(watchlist.rating?string("0.0"), "0.0")}/5)
                      </div>
                    </div>
                    <#if isAuthenticated?? && isAuthenticated>
                                            <div class="btn-group">
                                              <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View list</a>
                                              <button class="btn btn-primary" data-watchlist-id="${watchlist.watchlistId}">Subscribe</button>
                                            </div>
                                          <#else>
                                            <div class="btn-group">
                                              <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View list</a>
                                            </div>
                                          </#if>
                  </div>
                </div>
              </div>
            </#list>
          <#else>
            <div class="col-12 text-center">
              <p class="text-muted">No watchlists available yet.</p>
            </div>
          </#if>
        </div>

        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer-section">
    <div class="container">
      <div class="social-links">
        <a href="https://discord.com/" target="_blank">
          <img src="/pics/discord-logo.png" alt="Discord">
        </a>
        <a href="https://www.instagram.com/" target="_blank">
          <img src="/pics/instagram-logo.png" alt="Instagram">
        </a>
        <a href="https://www.reddit.com/" target="_blank">
          <img src="/pics/reddit-logo.jpeg" alt="Reddit">
        </a>
        <a href="https://twitter.com/" target="_blank">
          <img src="/pics/x-logo.jpeg" alt="Twitter">
        </a>
      </div>
      <p>&copy; 2025 AniWatch</p>
    </div>
  </footer>

  <@auth.authModals/>

  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="/js/main.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/login-registration.js"></script>

  <script>
    <#noparse>
              // Subscription handling
            document.addEventListener('DOMContentLoaded', function() {
              const subscribeButtons = document.querySelectorAll('.btn-primary');

              subscribeButtons.forEach(button => {
                if (button.textContent === 'Subscribe') {
                  const watchlistId = button.getAttribute('data-watchlist-id');

                  // Check if already subscribed
                  fetch("/api/subscriptions/check/" + watchlistId)
                    .then(response => response.json())
                    .then(isSubscribed => {
                      if (isSubscribed) {
                        button.textContent = 'Unsubscribe';
                        button.classList.remove('btn-primary');
                        button.classList.add('btn-danger');
                      }
                    })
                    .catch(error => {
                      console.error('Error checking subscription status:', error);
                    });

                  // Add click handler
                  button.addEventListener('click', function() {
                    const isSubscribing = button.textContent === 'Subscribe';
                    const endpoint = isSubscribing ?
                      "/api/subscriptions/subscribe/" + watchlistId :
                      "/api/subscriptions/unsubscribe/" + watchlistId;

                    fetch(endpoint, {
                      method: 'POST'
                    })
                    .then(response => {
                      if (response.ok) {
                        if (isSubscribing) {
                          button.textContent = 'Unsubscribe';
                          button.classList.remove('btn-primary');
                          button.classList.add('btn-danger');
                        } else {
                          button.textContent = 'Subscribe';
                          button.classList.remove('btn-danger');
                          button.classList.add('btn-primary');
                        }
                      }
                    })
                    .catch(error => {
                      console.error('Error updating subscription:', error);
                    });
                  });
                }
              });

              // Handle unsubscribe buttons on profile page
              const unsubscribeButtons = document.querySelectorAll('.unsubscribe-btn');
              unsubscribeButtons.forEach(button => {
                button.addEventListener('click', function() {
                  const watchlistId = button.dataset.watchlistId;

                  fetch("/api/subscriptions/unsubscribe/" + watchlistId, {
                    method: 'POST'
                  })
                  .then(response => {
                    if (response.ok) {
                      // Remove the watchlist card from the display
                      button.closest('.watchlist-item').remove();

                      // Update the subscription count
                      const counterElement = document.querySelector('.stats-list .green + span');
                      if (counterElement) {
                        let count = parseInt(counterElement.textContent);
                        counterElement.textContent = (count - 1).toString();
                      }
                    }
                  });
                });
              });

              // Add some animations
              const animateOnScroll = function() {
                const elements = document.querySelectorAll('.section-heading, .hero-content, .welcome-content');

                elements.forEach(element => {
                  const elementPosition = element.getBoundingClientRect().top;
                  const screenPosition = window.innerHeight / 1.3;

                  if (elementPosition < screenPosition) {
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                  }
                });
              };

              // Set initial styles for animation
              document.querySelectorAll('.section-heading, .hero-content, .welcome-content').forEach(element => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                element.style.transition = 'all 0.8s ease-out';
              });

              // Run once on load
              animateOnScroll();

              // Add scroll event listener
              window.addEventListener('scroll', animateOnScroll);
            });
            </#noparse>
          </script>
        </body>
        </html>