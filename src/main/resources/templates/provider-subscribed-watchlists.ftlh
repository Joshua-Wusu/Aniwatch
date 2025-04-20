<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - Subscribed Watchlists</title>
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
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 25px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .page-title {
      font-size: 28px;
      font-weight: 700;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      margin: 0;
    }

    .back-link {
      display: flex;
      align-items: center;
      color: var(--text-light);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      background: rgba(26, 30, 37, 0.7);
      padding: 10px 15px;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .back-link:hover {
      background: rgba(52, 152, 219, 0.2);
      color: var(--primary-color);
      transform: translateY(-2px);
    }

    .back-link i {
      margin-right: 8px;
    }

    /* Search and Filter Section */
    .search-filter-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 30px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .form-control, .form-select {
      background-color: rgba(26, 30, 37, 0.7);
      border: 1px solid rgba(255, 255, 255, 0.1);
      color: var(--text-light);
      border-radius: 8px;
      padding: 12px 15px;
      transition: all 0.3s;
    }

    .form-control:focus, .form-select:focus {
      background-color: rgba(26, 30, 37, 0.9);
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
      color: var(--text-light);
    }

    .form-select {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ecf0f1' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
    }

    .form-select option {
      background-color: #2c3e50;
      color: var(--text-light);
    }

    .form-control::placeholder { /* Modern browsers */
       color: white;
    }

    .btn {
      padding: 12px 16px;
      font-weight: 500;
      border-radius: 8px;
      transition: all 0.3s;
    }

    .btn-primary {
      background: linear-gradient(135deg, #3498db, #2980b9);
      border: none;
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, #2980b9, #2573a7);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
    }

    .btn i {
      margin-right: 8px;
    }

    /* Watchlist Grid */
    .watchlist-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 25px;
      margin-bottom: 30px;
    }

    /* Watchlist Cards */
    .watchlist-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.3s ease;
      height: 100%;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .watchlist-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .watchlist-thumbnail {
      width: 100%;
      height: 200px;
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

    .watchlist-card-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 15px;
      color: var(--text-light);
      text-align: center;
      padding: 8px;
      background: rgba(44, 62, 80, 0.5);
      border-radius: 6px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
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
      flex-direction: column;
      gap: 5px;
      margin-bottom: 15px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      padding: 10px 0;
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
      justify-content: center;
    }

    .btn-outline-light {
      border: 1px solid rgba(255, 255, 255, 0.5);
      color: var(--text-light);
      background: rgba(255, 255, 255, 0.05);
    }

    .btn-outline-light:hover {
      background-color: rgba(255, 255, 255, 0.1);
      border-color: var(--text-light);
    }

    .btn-danger {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      border: none;
      color: white;
    }

    .btn-danger:hover {
      background: linear-gradient(135deg, #c0392b, #a93226);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
    }

    /* Empty State */
    .empty-state {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 50px 30px;
      text-align: center;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      margin: 30px 0;
    }

    .empty-state i {
      font-size: 48px;
      margin-bottom: 20px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .empty-state h4 {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 10px;
    }

    .empty-state p {
      font-size: 16px;
      color: var(--text-muted);
      margin-bottom: 20px;
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
        font-size: 24px;
      }

      .watchlist-grid {
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
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

      .page-header {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
      }

      .back-link {
        width: 100%;
        justify-content: center;
      }

      .watchlist-grid {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 575px) {
      .btn-group {
        flex-direction: column;
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
        <a href="/watchlists/watchlist-list">Watchlists Library</a>
        <a href="/browse-anime">Browse Anime</a>
      <#else>
        <a href="/login">Login</a>
        <a href="/watchlists/watchlist-list">Watchlists Library</a>
        <a href="/browse-anime">Browse Anime</a>
      </#if>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <!-- Page Header -->
      <div class="page-header">
        <h1 class="page-title">My Subscribed Watchlists</h1>
        <a href="/provider-profile/${providerId!}" class="back-link">
          <i class="fas fa-arrow-left"></i> Back to Profile
        </a>
      </div>

      <!-- Search and Filter Section -->
      <div class="search-filter-section">
        <div class="row g-3">
          <div class="col-md-6">
            <input type="text" id="searchInput" class="form-control" placeholder="Search watchlists by title or provider...">
          </div>
          <div class="col-md-4">
            <select id="sortSelect" class="form-select">
              <option value="newest">Newest First</option>
              <option value="oldest">Oldest First</option>
              <option value="rating">Highest Rating</option>
              <option value="views">Most Views</option>
            </select>
          </div>
          <div class="col-md-2">
            <a href="/watchlists/watchlist-list" class="btn btn-primary w-100">
              <i class="fas fa-search"></i> Browse
            </a>
          </div>
        </div>
      </div>

      <!-- Watchlist Display -->
      <#if !subscribedWatchlists?? || subscribedWatchlists?size == 0>
        <div class="empty-state">
          <i class="fas fa-list-alt"></i>
          <h4>No Subscribed Watchlists Yet</h4>
          <p>Explore the watchlist library and subscribe to watchlists that interest you.</p>
          <a href="/watchlists/watchlist-list" class="btn btn-primary">
            <i class="fas fa-search"></i> Explore Watchlists
          </a>
        </div>
      <#else>
        <div class="watchlist-grid" id="watchlistContainer">
          <#list subscribedWatchlists as watchlist>
            <div class="watchlist-item" data-title="${watchlist.title}" data-provider="${watchlist.providerUsername!''}" data-date="${watchlist.createdAt!''}" data-rating="${(watchlist.rating!0)}">
              <div class="watchlist-card">
                <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Watchlist Thumbnail" class="watchlist-thumbnail" onerror="this.src='/pics/default-watchlist.jpg';">
                <div class="watchlist-card-body">
                  <h5 class="watchlist-card-title">${watchlist.title}</h5>
                  <div class="provider-info">
                    <img src="${watchlist.avatar!'/pics/default-profile.jpg'}" alt="Profile Image" class="profile-image">
                    <p class="watchlist-card-text">By: <a href="/provider-profile/${watchlist.providerId}" class="text-light">${watchlist.providerUsername!''}</a></p>
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
                  <#if isOwnProfile?? && isOwnProfile>
                    <div class="btn-group">
                      <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light"> View list
                      </a>
                      <button class="btn btn-danger unsubscribe-btn" data-watchlist-id="${watchlist.watchlistId}"> Unsubscribe
                      </button>
                    </div>
                  <#else>
                    <div class="btn-group">
                      <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">
                        <i class="fas fa-eye"></i> View Watchlist
                      </a>
                    </div>
                  </#if>
                </div>
              </div>
            </div>
          </#list>
        </div>

        <!-- No results message (hidden by default) -->
        <div id="noResults" class="empty-state" style="display: none;">
          <i class="fas fa-search"></i>
          <h4>No Results Found</h4>
          <p>Try adjusting your search criteria.</p>
        </div>
      </#if>
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
  <#noparse>
    document.addEventListener('DOMContentLoaded', function() {
      // Search functionality
      const searchInput = document.getElementById('searchInput');
      const watchlistItems = document.querySelectorAll('.watchlist-item');
      const noResultsMsg = document.getElementById('noResults');

      function filterWatchlists() {
        const searchTerm = searchInput.value.toLowerCase();
        let resultsFound = false;

        watchlistItems.forEach(item => {
          const title = item.getAttribute('data-title') ? item.getAttribute('data-title').toLowerCase() : '';
          const provider = item.getAttribute('data-provider') ? item.getAttribute('data-provider').toLowerCase() : '';

          if (title.includes(searchTerm) || provider.includes(searchTerm)) {
            item.style.display = '';
            resultsFound = true;
          } else {
            item.style.display = 'none';
          }
        });

        // Show/hide no results message
        if (noResultsMsg) {
          noResultsMsg.style.display = resultsFound ? 'none' : 'flex';
        }
      }

      if (searchInput) {
        searchInput.addEventListener('input', filterWatchlists);
      }

      // Sorting functionality
      const sortSelect = document.getElementById('sortSelect');
      const watchlistContainer = document.getElementById('watchlistContainer');

      if (sortSelect && watchlistContainer) {
        sortSelect.addEventListener('change', function() {
          const sortValue = this.value;
          const watchlistsArray = Array.from(watchlistItems);

          watchlistsArray.sort((a, b) => {
            if (sortValue === 'newest') {
              return new Date(b.getAttribute('data-date') || 0) - new Date(a.getAttribute('data-date') || 0);
            } else if (sortValue === 'oldest') {
              return new Date(a.getAttribute('data-date') || 0) - new Date(b.getAttribute('data-date') || 0);
            } else if (sortValue === 'rating') {
              return parseFloat(b.getAttribute('data-rating') || 0) - parseFloat(a.getAttribute('data-rating') || 0);
            } else if (sortValue === 'views') {
              const viewsA = a.querySelector('.views-counter').textContent.match(/\d+/) || 0;
              const viewsB = b.querySelector('.views-counter').textContent.match(/\d+/) || 0;
              return parseInt(viewsB) - parseInt(viewsA);
            }
            return 0;
          });

          watchlistsArray.forEach(item => {
            watchlistContainer.appendChild(item);
          });
        });
      }

      // Handle unsubscribe buttons
      const unsubscribeButtons = document.querySelectorAll('.unsubscribe-btn');

      unsubscribeButtons.forEach(button => {
        button.addEventListener('click', function() {
          const watchlistId = this.dataset.watchlistId;

          // Create confirmation modal
          const confirmModal = document.createElement('div');
          confirmModal.classList.add('modal', 'fade');
          confirmModal.id = 'confirmUnsubscribeModal';
          confirmModal.setAttribute('tabindex', '-1');
          confirmModal.setAttribute('aria-labelledby', 'confirmUnsubscribeModalLabel');
          confirmModal.setAttribute('aria-hidden', 'true');

          confirmModal.innerHTML = `
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="confirmUnsubscribeModalLabel">Confirm Unsubscribe</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <p>Are you sure you want to unsubscribe from this watchlist?</p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Cancel</button>
                  <button type="button" class="btn btn-danger" id="confirmUnsubscribeBtn">
                    <i class="fas fa-times"></i> Unsubscribe
                  </button>
                </div>
              </div>
            </div>
          `;

          document.body.appendChild(confirmModal);

          const bsModal = new bootstrap.Modal(confirmModal);
          bsModal.show();

          // Handle confirm button click
          document.getElementById('confirmUnsubscribeBtn').addEventListener('click', function() {
            fetch(`/api/subscriptions/unsubscribe/${watchlistId}`, {
              method: 'POST'
            })
            .then(response => {
              if (response.ok) {
                // Close the modal
                bsModal.hide();

                // Remove the modal from DOM after hiding
                confirmModal.addEventListener('hidden.bs.modal', function() {
                  confirmModal.remove();
                });

                // Remove the watchlist card with animation
                const watchlistItem = button.closest('.watchlist-item');
                watchlistItem.style.transition = 'opacity 0.3s, transform 0.3s';
                watchlistItem.style.opacity = '0';
                watchlistItem.style.transform = 'translateY(20px)';

                setTimeout(() => {
                  watchlistItem.remove();

                  // Show success toast
                  showToast('success', 'Successfully unsubscribed from watchlist');

                  // Check if any watchlists remain
                  if (document.querySelectorAll('.watchlist-item').length === 0) {
                    // Show empty state if no watchlists remain
                    const emptyState = document.createElement('div');
                    emptyState.className = 'empty-state';
                    emptyState.innerHTML = `
                      <i class="fas fa-list-alt"></i>
                      <h4>No Subscribed Watchlists Yet</h4>
                      <p>Explore the watchlist library and subscribe to watchlists that interest you.</p>
                      <a href="/watchlists/watchlist-list" class="btn btn-primary">
                        <i class="fas fa-search"></i> Explore Watchlists
                      </a>
                    `;

                    document.querySelector('.container').appendChild(emptyState);

                    // If noResults is displayed, hide it
                    if (noResultsMsg && noResultsMsg.style.display !== 'none') {
                      noResultsMsg.style.display = 'none';
                    }
                  }

                  // Re-run filter in case search is active
                  filterWatchlists();
                }, 300);
              } else {
                throw new Error('Failed to unsubscribe');
              }
            })
            .catch(error => {
              console.error('Error:', error);

              // Close the modal
              bsModal.hide();

              // Remove the modal from DOM after hiding
              confirmModal.addEventListener('hidden.bs.modal', function() {
                confirmModal.remove();
              });

              // Show error toast
              showToast('error', 'Failed to unsubscribe. Please try again.');
            });
          });
        });
      });

      // Toast notification function
      function showToast(type, message) {
        const toastEl = document.createElement('div');
        toastEl.classList.add('toast', 'align-items-center', 'position-fixed', 'top-0', 'end-0', 'mt-3', 'me-3', 'border-0');

        if (type === 'success') {
          toastEl.classList.add('text-bg-success');
        } else if (type === 'error') {
          toastEl.classList.add('text-bg-danger');
        }

        toastEl.setAttribute('role', 'alert');
        toastEl.setAttribute('aria-live', 'assertive');
        toastEl.setAttribute('aria-atomic', 'true');

        const icon = type === 'success' ? 'check-circle' : 'exclamation-circle';

        toastEl.innerHTML = `
          <div class="d-flex">
            <div class="toast-body">
              <i class="fas fa-${icon} me-2"></i> ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
          </div>
        `;

        document.body.appendChild(toastEl);

        const toast = new bootstrap.Toast(toastEl, {
          autohide: true,
          delay: 3000
        });

        toast.show();

        // Remove the toast from DOM after hiding
        toastEl.addEventListener('hidden.bs.toast', function() {
          toastEl.remove();
        });
      }
    });
    <#noparse>
  </script>
</body>
</html>