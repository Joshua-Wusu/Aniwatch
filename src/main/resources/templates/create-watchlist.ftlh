<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - Create Watchlist</title>

    <!-- Stylesheets -->
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
            margin-right: -74px!important;
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

        .page-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .page-header h2 {
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 32px;
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
            max-width: 600px;
            margin: 0 auto;
        }

        .form-card {
            background: linear-gradient(135deg, rgba(44, 62, 80, 0.6) 0%, rgba(52, 73, 94, 0.6) 100%);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            margin-bottom: 40px;
        }

        .form-label {
            color: var(--text-light);
            font-weight: 500;
            margin-bottom: 10px;
            font-size: 16px;
            display: flex;
            align-items: center;
        }

        .form-label i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .form-control {
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.3s;
            color: black;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        /* Thumbnail Upload Area */
        .thumbnail-section {
            position: relative;
        }

        .upload-area {
            background: linear-gradient(135deg, rgba(26, 30, 37, 0.6) 0%, rgba(44, 62, 80, 0.6) 100%);
            border: 2px dashed rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            position: relative;
            margin-bottom: 20px;
        }

        .upload-area:hover {
            border-color: var(--primary-color);
            background: linear-gradient(135deg, rgba(26, 30, 37, 0.7) 0%, rgba(44, 62, 80, 0.7) 100%);
        }

        .upload-icon {
            font-size: 40px;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .upload-text {
            color: var(--text-light);
            margin-bottom: 5px;
            font-weight: 500;
        }

        .upload-hint {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 0;
        }

        .selected-file {
            margin-top: 15px;
            padding: 10px;
            background-color: rgba(52, 152, 219, 0.2);
            border-radius: 8px;
            display: none;
        }

        .selected-file.active {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .selected-file-name {
            color: var(--text-light);
            margin-right: 10px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .remove-file {
            color: var(--danger);
            cursor: pointer;
            transition: all 0.2s;
            font-size: 18px;
        }

        .remove-file:hover {
            transform: scale(1.1);
        }

        .thumbnail-preview {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-top: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            display: none;
        }

        /* Buttons */
        .btn {
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
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

        .btn-secondary {
            background-color: rgba(44, 62, 80, 0.7);
            border: none;
        }

        .btn-secondary:hover {
            background-color: rgba(44, 62, 80, 0.9);
            transform: translateY(-2px);
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
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

        @media (max-width: 767px) {
            .form-card {
                padding: 20px;
            }

            .btn-group {
                flex-direction: column;
            }

            .social-links a {
                width: 40px;
                height: 40px;
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
        <div class="container">
            <div class="page-header">
                <h2>Create a New Watchlist</h2>
                <p>Share your anime recommendations and create curated lists for the community</p>
            </div>

            <div class="form-card">
                <form method="POST" action="/watchlists/create" enctype="multipart/form-data">
                    <!-- CSRF Token if applicable -->
                    <#if _csrf??>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </#if>

                    <!-- Hidden Provider Information -->
                    <input type="hidden" name="providerId" value="${providerId!}">
                    <input type="hidden" name="providerUsername" value="${username!}">

                    <!-- Title -->
                    <div class="mb-4">
                        <label for="title" class="form-label">
                            <i class="fas fa-heading"></i> Watchlist Title
                        </label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Enter a title for your watchlist" required>
                    </div>

                    <!-- Description -->
                    <div class="mb-4">
                        <label for="description" class="form-label">
                            <i class="fas fa-align-left"></i> Description
                        </label>
                        <textarea class="form-control" id="description" name="description"
                                  placeholder="Describe your watchlist..."
                                  rows="4"></textarea>
                    </div>

                    <!-- Thumbnail Upload -->
                    <div class="mb-4 thumbnail-section">
                        <label class="form-label">
                            <i class="fas fa-image"></i> Watchlist Thumbnail
                        </label>

                        <div class="upload-area" id="upload-area">
                            <i class="fas fa-cloud-upload-alt upload-icon"></i>
                            <p class="upload-text">Drag & drop an image or click to browse</p>
                            <p class="upload-hint">Recommended size: 1280×720px (16:9 ratio)</p>
                            <!-- File input is outside the click area to prevent event bubbling issues -->
                        </div>

                        <!-- Hidden file input that won't interfere with clicking -->
                        <input type="file" id="thumbnailFile" name="thumbnailFile" accept="image/*"
                               style="position: absolute; left: -9999px; visibility: hidden;">

                        <div class="selected-file" id="selected-file">
                            <span class="selected-file-name" id="selected-file-name"></span>
                            <i class="fas fa-times-circle remove-file" id="remove-file"></i>
                        </div>

                        <img id="thumbnailPreview" src="#" alt="Thumbnail Preview" class="thumbnail-preview">
                    </div>

                    <!-- Buttons -->
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus-circle me-2"></i> Create Watchlist
                        </button>
                        <a href="/watchlists/watchlist-list" class="btn btn-dark">
                            <i class="fas fa-times me-2"></i> Cancel
                        </a>
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

    <#import "/fragments/auth-modals.ftlh" as auth>
    <@auth.authModals/>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // File input handling
        document.addEventListener('DOMContentLoaded', function() {
            // Get all necessary elements
            const uploadArea = document.getElementById('upload-area');
            const fileInput = document.getElementById('thumbnailFile');
            const preview = document.getElementById('thumbnailPreview');
            const selectedFile = document.getElementById('selected-file');
            const selectedFileName = document.getElementById('selected-file-name');
            const removeFileBtn = document.getElementById('remove-file');

            // Track if we're currently processing a file to prevent multiple uploads
            let isProcessingFile = false;

            // Click handler for the upload area - separate from the file input
            uploadArea.addEventListener('click', function(e) {
                // Prevent duplicate events
                if (e.target !== fileInput) {
                    e.preventDefault();
                    e.stopPropagation();
                    // Only trigger click if we're not already processing a file
                    if (!isProcessingFile) {
                        fileInput.click();
                    }
                }
            });

            // File input change handler
            fileInput.addEventListener('change', function(e) {
                e.stopPropagation();
                if (!isProcessingFile && this.files && this.files[0]) {
                    processSelectedFile(this.files[0]);
                }
            });

            // Handle file processing in one place to avoid duplication
            function processSelectedFile(file) {
                isProcessingFile = true;

                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    selectedFile.classList.add('active');
                    selectedFileName.textContent = file.name;
                    uploadArea.style.borderColor = '#3498db';

                    // Reset the processing flag after a short delay
                    setTimeout(() => {
                        isProcessingFile = false;
                    }, 300);
                };

                reader.onerror = function() {
                    console.error('Error reading file');
                    isProcessingFile = false;
                };

                reader.readAsDataURL(file);
            }

            // Remove file handler
            removeFileBtn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                removeFile();
            });

            function removeFile() {
                fileInput.value = '';
                preview.src = '#';
                preview.style.display = 'none';
                selectedFile.classList.remove('active');
                uploadArea.style.borderColor = 'rgba(255, 255, 255, 0.2)';
                isProcessingFile = false;
            }

            // === Drag and Drop Functionality ===
            // Prevent defaults for all drag events
            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                uploadArea.addEventListener(eventName, function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                }, false);
            });

            // Highlight upload area on drag enter/over
            ['dragenter', 'dragover'].forEach(eventName => {
                uploadArea.addEventListener(eventName, function() {
                    uploadArea.style.borderColor = '#3498db';
                    uploadArea.style.backgroundColor = 'rgba(52, 152, 219, 0.1)';
                }, false);
            });

            // Remove highlight on drag leave/drop
            ['dragleave', 'drop'].forEach(eventName => {
                uploadArea.addEventListener(eventName, function() {
                    uploadArea.style.borderColor = 'rgba(255, 255, 255, 0.2)';
                    uploadArea.style.backgroundColor = '';
                }, false);
            });

            // Handle file drop
            uploadArea.addEventListener('drop', function(e) {
                if (!isProcessingFile && e.dataTransfer.files && e.dataTransfer.files[0]) {
                    const file = e.dataTransfer.files[0];
                    // Update the file input with the dropped file
                    const dataTransfer = new DataTransfer();
                    dataTransfer.items.add(file);
                    fileInput.files = dataTransfer.files;

                    // Process the file
                    processSelectedFile(file);
                }
            }, false);
        });
    </script>
</body>
</html>