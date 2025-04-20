<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - Watchlists Library</title>
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
            margin-bottom: 50px;
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

        /* Watchlist Cards */
        .watchlist-item {
            transition: all 0.3s ease;
        }

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
            padding: 8px 12px;
            background: rgba(52, 73, 94, 0.5);
            border-radius: 6px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
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
            justify-content: center;
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

        /* View More Button */
        #viewMoreContainer {
            margin-top: 40px;
            text-align: center;
        }

        #viewMoreBtn {
            background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
            color: var(--text-light);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 500;
            transition: all 0.3s;
        }

        #viewMoreBtn:hover {
            background: linear-gradient(135deg, rgba(52, 73, 94, 0.7) 0%, rgba(44, 62, 80, 0.7) 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            border-color: var(--primary-color);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            background: linear-gradient(135deg, rgba(44, 62, 80, 0.3) 0%, rgba(52, 73, 94, 0.3) 100%);
            border-radius: 12px;
            padding: 60px 30px;
            margin: 40px 0;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .empty-state i {
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 20px;
            opacity: 0.8;
        }

        .empty-state p {
            font-size: 18px;
            color: var(--text-muted);
            margin-bottom: 20px;
        }

        /* No Search Results */
        #noSearchResults {
            background: linear-gradient(135deg, rgba(41, 128, 185, 0.1) 0%, rgba(52, 152, 219, 0.1) 100%);
            border: 1px solid rgba(52, 152, 219, 0.2);
            border-radius: 12px;
            padding: 40px 20px;
            text-align: center;
        }

        #noSearchResults i {
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        #noSearchResults p {
            color: var(--text-muted);
            font-size: 16px;
        }

        /* Animation for cards appearing */
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

        .watchlist-item {
            animation: fadeInUp 0.5s ease-out forwards;
        }

        /* Responsive Adjustments */
        @media (max-width: 991px) {
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

            .search-bar .form-control {
                padding: 12px 20px;
            }
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
        .watchlist-item {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.5s ease-out forwards;
        }

        .watchlist-item:nth-child(1) { animation-delay: 0.1s; }
        .watchlist-item:nth-child(2) { animation-delay: 0.2s; }
        .watchlist-item:nth-child(3) { animation-delay: 0.3s; }
        .watchlist-item:nth-child(4) { animation-delay: 0.4s; }
        .watchlist-item:nth-child(5) { animation-delay: 0.5s; }
        .watchlist-item:nth-child(6) { animation-delay: 0.6s; }
        .watchlist-item:nth-child(7) { animation-delay: 0.7s; }
        .watchlist-item:nth-child(8) { animation-delay: 0.8s; }
        .watchlist-item:nth-child(9) { animation-delay: 0.9s; }
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
            <a href="/watchlists/watchlist-list">Watchlists library</a>
            <a href="/browse-anime">Browse Anime</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container">
            <div class="page-header">
                <h2>Browse Watchlists</h2>
                <p>Discover curated anime watchlists from our community!</p>
            </div>

            <!-- Search Bar -->
            <div class="search-bar">
                <input type="text" id="searchInput" class="form-control" placeholder="Search watchlists by name or provider...">
            </div>

            <#if watchlists?has_content>
                <div class="row" id="watchlistContainer">
                    <#assign count = 0>
                    <#list watchlists?sort_by("watchlistId")?reverse as watchlist>
                        <#if count < 9>
                            <div class="col-md-4 mb-4 watchlist-item">
                                <div class="watchlist-card">
                                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="${watchlist.title}" class="watchlist-thumbnail" onerror="this.src='/pics/default-watchlist.jpg';">
                                    <div class="watchlist-card-body">
                                        <h5 class="watchlist-card-title">${watchlist.title}</h5>
                                        <div class="provider-info">
                                            <img src="${watchlist.avatar!'/pics/default-profile.jpg'}" alt="Provider" class="profile-image">
                                            <span class="watchlist-card-text">By: <a href="/provider-profile/${watchlist.providerId!}" class="text-light">${watchlist.providerUsername!}</a></span>
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
                        <#else>
                            <div class="col-md-4 mb-4 watchlist-item hidden-watchlist" style="display: none;">
                                <div class="watchlist-card">
                                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="${watchlist.title}" class="watchlist-thumbnail" onerror="this.src='/pics/default-watchlist.jpg';">
                                    <div class="watchlist-card-body">
                                        <h5 class="watchlist-card-title">${watchlist.title}</h5>
                                        <div class="provider-info">
                                            <img src="${watchlist.avatar!'/pics/default-profile.jpg'}" alt="Provider" class="profile-image">
                                            <span class="watchlist-card-text">By: <a href="/provider-profile/${watchlist.providerId!}" class="text-light">${watchlist.providerUsername!}</a></span>
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
                        </#if>
                        <#assign count = count + 1>
                    </#list>
                </div>

                <!-- No search results message -->
                <div id="noSearchResults" style="display: none;" class="text-center mt-4 w-100">
                    <i class="fas fa-search fa-2x mb-3"></i>
                    <p>No watchlists found matching your search. Try different keywords.</p>
                </div>

                <#if watchlists?size gt 9>
                    <div id="viewMoreContainer">
                        <button id="viewMoreBtn" class="btn btn-lg">
                            <i class="fas fa-plus-circle me-2"></i> View More Watchlists
                        </button>
                    </div>
                </#if>
            <#else>
                <div class="empty-state">
                    <i class="fas fa-list-alt"></i>
                    <p>No watchlists found.</p>
                    <#if isProvider?? && isProvider>
                        <a href="/watchlists/new" class="btn btn-primary mt-3">
                            <i class="fas fa-plus-circle me-2"></i> Create Your First Watchlist
                        </a>
                    </#if>
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

    <!-- Auth Modals -->
    <@auth.authModals/>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/login-registration.js"></script>

    <script>
    // Search and View More Functionality
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('searchInput');
        if (!searchInput) return;

        const watchlistContainer = document.getElementById('watchlistContainer');
        if (!watchlistContainer) return;

        const viewMoreContainer = document.getElementById('viewMoreContainer');

        // Store original HTML and visibility state
        const originalHTML = watchlistContainer.innerHTML;
        const originalViewMoreDisplay = viewMoreContainer ? viewMoreContainer.style.display : 'none';

        setupViewMore(); // Initial setup

        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            const allItems = Array.from(watchlistContainer.querySelectorAll('.watchlist-item'));
            const noResultsMsg = document.getElementById('noSearchResults');

            // If search is cleared, restore original state
            if (searchTerm === '') {
                watchlistContainer.innerHTML = originalHTML;
                if (noResultsMsg) noResultsMsg.style.display = 'none';

                // Restore view more button
                if (viewMoreContainer) {
                    viewMoreContainer.style.display = originalViewMoreDisplay;
                }

                setupViewMore(); // Reattach event listeners
                return;
            }

            // Handle search
            watchlistContainer.innerHTML = '';

            const matchingItems = allItems.filter(item => {
                const titleElement = item.querySelector('.watchlist-card-title');
                const usernameElement = item.querySelector('.watchlist-card-text');

                if (!titleElement) return false;

                const title = titleElement.textContent.toLowerCase();
                const username = usernameElement ? usernameElement.textContent.toLowerCase() : '';

                return title.includes(searchTerm) || username.includes(searchTerm);
            });

            matchingItems.forEach(item => {
                watchlistContainer.appendChild(item);
                item.style.display = 'block';
                item.classList.remove('hidden-watchlist');
            });

            // Show/hide no results message
            if (noResultsMsg) {
                noResultsMsg.style.display = matchingItems.length > 0 ? 'none' : 'block';
            }

            // Hide view more button during search
            if (viewMoreContainer) {
                viewMoreContainer.style.display = 'none';
            }
        });

        function setupViewMore() {
            const viewMoreBtn = document.getElementById('viewMoreBtn');
            if (!viewMoreBtn) return;

            // Remove existing event listeners by cloning and replacing
            const newViewMoreBtn = viewMoreBtn.cloneNode(true);
            viewMoreBtn.parentNode.replaceChild(newViewMoreBtn, viewMoreBtn);

            newViewMoreBtn.addEventListener('click', function() {
                const hiddenItems = document.querySelectorAll('.watchlist-item.hidden-watchlist');
                const batchSize = 6;
                let shown = 0;

                hiddenItems.forEach(function(item) {
                    if (shown < batchSize) {
                        item.style.display = 'block';
                        item.classList.remove('hidden-watchlist');
                                                item.style.animation = 'fadeInUp 0.5s ease-out forwards';
                                                shown++;
                                            }
                                        });

                                        if (document.querySelectorAll('.watchlist-item.hidden-watchlist').length === 0) {
                                            this.style.display = 'none';
                                        }
                                    });
                                }

                                // Add some visual feedback on hover for watchlist cards
                                const watchlistCards = document.querySelectorAll('.watchlist-card');
                                watchlistCards.forEach(card => {
                                    card.addEventListener('mouseenter', function() {
                                        this.style.transform = 'translateY(-10px)';
                                        this.style.boxShadow = '0 15px 30px rgba(0, 0, 0, 0.3)';
                                        this.style.borderColor = 'rgba(52, 152, 219, 0.3)';
                                    });

                                    card.addEventListener('mouseleave', function() {
                                        this.style.transform = '';
                                        this.style.boxShadow = '';
                                        this.style.borderColor = '';
                                    });
                                });
                            });

                            <#noparse>
                            document.addEventListener('DOMContentLoaded', function() {
                                // Get all subscribe buttons
                                const subscribeButtons = document.querySelectorAll('.btn-primary');

                                // Add click event to each button
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

                                // Add loading animation for the page
                                window.addEventListener('load', function() {
                                    document.body.classList.add('loaded');
                                });
                            });
                            </#noparse>
                            </script>
                        </body>
                        </html>