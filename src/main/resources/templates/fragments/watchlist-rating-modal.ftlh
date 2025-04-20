<#macro watchlistRatingModal>

<!-- Rating Modal -->
<div id="watchlistRatingModal" class="wl-rating-modal">
  <div class="wl-rating-modal-content">
    <span class="wl-rating-close">&times;</span>
    <div class="wl-rating-inner">
      <h2 class="wl-rate-title">Rate this Watchlist</h2>
      <p class="wl-rate-subtitle">Select 1 to 5 stars to rate</p>

      <!-- Star Rating Area -->
      <div class="wl-stars-container">
        <div class="wl-star-rating">
          <input type="radio" id="wl-star5" name="wl-rating" value="5" /><label for="wl-star5" title="5 stars">☆</label>
          <input type="radio" id="wl-star4" name="wl-rating" value="4" /><label for="wl-star4" title="4 stars">☆</label>
          <input type="radio" id="wl-star3" name="wl-rating" value="3" /><label for="wl-star3" title="3 stars">☆</label>
          <input type="radio" id="wl-star2" name="wl-rating" value="2" /><label for="wl-star2" title="2 stars">☆</label>
          <input type="radio" id="wl-star1" name="wl-rating" value="1" checked /><label for="wl-star1" title="1 star">☆</label>
        </div>
      </div>

      <!-- Message Container (always present, but initially empty) -->
      <div id="wl-rating-message" class="wl-rating-message"></div>

      <!-- Button Container -->
      <div class="wl-submit-container">
        <button id="wl-submit-rating-btn" class="wl-submit-btn">Submit Rating</button>
      </div>
    </div>
  </div>
</div>

<style>
/* Rating Modal - Renamed to avoid conflicts */
.wl-rating-modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(5px);
  align-items: center;
  justify-content: center;
}

.wl-rating-modal-content {
  background: linear-gradient(135deg, rgba(44, 62, 80, 0.9) 0%, rgba(52, 73, 94, 0.9) 100%);
  border-radius: 15px;
  width: 90%;
  max-width: 500px;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
  overflow: hidden;
}

.wl-rating-inner {
  padding: 30px;
  display: flex;
  flex-direction: column;
  min-height: 300px; /* Fixed height to prevent layout shifts */
}

