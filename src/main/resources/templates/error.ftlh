<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - Error</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

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

    /* Content Styles */
    .content {
      padding-top: 80px;
      padding-bottom: 50px;
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .error-container {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 15px;
      padding: 60px 40px;
      text-align: center;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.1);
      max-width: 650px;
      width: 100%;
      position: relative;
      overflow: hidden;
      margin-left: 235px;
    }

    .error-container:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 5px;
      background: linear-gradient(90deg, #e74c3c, #9b59b6);
    }

    .error-icon {
      position: relative;
      margin-bottom: 30px;
    }

    .error-icon i {
      font-size: 80px;
      color: var(--danger);
      animation: pulse 2s infinite;
    }

    @keyframes pulse {
      0% {
        transform: scale(1);
        opacity: 1;
      }
      50% {
        transform: scale(1.1);
        opacity: 0.8;
      }
      100% {
        transform: scale(1);
        opacity: 1;
      }
    }

    @keyframes float {
      0% {
        transform: translateY(0px);
      }
      50% {
        transform: translateY(-10px);
      }
      100% {
        transform: translateY(0px);
      }
    }

    .error-title {
      font-size: 36px;
      font-weight: 700;
      margin-bottom: 20px;
      background: linear-gradient(90deg, #e74c3c, #f39c12);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .error-message {
      font-size: 18px;
      margin-bottom: 40px;
      color: var(--text-light);
      max-width: 500px;
      margin-left: auto;
      margin-right: auto;
    }

    .error-code {
      position: absolute;
      top: 20px;
      right: 30px;
      font-family: 'Poppins', monospace;
      font-size: 18px;
      color: var(--text-muted);
      opacity: 0.7;
    }

    .error-details {
      margin-bottom: 40px;
      padding: 20px;
      background-color: rgba(26, 30, 37, 0.6);
      border-radius: 8px;
      text-align: left;
      max-height: 150px;
      overflow-y: auto;
      font-family: monospace;
      font-size: 14px;
      color: var(--text-muted);
      border: 1px solid rgba(255, 255, 255, 0.05);
      display: none;
    }

    .error-details.show {
      display: block;
    }

    .toggle-details {
      color: var(--primary-color);
      margin-bottom: 30px;
      cursor: pointer;
      display: inline-block;
      font-size: 14px;
      transition: all 0.3s;
    }

    .toggle-details:hover {
      color: var(--primary-dark);
      text-decoration: underline;
    }

    .decoration {
      position: absolute;
      background: linear-gradient(135deg, rgba(52, 152, 219, 0.3), rgba(155, 89, 182, 0.3));
      border-radius: 50%;
      z-index: -1;
    }

    .decoration-1 {
      width: 150px;
      height: 150px;
      top: -50px;
      left: -50px;
    }

    .decoration-2 {
      width: 100px;
      height: 100px;
      bottom: -30px;
      right: -30px;
    }

    .home-button {
      background: linear-gradient(135deg, #3498db, #2980b9);
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 30px;
      font-weight: 600;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.3s;
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
      display: inline-block;
      text-decoration: none;
    }

    .home-button:hover {
      background: linear-gradient(135deg, #2980b9, #3498db);
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(52, 152, 219, 0.4);
      color: white;
    }

    .home-button i {
      margin-right: 10px;
    }

    /* Footer Styles */
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

    @media (max-width: 768px) {
      .error-container {
        margin: 20px;
        padding: 40px 20px;
      }

      .error-title {
        font-size: 28px;
      }

      .error-icon i {
        font-size: 60px;
      }

      .error-message {
        font-size: 16px;
      }
    }
  </style>
</head>

<body>
  <!-- Top Navigation Bar -->
  <div class="topnav">
    <a href="/home" class="logo-link">
      <h1 class="logo">AniWatch</h1>
    </a>
    <div class="nav-links">
      <a href="/watchlists/watchlist-list">Watchlists library</a>
      <a href="/browse-anime">Browse Anime</a>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <div class="error-container">
        <div class="decoration decoration-1"></div>
        <div class="decoration decoration-2"></div>

        <div class="error-code">Error</div>

        <div class="error-icon">
          <i class="fas fa-exclamation-circle"></i>
        </div>

        <h1 class="error-title">Oops! Something went wrong</h1>

        <p class="error-message">${error!'An unexpected error occurred. Please try again later.'}</p>

        <#if stackTrace??>
          <div class="toggle-details" onclick="toggleDetails()">
            <i class="fas fa-chevron-down"></i> Show technical details
          </div>

          <div class="error-details" id="errorDetails">
            ${stackTrace}
          </div>
        </#if>

        <a href="/home" class="home-button">
          <i class="fas fa-home"></i> Return to Homepage
        </a>
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
  <script>
    function toggleDetails() {
      const details = document.getElementById('errorDetails');
      const toggle = document.querySelector('.toggle-details');

      if (details.classList.contains('show')) {
        details.classList.remove('show');
        toggle.innerHTML = '<i class="fas fa-chevron-down"></i> Show technical details';
      } else {
        details.classList.add('show');
        toggle.innerHTML = '<i class="fas fa-chevron-up"></i> Hide technical details';
      }
    }

    // Add subtle animation to error icon
    document.addEventListener('DOMContentLoaded', function() {
      const errorIcon = document.querySelector('.error-icon');
      errorIcon.style.animation = 'float 3s ease-in-out infinite';
    });
  </script>
</body>
</html>