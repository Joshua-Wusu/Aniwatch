<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - Edit Watchlist</title>
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
      background-color: #222 !important;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
      z-index: 1;
      border-radius: 8px;
      margin-top: 4px !important;
      margin-right: -84px !important;
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
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 30px;
      margin-bottom: 30px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      position: relative;
    }

    .page-title {
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 5px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      display: inline-block;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      color: var(--text-light);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      background: rgba(26, 30, 37, 0.7);
      padding: 10px 15px;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      margin-top: 10px;
      margin-left: 630px;
    }

    .back-link:hover {
      background: rgba(52, 152, 219, 0.2);
      color: var(--primary-color);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .back-link i {
      margin-right: 8px;
    }

    /* Form Styles */
    .form-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 30px;
      margin-bottom: 30px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .form-label {
      font-weight: 500;
      color: var(--text-light);
      margin-bottom: 10px;
      font-size: 16px;
    }

    .form-control {
      background-color: rgba(26, 30, 37, 0.7);
      border: 1px solid rgba(255, 255, 255, 0.1);
      color: var(--text-light);
      border-radius: 8px;
      padding: 12px 15px;
      transition: all 0.3s;
    }

    .form-control:focus {
      background-color: rgba(26, 30, 37, 0.9);
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
      color: var(--text-light);
    }

    textarea.form-control {
      resize: vertical;
      min-height: 120px;
    }

    /* Thumbnail Section */
    .thumbnail-section {
      margin-bottom: 30px;
    }

    .thumbnail-container {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      justify-content: center;
      gap: 30px;
      margin: 20px 0;
    }

    .thumbnail-title {
      font-weight: 600;
      font-size: 18px;
      margin-bottom: 20px;
      color: var(--text-light);
    }

    .current-thumbnail,
    .new-thumbnail {
      flex: 1;
      min-width: 250px;
      background: rgba(26, 30, 37, 0.7);
      border-radius: 12px;
      padding: 20px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s;
    }

    .current-thumbnail:hover,
    .new-thumbnail:hover {
      transform: translateY(-5px);
    }

    .thumbnail-subtitle {
      font-size: 16px;
      font-weight: 500;
      margin-bottom: 15px;
      color: var(--text-light);
      text-align: center;
    }

    .thumbnail-wrapper {
      width: 100%;
      height: 280px;
      margin: 0 auto;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
      background-color: rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      position: relative;
    }

    .thumbnail-wrapper img {
      max-width: 100%;
      max-height: 100%;
      object-fit: cover;
      border-radius: 6px;
      transition: transform 0.5s;
    }

    .thumbnail-wrapper img:hover {
      transform: scale(1.05);
    }

    .placeholder-text {
      text-align: center;
      color: var(--text-muted);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100%;
    }

    .placeholder-text i {
      margin-bottom: 15px;
      opacity: 0.7;
    }

    .thumbnail-arrow {
      display: flex;
      align-items: center;
      color: var(--text-muted);
      animation: pulse 2s infinite;
    }

    @keyframes pulse {
      0% { opacity: 0.7; }
      50% { opacity: 1; }
      100% { opacity: 0.7; }
    }

    /* File Upload */
    .file-upload-container {
      margin-top: 25px;
      text-align: center;
    }

    .custom-file-upload {
      display: inline-block;
      padding: 12px 25px;
      background: linear-gradient(135deg, #3498db, #2980b9);
      color: white;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      border: none;
      transition: all 0.3s;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    .custom-file-upload:hover {
      background: linear-gradient(135deg, #2980b9, #2573a7);
      transform: translateY(-2px);
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
    }

    .custom-file-upload i {
      margin-right: 8px;
    }

    input[type="file"] {
      display: none;
    }

    #fileNameDisplay {
      display: block;
      margin-top: 10px;
      color: var(--text-muted);
      font-style: italic;
    }

    /* Action Buttons */
    .action-buttons {
      margin-top: 30px;
    }

    .btn {
      padding: 12px 25px;
      font-weight: 500;
      border-radius: 8px;
      transition: all 0.3s;
      position: relative;
      overflow: hidden;
    }

    .btn-primary {
      background: linear-gradient(135deg, #3498db, #2980b9);
      border: none;
      color: white;
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, #2980b9, #2573a7);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
    }

    .btn-secondary {
      background: rgba(44, 62, 80, 0.7);
      border: 1px solid rgba(255, 255, 255, 0.1);
      color: var(--text-light);
    }

    .btn-secondary:hover {
      background: rgba(52, 73, 94, 0.8);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .loading-icon {
      margin-left: 5px;
    }

    /* Loading Overlay */
    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(5px);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .loading-spinner {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      background: rgba(44, 62, 80, 0.7);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .loading-spinner i {
      color: var(--primary-color);
      margin-bottom: 15px;
    }

    .loading-spinner p {
      font-size: 18px;
      font-weight: 500;
      color: var(--text-light);
      margin: 0;
    }

    /* Footer */
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

    /* Responsive Adjustments */
    @media (max-width: 991px) {
      .page-title {
        font-size: 28px;
      }

      .thumbnail-container {
        flex-direction: column;
      }

      .thumbnail-arrow {
        transform: rotate(90deg);
        margin: 10px 0;
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

      .page-title {
        font-size: 24px;
      }

      .action-buttons {
        flex-direction: column;
        gap: 10px;
      }

      .btn {
        width: 100%;
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
      <#if isAuthenticated?? && isAuthenticated>
        <div class="dropdown">
          <a href="#" class="dropbtn">
            <i class="fas fa-user"></i> ${username!}
          </a>
          <div class="dropdown-menu">
            <#if isProvider?? && isProvider>
              <a href="/provider-profile/${providerId!}">My Profile</a>
            <#else>
              <a href="/user-profile/${userId!}">My Profile</a>
            </#if>
            <a href="/logout">Logout</a>
          </div>
        </div>
        <a href="/watchlists/watchlist-list">Watchlists library</a>
        <a href="/browse-anime">Browse Anime</a>
      <#else>
        <a href="/login">Login</a>
        <a href="/watchlists/watchlist-list">Watchlists library</a>
        <a href="/browse-anime">Browse Anime</a>
      </#if>
    </div>
  </div>

  <!-- Loading Overlay -->
  <div id="loadingOverlay" class="loading-overlay d-none">
    <div class="loading-spinner">
      <i class="fas fa-spinner fa-spin fa-3x"></i>
      <p>Updating watchlist...</p>
    </div>
  </div>

  <!-- Content -->
  <div class="content">
    <div class="container">
      <!-- Page Header -->
      <div class="page-header">
        <h1 class="page-title">Edit Watchlist</h1>
        <a href="/watchlists/${watchlist.watchlistId}" class="back-link">
          <i class="fas fa-arrow-left"></i> Back to Watchlist
        </a>
      </div>

      <!-- Form Section -->
      <div class="form-section">
        <form id="editWatchlistForm" action="/watchlists/update/${watchlist.watchlistId}" method="post" enctype="multipart/form-data">
          <div class="mb-4">
            <label for="title" class="form-label">Watchlist Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${watchlist.title}" required>
          </div>

          <div class="mb-4">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="4" required>${watchlist.description}</textarea>
          </div>

          <div class="thumbnail-section">
            <label class="form-label thumbnail-title">Watchlist Thumbnail</label>

            <div class="thumbnail-container">
              <div class="current-thumbnail">
                <h6 class="thumbnail-subtitle">Current Thumbnail</h6>
                <div class="thumbnail-wrapper">
                  <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Current Thumbnail" id="currentThumbnail">
                </div>
              </div>

              <div class="thumbnail-arrow d-none d-md-flex">
                <i class="fas fa-arrow-right fa-2x"></i>
              </div>

              <div class="new-thumbnail">
                <h6 class="thumbnail-subtitle">New Thumbnail</h6>
                <div class="thumbnail-wrapper" id="newThumbnailWrapper">
                  <img src="/pics/thumbnail-placeholder.jpg" alt="New Thumbnail Preview" id="thumbnailPreview" class="d-none">
                  <div class="placeholder-text" id="thumbnailPlaceholder">
                    <i class="fas fa-image fa-2x"></i>
                    <p>No new image selected</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="file-upload-container">
              <label class="custom-file-upload">
                <input type="file" id="thumbnailFile" name="thumbnailFile" accept="image/*" onchange="previewImage(this)">
                <i class="fas fa-upload"></i> Choose New Image
              </label>
              <span id="fileNameDisplay">No file chosen</span>
            </div>
          </div>

          <input type="hidden" name="providerId" value="${providerId}">
          <input type="hidden" name="providerUsername" value="${username}">

          <div class="action-buttons d-flex gap-3">
            <button type="submit" class="btn btn-primary" id="updateButton">
              <span class="button-text">Update Watchlist</span>
              <i class="fas fa-spinner fa-spin d-none loading-icon"></i>
            </button>
            <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
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

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Add animation to elements
      function animateElements() {
        const elements = document.querySelectorAll('.form-section, .page-header');

        elements.forEach(element => {
          element.style.opacity = '0';
          element.style.transform = 'translateY(20px)';
          element.style.transition = 'opacity 0.8s ease-out, transform 0.8s ease-out';

          setTimeout(() => {
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
          }, 100);
        });
      }

      // Run animations
      animateElements();

      // Loading overlay function
      function showLoading() {
        document.getElementById('loadingOverlay').classList.remove('d-none');
      }

      // Form submission with loading indicator
      const editForm = document.getElementById('editWatchlistForm');
      const updateButton = document.getElementById('updateButton');

      if (editForm) {
        editForm.addEventListener('submit', function(event) {
          // Show loading indicator
          updateButton.disabled = true;
          updateButton.querySelector('.button-text').classList.add('d-none');
          updateButton.querySelector('.loading-icon').classList.remove('d-none');
          showLoading();
        });
      }
    });

    // Image preview functionality
    function previewImage(input) {
      const preview = document.getElementById('thumbnailPreview');
      const placeholder = document.getElementById('thumbnailPlaceholder');
      const fileNameDisplay = document.getElementById('fileNameDisplay');

      if (input.files && input.files[0]) {
        const fileName = input.files[0].name;
        fileNameDisplay.textContent = fileName.length > 25 ? fileName.substring(0, 22) + '...' : fileName;

        const reader = new FileReader();
        reader.onload = function(e) {
          preview.src = e.target.result;
          preview.classList.remove('d-none');
          placeholder.classList.add('d-none');
        }
        reader.readAsDataURL(input.files[0]);
      } else {
        fileNameDisplay.textContent = 'No file chosen';
        preview.classList.add('d-none');
        placeholder.classList.remove('d-none');
      }
    }
  </script>
</body>
</html>