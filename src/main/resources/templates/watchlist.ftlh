<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
      display: flex;
      flex-direction: column;
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
      flex: 1;
    }

    /* Watchlist Header */
    .watchlist-header {
      background: linear-gradient(rgba(26, 30, 37, 0.8), rgba(44, 62, 80, 0.8)), url('/pics/hero-bg.jpg');
      background-size: cover;
      background-position: center;
      padding: 60px 0;
      margin-bottom: 40px;
      position: relative;
      border-radius: 15px;
      overflow: hidden;
    }

    .watchlist-header:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(52, 152, 219, 0.3) 0%, rgba(155, 89, 182, 0.3) 100%);
      z-index: 0;
    }

    .watchlist-header-content {
      position: relative;
      z-index: 1;
    }

    .watchlist-title {
      font-size: 36px;
      font-weight: 700;
      margin-bottom: 10px;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
    }

    /* Provider Section */
    .provider-section {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 20px;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .provider-icon {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      object-fit: cover;
      border: 3px solid var(--primary-color);
      margin-right: 20px;
    }

    .provider-info {
      flex: 1;
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

    .provider-stats {
      display: flex;
      align-items: center;
      margin-top: 10px;
    }

    .provider-stats > div {
      margin-right: 20px;
      display: flex;
      align-items: center;
    }

    .provider-stats i {
      margin-right: 5px;
      color: var(--primary-color);
    }

    .rating-display {
      display: flex;
      align-items: center;
    }

    .rating-stars {
      color: var(--warning);
      margin-right: 5px;
    }

    /* Subscribe Button */
    .subscribe-btn {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 10px 20px;
      border-radius: 30px;
      border: none;
      font-weight: 600;
      transition: all 0.3s ease;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      cursor: pointer;
    }

    .subscribe-btn.not-subscribed {
      background: linear-gradient(135deg, #3498db, #2980b9);
      color: white;
    }

    .subscribe-btn.subscribed {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      color: white;
    }

    .subscribe-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.3);
    }

    .subscribe-btn:active {
      transform: translateY(0);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .subscribe-btn .icon {
      font-size: 18px;
    }

    /* Description Section */
    .description-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 40px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .section-title {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .section-title:after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 0;
      width: 60px;
      height: 3px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
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

    .anime-card-img {
      width: 100%;
      height: 250px;
      object-fit: cover;
      transition: all 0.5s;
    }

    .anime-card:hover .anime-card-img {
      transform: scale(1.05);
    }

    .card-body {
      padding: 20px;
      background: rgba(26, 30, 37, 0.9);
    }

    .card-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 8px;
      color: var(--text-light);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .card-text {
      font-size: 14px;
      color: var(--text-muted);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    /* Comment Section */
    .comment-heading-container {
      align-items: center;
      margin-bottom: 35px;
      margin-top: 20px;
    }

    .comment-heading {
        margin-left: 30px;
        margin-top: -23px;
    }

    .comment-card {
        background-color: linear-gradient(135deg, #1a1e25 0%, #2c3e50 100%);
        color: white;
        transition: transform 0.3s;
        align-content: center;
        border-radius: 10px;
        margin-top: -10px;
        margin-bottom: -10px;
    }

    .comment-card-body {
        background-color: linear-gradient(135deg, #1a1e25 0%, #2c3e50 100%);
        overflow: hidden; /* Hide any overflow content */
        word-break: break-all; /* Optional: Break very long words if needed */
    }

    .comment-card-body p {
        /* Ensure text wraps within the container */
        white-space: pre-wrap; /* Preserve new lines and wrap text */
        word-wrap: break-word; /* Break long words to fit within the container */
        overflow-wrap: break-word; /* Modern equivalent of word-wrap */
        margin-top: 8px;
    }


    .comment-header {
        display: flex;
        align-items: center;
    }

    .rounded-circle {
        margin-top: 5px;
        height: 50px;
        width: 50px;
        border: 1.5px solid #007bff;
    }

    .comment-author {
        margin-right: 1rem;
        font-weight: bold;
    }

    .comment-time {
        font-size: 0.8rem;
        color: #777;
        margin-bottom: 2px;
    }

    .comment-date {
        font-size: 0.8rem;
        color: #777;
        margin-right: 5px;
        margin-bottom: 2px;
    }

    .comment-text {
        margin-top: 10px;
    }

    .current-user-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--primary-color);
    }

    .comment-input-wrapper {
        display: flex;
    }

    #commentBox {
        resize: none; /* Prevent manual resizing */
        overflow-y: auto; /* Allow scrolling internally without showing scrollbar */
        white-space: pre-wrap; /* Preserve new lines and wrap text */
        word-wrap: break-word; /* Ensure long words wrap */
        height: 90px;
    }

    #commentBox::-webkit-scrollbar {
        width: 8px; /* Width of the scrollbar */
    }

    #commentBox::-webkit-scrollbar-track {
        background: #2c2f33; /* Track background */
        border-radius: 5px;
    }

    #commentBox::-webkit-scrollbar-thumb {
        background: #7289da; /* Thumb (the moving part) */
        border-radius: 5px;
        cursor: pointer;
    }

        #commentBox::-webkit-scrollbar-thumb:hover {
            background: #5b6eae; /* Darker shade on hover */
        }


    .emoji-button {
        position: absolute;
        background-color: transparent; /* Remove the background color */
        border: none; /* Completely remove the border */
        margin-left: 677px; /* Keep the positioning */
        margin-top: 7px; /* Keep the positioning */
        font-size: 20px; /* Keep the emoji size */
        padding: 0; /* Remove any padding that might create a "box" effect */
        transition: none; /* Remove the background transition since there's no background */
        cursor: pointer; /* Add a pointer cursor to indicate it's clickable */
    }

    .emoji-button:hover {
      transform: scale(1.2);
    }

    .reply-emoji-button {
        position: absolute;
        background-color: transparent;
        border: none;
        top: 50%; /* Center vertically */
        transform: translateY(-50%); /* Adjust for vertical centering */
        font-size: 20px;
        padding: 0;
        margin-left: 677px; /* Keep the positioning */
        margin-top: -17px; /* Keep the positioning */
        transition: none;
        cursor: pointer;
    }
        .reply-emoji-button:hover {
                opacity: 0.8;
                transform: translateY(-50%) scale(1.2); /* Keep vertical centering on hover */
            }

    .toggle-replies {
        display: none; /* Hidden by default, shown via JS if there are replies */
        font-size: 1em;
        color: #007bff;
    }

    .reply .toggle-replies {
        display: none!important; /* Hidden by default, shown via JS if there are replies */

    }

    .reply .reply-box {
        max-width: 648px;
        width: 648px;
    }

    .reply .reply-emoji-button {
        margin-left: 605px;
        margin-top: -25px;
    }


    .reply-box {
        height: 90px;
        resize: none;
    }

        .reply-box::-webkit-scrollbar {
            width: 8px; /* Width of the scrollbar */
        }

        .reply-box::-webkit-scrollbar-track {
            background: #2c2f33; /* Track background */
            border-radius: 5px;
        }

        .reply-box::-webkit-scrollbar-thumb {
            background: #7289da; /* Thumb (the moving part) */
            border-radius: 5px;
            cursor: pointer;
        }

            .reply-box::-webkit-scrollbar-thumb:hover {
                background: #5b6eae; /* Darker shade on hover */
            }

    .reply .comment-date,
    .reply .comment-time,
    .nested-reply .comment-date,
    .nested-reply .comment-time {
        font-size: 0.8rem; /* Smaller font for the time */
        color: #777; /* Gray color for the time */
        margin-right: 5px;
        margin-bottom: 5px;
    }

    .reply .comment-card-body p,
    .nested-reply .comment-card-body p {
    }

    .reply .reply-btn {
        position: absolute;
        transform: translateX(42%); /* Adjust for vertical centering */
        display: flex;
        align-items: center;
        text-decoration: none;
        margin-left: 556px;
    }

    .reply-btn {
        position: absolute;
        margin-left: 649px;
    }


    .view-more-comments {
        font-size: 1em;
        color: #007bff;
        margin-top: 10px;
        margin-bottom: 20px;
        display: block;
        text-align: center;
        text-decoration: none
    }

        .view-more-comments:hover {
            text-decoration: none;
        }

    /* Hidden Main Comments */
    #commentSection .d-flex.flex-start.mb-4.hidden {
        display: none !important;
    }

    /* Hidden Main Comments */
    .d-flex.flex-start.mb-4.hidden {
        display: none;
    }

    /* Footer */
    .footer-section {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      padding: 40px 0 20px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      text-align: center;
      margin-top: auto;
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

    .link-muted {
      text-decoration: none;
    }

    .dislike-count {
      text-decoration: none;
    }

    .like-count {
      text-decoration: none;
    }

    /* Responsive Adjustments */
    @media (max-width: 991px) {
      .watchlist-title {
        font-size: 28px;
      }

      .section-title {
        font-size: 20px;
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

      .provider-section {
        flex-direction: column;
        align-items: center;
        text-align: center;
      }

      .provider-icon {
        margin-right: 0;
        margin-bottom: 15px;
      }

      .provider-stats {
        justify-content: center;
        flex-wrap: wrap;
      }

      .provider-stats > div {
        margin: 5px 10px;
      }

      .watchlist-header {
        padding: 40px 0;
      }

      .watchlist-title {
        font-size: 24px;
      }

      .social-links a {
        width: 40px;
        height: 40px;
      }

      .social-links img {
        width: 20px;
        height: 20px;
      }
    }
  </style>
</head>

<body>

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

        <#import "/fragments/auth-modals.ftlh" as auth>
                              <@auth.authModals/>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <!-- Watchlist Header -->
      <div class="watchlist-header">
        <div class="watchlist-header-content text-center">
          <h1 class="watchlist-title">${title}</h1>
        </div>
      </div>

      <!-- Provider Section -->
      <div class="provider-section">
        <a href="/provider-profile/${providerId!}">
          <img src="${avatar!'/pics/default-profile.jpg'}" alt="Provider Icon" class="provider-icon">
        </a>
        <div class="provider-info">
          <p>Created by: <a href="/provider-profile/${providerId!}">${providerUsername!''}</a></p>
          <div class="provider-stats">
            <div class="rating-display">
              <span class="five-star-rating rating-stars" id="rateButton">${ratingStars}</span>
              <span>(${rating}/5)</span>
              <#import "/fragments/watchlist-rating-modal.ftlh" as rating>
              <@rating.watchlistRatingModal/>
            </div>
            <div class="views-stat">
              <i class="fas fa-eye"></i>
              <span>${views!'0'} views</span>
            </div>
          </div>
        </div>

        <#if isAuthenticated?? && isAuthenticated>
          <div class="subscribe-container ms-auto">
            <button id="subscribeButton"
                   class="subscribe-btn <#if isSubscribed?? && isSubscribed>subscribed<#else>not-subscribed</#if>"
                   data-watchlist-id="${watchlistId}">
              <span class="icon">
                <i class="fas <#if isSubscribed?? && isSubscribed>fa-check-circle<#else>fa-bookmark</#if>"></i>
              </span>
              <span class="text">
                <#if isSubscribed?? && isSubscribed>Subscribed<#else>Subscribe</#if>
              </span>
            </button>
          </div>
        </#if>
      </div>

      <!-- Description Section -->
      <div class="description-section">
        <h2 class="section-title">Description</h2>
        <p>${description}</p>
      </div>

      <!-- Anime Cards -->
      <h2 class="section-title mb-4">Anime in this Watchlist</h2>
      <div class="row">
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Berserk.jpg" class="anime-card-img" alt="Berserk">
            <div class="card-body">
              <h5 class="card-title">Berserk</h5>
              <p class="card-text">A dark fantasy epic of vengeance and fate.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Code-geass.jpg" class="anime-card-img" alt="Code Geass">
            <div class="card-body">
              <h5 class="card-title">Code Geass</h5>
              <p class="card-text">A strategic rebellion against an empire.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Vinland-saga.jpg" class="anime-card-img" alt="Vinland Saga">
            <div class="card-body">
              <h5 class="card-title">Vinland Saga</h5>
              <p class="card-text">A Viking tale of revenge and redemption.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Parasyte-the-maxim.jpg" class="anime-card-img" alt="Parasyte: The Maxim">
            <div class="card-body">
              <h5 class="card-title">Parasyte: The Maxim</h5>
              <p class="card-text">A human-alien symbiosis thriller.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Bunguo-stray-dogs.jpg" class="anime-card-img" alt="Bunguo Stray Dogs">
            <div class="card-body">
              <h5 class="card-title">Bunguo Stray Dogs</h5>
              <p class="card-text">Supernatural detectives inspired by literature.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Detective-conan.jpg" class="anime-card-img" alt="Detective Conan">
            <div class="card-body">
              <h5 class="card-title">Detective Conan</h5>
              <p class="card-text">A young detective solving endless mysteries.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Tokyo-ravens.jpg" class="anime-card-img" alt="Tokyo Ravens">
            <div class="card-body">
              <h5 class="card-title">Tokyo Ravens</h5>
              <p class="card-text">Magic and spirits in modern Tokyo.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Baki.jpg" class="anime-card-img" alt="Baki">
            <div class="card-body">
              <h5 class="card-title">Baki</h5>
              <p class="card-text">Brutal martial arts battles.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4">
          <div class="anime-card">
            <img src="/pics/Trigun.jpg" class="anime-card-img" alt="Trigun">
            <div class="card-body">
              <h5 class="card-title">Trigun</h5>
              <p class="card-text">A gunslinger's journey in a desert world.</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Comment Section -->


      <script>
          const watchlistId = ${watchlistId?c}; // Use ?c to ensure numeric output
      </script>

      <div class="container text-body">
          <div class="row d-flex justify-content-center">
              <div class="col-md-12 col-lg-10 col-xl-9">
                  <!-- Comment Input Section -->
                  <#if isAuthenticated?? && isAuthenticated>
                      <div class="d-flex flex-start">
                          <img class="rounded-circle shadow-1-strong current-user-avatar" src="${currentUserAvatar}" alt="avatar" width="65" height="65" />
                          <div class="comment-card w-100">
                              <div class="comment-card-body p-4">
                                  <div class="comment-header">
                                      <h5 class="comment-author">${currentUser}</h5>
                                  </div>
                                  <div class="comment-input-wrapper">
                                      <textarea id="commentBox" class="form-control border-0 bg-secondary" rows="3" placeholder="Leave a comment..." maxlength="1000"></textarea>
                                      <button id="emojiPicker" class="emoji-button">😊</button>
                                  </div>
                                  <div class="d-flex justify-content-end mt-2">
                                      <button class="btn btn-primary btn-sm" onclick="postComment()">Comment</button>
                                  </div>
                              </div>
                          </div>
                      </div>
                  <#else>
                      <div class="alert alert-info text-center mb-5">
                          <span>Please <a href="/login" class="alert-link">log in</a> to leave a comment.</span>
                      </div>
                  </#if>

                  <!-- Comments Section - visible to everyone -->
                  <div id="commentSection">
                      <!-- Comments will be loaded here by JavaScript -->
                  </div>
              </div>
          </div>
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

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/login-registration.js"></script>
  <script src="/js/comment.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/emoji-mart@latest/dist/browser.js"></script>

  <script>
    // Subscribe/Unsubscribe Functionality
    document.addEventListener('DOMContentLoaded', function() {
      const subscribeButton = document.getElementById('subscribeButton');
      if (subscribeButton) {
        subscribeButton.addEventListener('click', function() {
          const watchlistId = this.getAttribute('data-watchlist-id');
          const isSubscribed = this.classList.contains('subscribed');
          const endpoint = isSubscribed ?
            `/api/subscriptions/unsubscribe/${watchlistId}` :
            `/api/subscriptions/subscribe/${watchlistId}`;

          fetch(endpoint, {
            method: 'POST'
          })
          .then(response => {
            if (response.ok) {
              if (isSubscribed) {
                // Unsubscribe action
                this.classList.remove('subscribed');
                this.classList.add('not-subscribed');
                this.querySelector('.text').textContent = 'Subscribe';
                this.querySelector('.icon i').classList.remove('fa-check-circle');
                this.querySelector('.icon i').classList.add('fa-bookmark');
              } else {
                // Subscribe action
                this.classList.remove('not-subscribed');
                this.classList.add('subscribed');
                this.querySelector('.text').textContent = 'Subscribed';
                this.querySelector('.icon i').classList.remove('fa-bookmark');
                this.querySelector('.icon i').classList.add('fa-check-circle');
              }
            }
          })
          .catch(error => {
            console.error('Error updating subscription:', error);
            alert('Failed to update subscription. Please try again.');
          });
        });
      }
    });

    // Comment Section Animation
    document.addEventListener('DOMContentLoaded', function() {
      const animateOnScroll = function() {
        const elements = document.querySelectorAll('.comment-card, .anime-card');

        elements.forEach(element => {
          const elementPosition = element.getBoundingClientRect().top;
          const screenPosition = window.innerHeight / 1.2;

          if (elementPosition < screenPosition) {
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
          }
        });
      };

      // Set initial styles for animation
      document.querySelectorAll('.comment-card, .anime-card').forEach(element => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(20px)';
        element.style.transition = 'all 0.6s ease-out';
      });

      // Run once on load
      setTimeout(animateOnScroll, 300);

      // Add scroll event listener
      window.addEventListener('scroll', animateOnScroll);
    });
  </script>
</body>
</html>