.wl-rating-close {
  position: absolute;
  top: 15px;
  right: 20px;
  color: var(--text-muted, #bdc3c7);
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s;
  z-index: 10;
}

.wl-rating-close:hover {
  color: var(--text-light, #ecf0f1);
}

.wl-rate-title {
  font-size: 24px;
  font-weight: 600;
  margin-bottom: 15px;
  text-align: center;
  background: linear-gradient(90deg, #3498db, #9b59b6);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.wl-rate-subtitle {
  text-align: center;
  margin-bottom: 25px;
  color: var(--text-muted, #bdc3c7);
}

.wl-stars-container {
  display: flex;
  justify-content: center;
  margin-bottom: 25px;
}

.wl-star-rating {
  display: flex;
  justify-content: center;
  direction: rtl;
  border: none;
  padding: 0;
}

.wl-star-rating input {
  display: none;
}

.wl-star-rating label {
  cursor: pointer;
  font-size: 30px;
  color: var(--text-muted, #bdc3c7);
  padding: 0 5px;
  transition: all 0.3s;
}

.wl-star-rating label:hover,
.wl-star-rating label:hover ~ label,
.wl-star-rating input:checked ~ label {
  color: var(--warning, #f1c40f);
}

.wl-rating-message {
  text-align: center;
  font-weight: 500;
  min-height: 60px; /* Fixed height for message */
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  padding: 10px;
  width: 100%;
  font-size: 16px;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.wl-rating-message.wl-show {
  opacity: 1;
}

.wl-rating-message.wl-success {
  color: #2ecc71;
}

.wl-rating-message.wl-error {
  color: #e74c3c;
}

.wl-submit-container {
  width: 100%;
  margin-top: auto; /* Push to bottom of container */
}

.wl-submit-btn {
  display: block;
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #3498db, #2980b9);
  color: white;
  border: none;
  border-radius: 30px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.wl-submit-btn:hover {
  background: linear-gradient(135deg, #2980b9, #3498db);
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
}

.wl-submit-btn:disabled {
  opacity: 0.7;
  transform: none;
  cursor: not-allowed;
}

@keyframes wl-spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.wl-loading-spinner {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 3px solid rgba(255,255,255,0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: wl-spin 1s ease-in-out infinite;
  margin-right: 8px;
  vertical-align: middle;
}
</style>

<script>
<#noparse>
document.addEventListener("DOMContentLoaded", function () {
  // Get elements - all renamed to avoid conflicts
  const rateButton = document.getElementById("rateButton");
  const modal = document.getElementById("watchlistRatingModal");
  const closeBtn = document.querySelector(".wl-rating-close");
  const submitBtn = document.getElementById("wl-submit-rating-btn");
  const messageContainer = document.getElementById("wl-rating-message");
  const starInputs = document.querySelectorAll('input[name="wl-rating"]');

  // Check if elements exist
  if (!rateButton || !modal || !closeBtn || !submitBtn || !messageContainer) {
    console.error("Required rating modal elements not found");
    return;
  }

  // Open modal
  rateButton.addEventListener("click", function() {
    modal.style.display = "flex";
    resetModal();
  });

  // Close modal when clicking X
  closeBtn.addEventListener("click", function() {
    modal.style.display = "none";
  });

  // Close modal when clicking outside
  window.addEventListener("click", function(event) {
    if (event.target === modal) {
      modal.style.display = "none";
    }
  });

  // Submit rating
  submitBtn.addEventListener("click", function() {
    const selectedRating = document.querySelector('input[name="wl-rating"]:checked');
    if (!selectedRating) {
      showMessage("Please select a rating", "wl-error");
      return;
    }

    const rating = selectedRating.value;
    submitRating(rating);
  });

  // Function to submit rating
  function submitRating(rating) {
    // Show loading state
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="wl-loading-spinner"></span> Submitting...';

    // Clear any existing message
    messageContainer.textContent = "";
    messageContainer.classList.remove("wl-show", "wl-success", "wl-error");

    fetch(`/watchlists/${watchlistId}/rate`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        rating: rating
      })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then(data => {
      // Update displayed rating on the page
      updateDisplayedRating(data.rating);

      // Show success message
      showMessage(`Thank you for rating this watchlist ${rating} star(s)!`, "wl-success");

      // Reset button
      submitBtn.disabled = false;
      submitBtn.innerHTML = "Submit Rating";

      // Close modal after delay
      setTimeout(() => {
        modal.style.display = "none";
      }, 2000);
    })
    .catch(error => {
      console.error("Error submitting rating:", error);
      showMessage("Error submitting rating. Please try again.", "wl-error");

      // Reset button
      submitBtn.disabled = false;
      submitBtn.innerHTML = "Submit Rating";
    });
  }

  // Function to update displayed rating on page
  function updateDisplayedRating(newRating) {
    const ratingStarsElement = document.querySelector('.five-star-rating');
    const ratingTextElement = document.querySelector('.rating-display span:nth-child(2)');

    if (ratingStarsElement) {
      const stars = Math.round(newRating);
      const starRating = "★".repeat(stars) + "☆".repeat(5 - stars);
      ratingStarsElement.textContent = starRating;
    }

    if (ratingTextElement) {
      ratingTextElement.textContent = `(${newRating.toFixed(1)}/5)`;
    }
  }

  // Function to show message
  function showMessage(text, type) {
    messageContainer.textContent = text;
    messageContainer.classList.add("wl-show", type);
  }

  // Function to reset modal state
  function resetModal() {
    // Reset radio buttons
    starInputs.forEach(input => {
      input.checked = false;
    });

    // Clear message
    messageContainer.textContent = "";
    messageContainer.classList.remove("wl-show", "wl-success", "wl-error");

    // Reset button
    submitBtn.disabled = false;
    submitBtn.innerHTML = "Submit Rating";
  }
});
</#noparse>
</script>
</#macro>