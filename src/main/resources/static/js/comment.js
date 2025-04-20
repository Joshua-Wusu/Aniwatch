$(document).ready(function () {
    if (typeof watchlistId === "undefined") {
        console.error("watchlistId is not defined");
        alert("Error: Watchlist ID is missing. Cannot load comments.");
        return;
    }

    const COMMENTS_PER_PAGE = 5;

    // Only initialize emoji picker if comment input exists (i.e., user is logged in)
    if (document.querySelector(".comment-input-wrapper")) {
        const pickerContainer = document.createElement("div");
        pickerContainer.id = "emojiPickerContainer";
        pickerContainer.style.display = "none";
        pickerContainer.style.position = "absolute";
        pickerContainer.style.zIndex = "1000";
        document.querySelector(".comment-input-wrapper").appendChild(pickerContainer);

        let activeInput = null;

        const pickerOptions = {
            onEmojiSelect: function (emoji) {
                console.log("Emoji selected:", emoji);
                if (!activeInput) return;
                const currentText = activeInput.val();
                const newText = currentText + emoji.native;
                activeInput.val(newText);
                pickerContainer.style.display = "none";
            },
            theme: "dark",
            set: "native",
            previewPosition: "bottom",
            maxFrequentRows: 2
        };

        const picker = new EmojiMart.Picker(pickerOptions);
        pickerContainer.appendChild(picker);

        $("#emojiPicker").on("click", function (e) {
            e.preventDefault();
            console.log("Main emoji button clicked");
            activeInput = $("#commentBox");
            const isVisible = pickerContainer.style.display === "block";
            pickerContainer.style.display = isVisible ? "none" : "block";
            if (!isVisible) {
                const buttonRect = this.getBoundingClientRect();
                pickerContainer.style.top = `${buttonRect.bottom + window.scrollY}px`;
                pickerContainer.style.left = `${buttonRect.left + window.scrollX - 150}px`;
            }
        });

        $(document).on("click", ".reply-emoji-button", function (e) {
            e.preventDefault();
            console.log("Reply emoji button clicked");
            activeInput = $(this).closest(".reply-input-wrapper").find(".reply-box");
            const isVisible = pickerContainer.style.display === "block";
            pickerContainer.style.display = isVisible ? "none" : "block";
            if (!isVisible) {
                const buttonRect = this.getBoundingClientRect();
                pickerContainer.style.top = `${buttonRect.bottom + window.scrollY}px`;
                pickerContainer.style.left = `${buttonRect.left + window.scrollX - 150}px`;
            }
        });

        $(document).on("click", function (e) {
            if (
                !$(e.target).closest("#emojiPicker").length &&
                !$(e.target).closest(".reply-emoji-button").length &&
                !$(e.target).closest("#emojiPickerContainer").length
            ) {
                pickerContainer.style.display = "none";
            }
        });
    }

    // Always fetch comments (regardless of login status)
    fetchComments();

    function createCommentElement(comment, isReply = false, nestingLevel = 0, parentAuthor = null) {
        const commentId = comment.commentId || Math.floor(Math.random() * 10000);

        console.log(`Creating ${isReply ? 'reply' : 'comment'} element with ID: ${commentId}, mentioning: ${parentAuthor || 'none'}`);

        const commentDiv = document.createElement("div");
        commentDiv.className = isReply ? "d-flex flex-start reply" : "d-flex flex-start mb-4";
        commentDiv.setAttribute('data-comment-id', commentId);
        commentDiv.setAttribute('data-nesting-level', isReply ? 1 : 0);

        // Avatar image
        const avatarImg = document.createElement("img");
        avatarImg.className = "rounded-circle shadow-1-strong user-profile-link";
        avatarImg.src = comment.avatarSrc || "/pics/default-profile.jpg";
        avatarImg.alt = "avatar";
        avatarImg.width = isReply ? 65 : 65;
        avatarImg.height = isReply ? 65 : 65;
        avatarImg.style.cursor = "pointer";

        avatarImg.setAttribute('data-username', comment.username);

        // Comment card container
        const cardDiv = document.createElement("div");
        cardDiv.className = "comment-card w-100";
        cardDiv.setAttribute('data-username', comment.username);
        cardDiv.setAttribute('data-comment-id', commentId);

        // Card body
        const cardBody = document.createElement("div");
        cardBody.className = "comment-card-body p-4";

        // Header with username and date
        const headerDiv = document.createElement("div");
        headerDiv.className = "comment-header";

        const authorHeading = document.createElement(isReply ? "h5" : "h5");
        authorHeading.className = "comment-author user-profile-link";
        authorHeading.textContent = comment.username;
        authorHeading.style.cursor = "pointer";
        authorHeading.setAttribute('data-username', comment.username);

        const dateSpan = document.createElement("span");
        dateSpan.className = "comment-date";
        dateSpan.textContent = new Date(comment.createdAt).toLocaleDateString();

        const timeSpan = document.createElement("span");
        timeSpan.className = "comment-time";
        timeSpan.textContent = new Date(comment.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        // Comment text with mention if reply
        const commentP = document.createElement("p");

        if (isReply && parentAuthor) {
            // Create mention link (@) for parent author
            const mentionText = document.createElement("a");
            mentionText.href = "#";
            mentionText.style.color = "#007bff";
            mentionText.textContent = `@${parentAuthor}`;
            mentionText.style.textDecoration = "none";
            mentionText.style.marginRight = "5px";

            commentP.appendChild(mentionText);
            commentP.appendChild(document.createTextNode(" " + comment.text));
        } else {
            commentP.textContent = comment.text;
        }

        // Action buttons (like, dislike, reply)
        const actionDiv = document.createElement("div");
        actionDiv.className = "d-flex justify-content-between align-items-center mb-3";
        actionDiv.setAttribute('data-comment-id', commentId);

        const likeDiv = document.createElement("div");
        likeDiv.className = "d-flex align-items-center gap-2";

        const likeLink = document.createElement("a");
        likeLink.href = "#";
        likeLink.className = "link-muted me-2 like-btn";
        likeLink.setAttribute('data-action', 'like');
        likeLink.innerHTML = `<i class="fas fa-thumbs-up me-1"></i><span class="like-count">${comment.likes || 0}</span>`;

        const dislikeLink = document.createElement("a");
        dislikeLink.href = "#";
        dislikeLink.className = "link-muted dislike-btn";
        dislikeLink.setAttribute('data-action', 'dislike');
        dislikeLink.innerHTML = `<i class="fas fa-thumbs-down me-1"></i><span class="dislike-count">${comment.dislikes || 0}</span>`;

        // Only show reply button if user is logged in
        const isLoggedIn = document.querySelector(".comment-input-wrapper") !== null;

        likeDiv.appendChild(likeLink);
        likeDiv.appendChild(dislikeLink);

        actionDiv.appendChild(likeDiv);

        if (isLoggedIn) {
            const replyLink = document.createElement("a");
            replyLink.href = "#";
            replyLink.className = "link-muted reply-btn";
            replyLink.setAttribute('data-action', 'reply');
            replyLink.innerHTML = '<i class="fas fa-reply me-1"></i> Reply';
            actionDiv.appendChild(replyLink);
        }

        headerDiv.appendChild(authorHeading);
        headerDiv.appendChild(dateSpan);
        headerDiv.appendChild(timeSpan);

        cardBody.appendChild(headerDiv);
        cardBody.appendChild(commentP);
        cardBody.appendChild(actionDiv);

        cardDiv.appendChild(cardBody);
        commentDiv.appendChild(avatarImg);
        commentDiv.appendChild(cardDiv);

        return commentDiv;
    }

    // Add a click event handler for profile links
    $(document).on('click', '.user-profile-link', function(e) {
        e.preventDefault();
        const username = $(this).data('username');
        if (!username) {
            console.error("Username not found on clicked element");
            return;
        }

        // Determine if this is a provider or regular user
        navigateToUserProfile(username);
    });

    // Function to handle determining user type and redirecting
    function navigateToUserProfile(username) {
        // First, check if the user exists and get their type
        fetch(`/user/check-type?username=${encodeURIComponent(username)}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to get user information");
                }
                return response.json();
            })
            .then(data => {
                if (data.exists) {
                    if (data.isProvider) {
                        // If provider, redirect to provider profile
                        window.location.href = `/provider-profile/${data.providerId}`;
                    } else {
                        // If regular user, redirect to user profile
                        // You might want to implement a public user profile page
                        window.location.href = `/user-profile/${data.userId}`;
                    }
                } else {
                    console.error("User not found:", username);
                    alert("User profile not found.");
                }
            })
            .catch(error => {
                console.error("Error navigating to profile:", error);
                alert("Could not navigate to user profile. Please try again.");
            });
    }

    function createReplyInputWrapper(parentId) {
        const replyInputWrapper = document.createElement("div");
        replyInputWrapper.className = "reply-input-wrapper mt-3";
        replyInputWrapper.setAttribute('data-parent-id', parentId);

        const inputContainer = document.createElement("div");
        inputContainer.className = "input-container position-relative";

        const replyTextarea = document.createElement("textarea");
        replyTextarea.className = "form-control border-0 bg-secondary reply-box";
        replyTextarea.placeholder = "Write a reply...";

        const emojiButton = document.createElement("button");
        emojiButton.className = "reply-emoji-button";
        emojiButton.innerHTML = "😊";

        inputContainer.appendChild(replyTextarea);
        inputContainer.appendChild(emojiButton);

        const replyButtonDiv = document.createElement("div");
        replyButtonDiv.className = "d-flex justify-content-end mt-2";

        const replyButton = document.createElement("button");
        replyButton.className = "btn btn-primary btn-sm post-reply-btn me-1";
        replyButton.textContent = "Reply";

        replyButtonDiv.appendChild(replyButton);
        replyInputWrapper.appendChild(inputContainer);
        replyInputWrapper.appendChild(replyButtonDiv);

        return replyInputWrapper;
    }

    function updateToggleRepliesLink($commentCard) {
        const $commentBody = $commentCard.is('.comment-card-body') ?
                            $commentCard :
                            $commentCard.find('.comment-card-body');

        let $toggleLink = $commentBody.find('.toggle-replies');
        let $repliesSection = $commentBody.find('.replies-section');

        if ($repliesSection.length === 0) {
            $toggleLink.remove();
            return;
        }

        // Count all replies including nested ones
        const replyCount = $repliesSection.find('.reply').length;

        console.log(`Updating toggle for comment: ${replyCount} replies`);

        if (replyCount === 0) {
            $toggleLink.remove();
            $repliesSection.remove();
            return;
        }

        if ($toggleLink.length === 0) {
            $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
            $commentBody.find('.d-flex.justify-content-between').after($toggleLink);
        }

        const isHidden = $repliesSection.is(':hidden');
        $toggleLink.text(isHidden ?
            `Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}` :
            `Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
        $toggleLink.show();
    }

    function applyViewMoreComments() {
        const $commentSection = $('#commentSection');
        const $mainComments = $commentSection.find('> .d-flex.flex-start.mb-4');
        const totalComments = $mainComments.length;
        const $viewMoreButton = $commentSection.find('.view-more-comments');

        console.log(`applyViewMoreComments called: ${totalComments} total main comments`);

        $viewMoreButton.remove();

        if (totalComments > COMMENTS_PER_PAGE) {
            console.log(`Showing ${COMMENTS_PER_PAGE} comments, hiding ${totalComments - COMMENTS_PER_PAGE}`);
            $mainComments.each(function (index) {
                const $comment = $(this);
                if (index >= COMMENTS_PER_PAGE) {
                    $comment.addClass('hidden').hide();
                } else {
                    $comment.removeClass('hidden').show();
                }
            });

            const remainingComments = totalComments - COMMENTS_PER_PAGE;
            console.log(`Adding "View More" button for ${remainingComments} remaining comments`);

            const $lastVisibleComment = $mainComments.eq(COMMENTS_PER_PAGE - 1);
            const $newViewMoreButton = $(`<a href="#" class="link-muted view-more-comments">View ${remainingComments} more comments</a>`);
            $lastVisibleComment.after($newViewMoreButton);
        } else {
            console.log("Total comments within limit, showing all comments");
            $mainComments.removeClass('hidden').show();
        }
    }

    function fetchComments() {
        console.log("Fetching comments for watchlistId:", watchlistId);
        fetch(`/comments/list/${watchlistId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to fetch comments: ${response.status}`);
                }
                return response.json();
            })
            .then(comments => {
                console.log("Comments fetched:", comments);
                const commentSection = document.getElementById("commentSection");
                commentSection.innerHTML = "";

                if (!comments || comments.length === 0) {
                    commentSection.innerHTML = '<p class="text-center text-muted">No comments yet.</p>';
                    return;
                }

                // Sort comments by date (newest first)
                comments.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

                comments.forEach(comment => {
                    const commentElement = createCommentElement(comment);
                    commentSection.appendChild(commentElement);

                    // Fetch replies for this comment
                    fetchRepliesFlat(comment.commentId, commentElement, comment.username);
                });

                applyViewMoreComments();
            })
            .catch(error => {
                console.error("Error fetching comments:", error);
            });
    }

    function fetchRepliesFlat(commentId, commentElement, commentUsername) {
        console.log(`Fetching replies for comment ID: ${commentId}`);

        let repliesSection = commentElement.querySelector('.replies-section');
        let toggleLink = commentElement.querySelector('.toggle-replies');

        if (!repliesSection) {
            toggleLink = document.createElement('a');
            toggleLink.href = '#';
            toggleLink.className = 'link-muted toggle-replies mb-2';

            const actionDiv = commentElement.querySelector('.d-flex.justify-content-between');
            actionDiv.parentNode.insertBefore(toggleLink, actionDiv.nextSibling);

            // Create replies section
            repliesSection = document.createElement('div');
            repliesSection.className = 'replies-section mt-3';
            toggleLink.parentNode.insertBefore(repliesSection, toggleLink.nextSibling);
        }

        let allReplies = [];
        const processedReplies = new Set();

        // Function to gather ALL replies (direct and nested) recursively
        async function gatherAllReplies(parentId, parentUsername) {
            try {
                const response = await fetch(`/comments/replies/${parentId}`);
                if (!response.ok) {
                    throw new Error(`Failed to fetch replies for ${parentId}: ${response.status}`);
                }

                const replies = await response.json();
                if (!replies || replies.length === 0) {
                    return;
                }

                console.log(`Found ${replies.length} direct replies to ${parentId}`);

                // First add these replies to collection
                for (const reply of replies) {
                    if (!processedReplies.has(reply.commentId)) {
                        allReplies.push({
                            reply: reply,
                            parentUsername: parentUsername,
                            nestingLevel: 1
                        });
                        processedReplies.add(reply.commentId);

                        // Recursively fetch replies to this reply
                        await gatherAllReplies(reply.commentId, reply.username);
                    }
                }
            } catch (error) {
                console.error(`Error gathering replies for ${parentId}:`, error);
            }
        }

        // Main execution flow
        async function loadAndDisplayReplies() {
            try {
                // First, gather ALL replies recursively
                await gatherAllReplies(commentId, commentUsername);

                // Sort all collected replies by date (newest first)
                allReplies.sort((a, b) => new Date(b.reply.createdAt) - new Date(a.reply.createdAt));

                console.log(`Total replies gathered for comment ${commentId}: ${allReplies.length}`);

                // Clear the replies section to avoid duplicates
                repliesSection.innerHTML = '';

                // Add all replies to the section
                for (const replyData of allReplies) {
                    const replyElement = createCommentElement(
                        replyData.reply,
                        true,
                        replyData.nestingLevel,
                        replyData.parentUsername
                    );
                    repliesSection.appendChild(replyElement);
                }

                // Update visibility of toggle link and replies section
                if (allReplies.length > 0) {
                    const replyCount = allReplies.length;
                    // Set initial visibility based on localStorage
                    const isVisible = localStorage.getItem(`reply-section-${commentId}`) === 'visible';
                    repliesSection.style.display = isVisible ? 'block' : 'none';

                    toggleLink.textContent = isVisible ?
                        `Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}` :
                        `Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`;

                    toggleLink.style.display = 'block';
                } else {
                    // No replies, hide both
                    toggleLink.style.display = 'none';
                    repliesSection.style.display = 'none';
                }
            } catch (error) {
                console.error(`Error in loadAndDisplayReplies for comment ${commentId}:`, error);
            }
        }

        // Execute the main function
        loadAndDisplayReplies();
    }

    // Like/dislike handlers
    $(document).on('click', '.like-btn, .dislike-btn', function (e) {
        e.preventDefault();
        const $actionElement = $(this);
        const action = $actionElement.data('action');
        const $comment = $actionElement.closest('[data-comment-id]');
        const id = $comment.data('comment-id');
        const url = action === 'like' ? `/comments/like/${id}` : `/comments/dislike/${id}`;

        fetch(url, { method: 'POST' })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to ${action} comment: ${response.status}`);
                }
                return response.json();
            })
            .then(updatedComment => {
                $actionElement.find(`.${action}-count`).text(updatedComment[action + 's']);
            })
            .catch(error => {
                console.error(`Error ${action}ing comment:`, error);
                alert(`Failed to ${action} comment. Please try again.`);
            });
    });

    // Only attach reply handlers if user is logged in
    if (document.querySelector(".comment-input-wrapper")) {
        // Toggle reply input form
        $(document).on('click', '.reply-btn', function (e) {
            e.preventDefault();
            const $replyBtn = $(this);
            const $actionDiv = $replyBtn.closest('.d-flex.justify-content-between');
            const $commentWithId = $replyBtn.closest('[data-comment-id]');
            const parentId = $commentWithId.attr('data-comment-id');

            console.log("Reply button clicked for comment ID:", parentId);

            if (!parentId) {
                console.error("Could not find parent comment ID");
                return;
            }

            // Check if there's already an input wrapper
            let $existingWrapper = $actionDiv.next('.reply-input-wrapper');

            if ($existingWrapper.length > 0) {
                // Toggle existing wrapper
                $existingWrapper.slideUp(300, function() {
                    $(this).remove();
                });
                return;
            }

            // Close any other open reply inputs
            $('.reply-input-wrapper').slideUp(200, function() {
                $(this).remove();
            });

            // Create new reply input wrapper
            const $replyInputWrapper = $(createReplyInputWrapper(parentId));
            $actionDiv.after($replyInputWrapper);

            // Show and focus
            $replyInputWrapper.hide().slideDown(300, function() {
                $replyInputWrapper.find('.reply-box').focus();
            });
        });

        // Post reply handler
        $(document).on('click', '.post-reply-btn', function (e) {
            e.preventDefault();
            const $button = $(this);
            const $replyInputWrapper = $button.closest('.reply-input-wrapper');
            const $replyBox = $replyInputWrapper.find('.reply-box');
            const replyText = $replyBox.val().trim();
            const parentId = $replyInputWrapper.attr('data-parent-id');

            console.log("Posting reply to parent ID:", parentId);

            if (!parentId) {
                console.error("Parent comment ID is missing");
                alert("Could not identify parent comment. Please try again.");
                return;
            }

            if (!replyText) {
                alert("Please enter a reply.");
                $replyBox.focus();
                return;
            }

            // Get the current username  and avatar from the comment input
            const username = document.querySelector(".comment-author").textContent;
            const currentUserAvatar = document.querySelector(".current-user-avatar").src;

            // Show loading state
            $button.prop('disabled', true).text('Posting...');

            fetch(`/comments/reply/${parentId}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({
                    username: username,
                    text: replyText
                })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to post reply: ${response.status}`);
                }
                return response.json();
            })
            .then(reply => {
                reply.avatarSrc = currentUserAvatar;
                // Get the clicked element's data
                const $parentElement = $replyInputWrapper.closest('[data-comment-id]');
                const username = $parentElement.find('.comment-author').text().trim();

                // Find the main comment regardless of nesting level
                const $mainComment = $parentElement.hasClass('d-flex flex-start mb-4') ?
                                  $parentElement :
                                  $parentElement.closest('.d-flex.flex-start.mb-4');

                if (!$mainComment.length) {
                    console.error("Could not find main comment");
                    return;
                }

                const mainCommentId = $mainComment.data('comment-id');

                // Get or create replies section
                let $repliesSection = $mainComment.find('.replies-section');
                let $toggleLink = $mainComment.find('.toggle-replies');

                if ($repliesSection.length === 0) {
                    // Create toggle link first
                    $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
                    $mainComment.find('.comment-card-body').find('.d-flex.justify-content-between').after($toggleLink);

                    // Create replies section
                    $repliesSection = $('<div class="replies-section mt-3"></div>');
                    $toggleLink.after($repliesSection);
                }

                // Create the new reply element with proper mention
                const newReply = createCommentElement(reply, true, 1, username);

                // Always prepend (add to beginning) for newest first order
                $repliesSection.prepend(newReply);

                // Update toggle link text
                const replyCount = $repliesSection.find('.reply').length;
                $toggleLink.text(`Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
                $toggleLink.show();

                // Show replies section and save state
                $repliesSection.show();
                localStorage.setItem(`reply-section-${mainCommentId}`, 'visible');

                // Clean up
                $replyBox.val('');
                $replyInputWrapper.slideUp(function() {
                    $(this).remove();
                });

                // Scroll to new reply
                $(newReply).hide().slideDown().get(0).scrollIntoView({ behavior: 'smooth', block: 'nearest' });

                // Reset button
                $button.prop('disabled', false).text('Reply');
            })
            .catch(error => {
                console.error("Error posting reply:", error);
                alert("Failed to post reply. Please try again.");
                $button.prop('disabled', false).text('Reply');
            });
        });
    }

    // Toggle replies visibility with localStorage
    $(document).on('click', '.toggle-replies', function (e) {
        e.preventDefault();
        const $link = $(this);
        const $repliesSection = $link.next('.replies-section');
        const $comment = $link.closest('[data-comment-id]');
        const commentId = $comment.data('comment-id');

        if (!$repliesSection.length) {
            console.error("No replies section found");
            return;
        }

        const $replies = $repliesSection.find('.reply');
        const replyCount = $replies.length;

        if (replyCount === 0) {
            $link.hide();
            return;
        }

        console.log("Toggling replies. Comment ID:", commentId, "Current visibility:", $repliesSection.is(':visible'), "Count:", replyCount);

        if ($repliesSection.is(':visible')) {
            // Hide replies
            $repliesSection.slideUp(200, function() {
                $link.text(`Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
                // Store toggle state
                localStorage.setItem(`reply-section-${commentId}`, 'hidden');
            });
        } else {
            // Show replies
            $repliesSection.slideDown(200, function() {
                $link.text(`Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
                // Store toggle state
                localStorage.setItem(`reply-section-${commentId}`, 'visible');
            });
        }
    });

    // View more comments
    $(document).on('click', '.view-more-comments', function (e) {
        e.preventDefault();
        const $button = $(this);
        const $commentSection = $('#commentSection');
        const $hiddenComments = $commentSection.find('.d-flex.flex-start.mb-4.hidden');

        console.log("View More Comments clicked, showing", $hiddenComments.length, "hidden comments");

        $hiddenComments.removeClass('hidden').slideDown({
            duration: 300,
            complete: function () {
                $button.remove();
            }
        });
    });

    // Post new comment - only define if user is logged in
    if (document.querySelector(".comment-input-wrapper")) {
        window.postComment = function () {
            try {
                const commentBox = document.getElementById("commentBox");
                if (!commentBox) {
                    throw new Error("Comment box element not found.");
                }

                const commentText = commentBox.value.trim();
                if (!commentText) {
                    alert("Please enter a comment.");
                    commentBox.focus();
                    return;
                }

                const username = document.querySelector(".comment-author").textContent;
                const currentUserAvatar = document.querySelector(".current-user-avatar").src;
                const url = `/comments/add/${watchlistId}`;

                fetch(url, {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: new URLSearchParams({ username: username, text: commentText })
                })
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => {
                            throw new Error(`Failed to post comment: ${response.status} ${text}`);
                        });
                    }
                    return response.json();
                })
                .then(comment => {
                    console.log("Comment posted:", comment);
                    commentBox.value = "";
                    const commentSection = document.getElementById("commentSection");
                    comment.avatarSrc = currentUserAvatar;
                    const newComment = createCommentElement(comment);
                    if (commentSection.firstChild) {
                        commentSection.insertBefore(newComment, commentSection.firstChild);
                    } else {
                        commentSection.appendChild(newComment);
                    }
                    newComment.scrollIntoView({ behavior: "smooth", block: "nearest" });
                    applyViewMoreComments();
                })
                .catch(error => {
                    console.error("Error posting comment:", error);
                    alert("Failed to post comment. Please try again.");
                });
            } catch (error) {
                console.error("Error posting comment:", error.message);
                alert("An error occurred while posting your comment. Please try again.");
            }
        };
    }

    setTimeout(function() {
        if (typeof fetchComments === 'function' && $('.comment-sorting-controls').length === 0) {
          console.log("Initializing comment sorting controls...");
          fetchComments();
        }
      }, 500);


    const originalFetchComments = fetchComments;
    const originalPostComment = window.postComment;

    let currentSortType = "newest"; // Default sort type
    let commentsCache = []; // To store all comments for easy re-sorting

    function createSortingControls() {
        $('.comments-header').remove();

        const headerHTML = `
            <div class="comments-header">
                <div class="comments-title">
                    <i class="far fa-comment-alt"></i>
                    <h5>Comments</h5>
                </div>
                <div class="sort-controls">
                    <span>Sort by:</span>
                    <div class="sort-buttons">
                        <button type="button" class="sort-btn active" data-sort="newest">Newest</button>
                        <button type="button" class="sort-btn" data-sort="oldest">Oldest</button>
                        <button type="button" class="sort-btn" data-sort="top">Top</button>
                    </div>
                </div>
            </div>
        `;

        const styles = `
            <style>
                .comments-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 35px;
                    width: 100%;
                    margin-top: 30px;
                    color: white;
                }

                .comments-title {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .comments-title i {
                    font-size: 1.2rem;
                    color: white;
                }

                .comments-title h5 {
                    margin: 0;
                    font-size: 1.2rem;
                    font-weight: 600;
                    color: white;
                }

                .sort-controls {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .sort-controls span {
                    color: white;
                    font-size: 0.9rem;
                }

                .sort-buttons {
                    display: flex;
                    gap: 5px;
                }

                .sort-btn {
                    background-color: rgba(44, 62, 80, 0.5);
                    color: white;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    transition: all 0.2s ease;
                    font-size: 0.8rem;
                    padding: 4px 10px;
                    border-radius: 4px;
                    cursor: pointer;
                }

                .sort-btn:hover {
                    background-color: rgba(52, 152, 219, 0.3);
                    color: white;
                }

                .sort-btn.active {
                    background: linear-gradient(135deg, #3498db, #2980b9);
                    color: white;
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    box-shadow: 0 2px 8px rgba(52, 152, 219, 0.4);
                }

                @media (max-width: 576px) {
                    .comments-header {
                        flex-direction: column;
                        align-items: flex-start;
                    }

                    .sort-controls {
                        margin-top: 10px;
                        width: 100%;
                    }
                }
            </style>
        `;

        $('head style:contains("comments-header")').remove();
        $('head').append(styles);

        // Find the existing comment section header to hide
        const existingHeader = $('h5:contains("Comments"), span:contains("Comments"), .comment-heading, div:contains("Comments")').filter(function() {
            // This is to only match if this is a text node or heading directly containing "Comments"
            return $(this).clone().children().remove().end().text().trim() === "Comments";
        });

        // Also to find any comment icon to hide
        const commentIcon = $('.fa-comment, .fa-comment-alt, .far.fa-comment-alt');

        // Hide the original elements without removing them
        if (existingHeader.length > 0) {
            existingHeader.hide();
        }
        if (commentIcon.length > 0) {
            commentIcon.hide();
        }

        const commentBox = $('.comment-input-wrapper, .comment-box-container, textarea[placeholder*="comment"], textarea[placeholder*="Leave a comment"]').closest('div.row, div.comment-section, div.container');
        const loginBanner = $('.login-banner, .comment-login, .login-prompt, div:contains("Please log in to leave a comment")');
        const commentSection = $('#commentSection');

        // Determines where to insert sort/comment header
        if (commentSection.length > 0) {
            const animeCards = $('.anime-card, .anime-box, .card').last();

            if (animeCards.length > 0) {
                // If anime cards are present, insert after the last one
                animeCards.closest('.row, .container').after(headerHTML);
            } else {
                // Otherwise insert before any login banner or comment box
                if (loginBanner.length > 0) {
                    loginBanner.before(headerHTML);
                } else if (commentBox.length > 0) {
                    commentBox.before(headerHTML);
                } else {
                    commentSection.before(headerHTML);
                }
            }
        } else {
            // If no comment section, try to find a logical place based on page structure
            const content = $('.content, main, #main-content').first();
            if (content.length > 0) {
                // Find any element that might contain "Comments" text
                const possibleHeaders = content.find('h1, h2, h3, h4, h5, h6, div').filter(function() {
                    return $(this).text().includes('Comments');
                });

                if (possibleHeaders.length > 0) {
                    possibleHeaders.first().replaceWith(headerHTML);
                } else {
                    content.append(headerHTML);
                }
            } else {
                // Last resort - add to body
                $('body').append(headerHTML);
            }
        }

        // Add event listeners for the sort buttons
        $('.sort-btn').off('click').on('click', function() {
            const sortType = $(this).data('sort');
            if (sortType === currentSortType) return; // Skip if already sorted this way

            // Update active button
            $('.sort-btn').removeClass('active');
            $(this).addClass('active');

            // Update current sort type
            currentSortType = sortType;

            // Sort and redisplay comments
            sortAndDisplayComments(sortType);
        });
    }

    // Sort and display comments function
    function sortAndDisplayComments(sortType) {
        if (!commentsCache || commentsCache.length === 0) {
            const commentSection = document.getElementById("commentSection");
            commentSection.innerHTML = '<p class="text-center text-muted">No comments yet.</p>';
            return;
        }

        // Clone the comments array to avoid modifying the cache
        const sortedComments = [...commentsCache];

        // Sort based on selected type
        switch (sortType) {
            case "newest":
                sortedComments.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
                break;
            case "oldest":
                sortedComments.sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));
                break;
            case "top":
                sortedComments.sort((a, b) => (b.likes || 0) - (a.likes || 0));
                break;
            default:
                sortedComments.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
        }

        // Display sorted comments
        const commentSection = document.getElementById("commentSection");
        commentSection.innerHTML = "";

        sortedComments.forEach(comment => {
            const commentElement = createCommentElement(comment);
            commentSection.appendChild(commentElement);

            // Fetch replies for this comment
            fetchRepliesFlat(comment.commentId, commentElement, comment.username);
        });

        // Apply paging (limit visible comments)
        applyViewMoreComments();

        // Add animation class to all comments
        $("#commentSection > div").addClass("comment-sort-fade");
    }

    // Override the fetchComments function
    fetchComments = function() {
        console.log("Fetching comments for watchlistId:", watchlistId);
        fetch(`/comments/list/${watchlistId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to fetch comments: ${response.status}`);
                }
                return response.json();
            })
            .then(comments => {
                console.log("Comments fetched:", comments);

                // Store comments in the cache
                commentsCache = comments || [];

                // Create sorting controls if they don't exist
                if ($(".comment-sorting-controls").length === 0) {
                    createSortingControls();

                    // Add click event for sorting buttons
                    $(document).on("click", ".sort-btn", function() {
                        const sortType = $(this).data("sort");
                        if (sortType === currentSortType) return; // Skip if already sorted this way

                        // Update active button
                        $(".sort-btn").removeClass("active");
                        $(this).addClass("active");

                        // Update current sort type
                        currentSortType = sortType;

                        // Sort and redisplay comments
                        sortAndDisplayComments(sortType);
                    });
                }

                // Sort and display based on current sort type
                sortAndDisplayComments(currentSortType);
            })
            .catch(error => {
                console.error("Error fetching comments:", error);
                const commentSection = document.getElementById("commentSection");
                commentSection.innerHTML = '<p class="text-center text-danger">Failed to load comments. Please try again later.</p>';
            });
    };

    // Override the postComment function
    if (originalPostComment) {
        window.postComment = function() {
            try {
                const commentBox = document.getElementById("commentBox");
                if (!commentBox) {
                    throw new Error("Comment box element not found.");
                }

                const commentText = commentBox.value.trim();
                if (!commentText) {
                    alert("Please enter a comment.");
                    commentBox.focus();
                    return;
                }

                const username = document.querySelector(".comment-author").textContent;
                const currentUserAvatar = document.querySelector(".current-user-avatar").src;
                const url = `/comments/add/${watchlistId}`;

                fetch(url, {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: new URLSearchParams({ username: username, text: commentText })
                })
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => {
                            throw new Error(`Failed to post comment: ${response.status} ${text}`);
                        });
                    }
                    return response.json();
                })
                .then(comment => {
                    console.log("Comment posted:", comment);
                    commentBox.value = "";

                    // Add new comment to cache
                    comment.avatarSrc = currentUserAvatar;
                    commentsCache.unshift(comment);

                    // Re-sort and display comments
                    sortAndDisplayComments(currentSortType);

                    // Scroll to the new comment if it's visible
                    if (currentSortType === "newest") {
                        const firstComment = document.querySelector(".d-flex.flex-start.mb-4");
                        if (firstComment) {
                            firstComment.scrollIntoView({ behavior: "smooth", block: "nearest" });
                        }
                    }
                })
                .catch(error => {
                    console.error("Error posting comment:", error);
                    alert("Failed to post comment. Please try again.");
                });
            } catch (error) {
                console.error("Error posting comment:", error.message);
                alert("An error occurred while posting your comment. Please try again.");
            }
        };
    }

    // Extend the existing like/dislike handlers to update the sorting if in "top" mode
    const originalLikeDislikeHandler = $._data($(document)[0], "events").click.find(
        handler => handler.selector === '.like-btn, .dislike-btn'
    );

    if (originalLikeDislikeHandler) {
        $(document).off('click', '.like-btn, .dislike-btn');

        $(document).on('click', '.like-btn, .dislike-btn', function (e) {
            e.preventDefault();
            const $actionElement = $(this);
            const action = $actionElement.data('action');
            const $comment = $actionElement.closest('[data-comment-id]');
            const id = $comment.data('comment-id');
            const url = action === 'like' ? `/comments/like/${id}` : `/comments/dislike/${id}`;

            fetch(url, { method: 'POST' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Failed to ${action} comment: ${response.status}`);
                    }
                    return response.json();
                })
                .then(updatedComment => {
                    $actionElement.find(`.${action}-count`).text(updatedComment[action + 's']);

                    // Update comment in the cache
                    const commentIndex = commentsCache.findIndex(c => c.commentId === id);
                    if (commentIndex !== -1) {
                        commentsCache[commentIndex][action + 's'] = updatedComment[action + 's'];

                        // If current sort is "top", re-sort the comments
                        if (currentSortType === "top") {
                            sortAndDisplayComments("top");
                        }
                    }
                })
                .catch(error => {
                    console.error(`Error ${action}ing comment:`, error);
                    alert(`Failed to ${action} comment. Please try again.`);
                });
        });
    }
});