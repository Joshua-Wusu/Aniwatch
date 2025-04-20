<#macro authModals>
<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">Login</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="loginErrorAlert" class="alert alert-danger <#if loginError?? && loginError>d-block<#else>d-none</#if>">
          Invalid username or password.
        </div>
        <div id="registrationSuccessAlert" class="alert alert-success <#if registered?? && registered>d-block<#else>d-none</#if>">
          Registration successful! Please login.
        </div>
        <form id="loginForm" method="post" action="/login">
          <div class="mb-3">
            <label for="loginUsername" class="form-label">USERNAME</label>
            <input type="text" class="form-control" id="loginUsername" name="username" required>
          </div>
          <div class="mb-4">
            <label for="loginPassword" class="form-label">PASSWORD</label>
            <input type="password" class="form-control" id="loginPassword" name="password" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary-modal">Login</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <p>Don't have an account?</p>
        <div class="registration-options">
          <button class="registration-option switch-to-user-register">Register as User</button>
          <button class="registration-option switch-to-provider-register">Register as Provider</button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- User Registration Modal -->
<div class="modal fade" id="userRegisterModal" tabindex="-1" aria-labelledby="userRegisterModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="userRegisterModalLabel">Create User Account</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="userRegisterErrorAlert" class="alert alert-danger <#if registerErrorMessage?? && showUserRegisterModal??>d-block<#else>d-none</#if>">
          ${registerErrorMessage!'Error message will appear here'}
        </div>
        <form id="userRegisterForm" method="post" action="/register/user">
          <div class="mb-3">
            <label for="userRegisterUsername" class="form-label">USERNAME</label>
            <input type="text" class="form-control" id="userRegisterUsername" name="username" required>
          </div>
          <div class="mb-3">
            <label for="userRegisterPassword" class="form-label">PASSWORD</label>
            <input type="password" class="form-control" id="userRegisterPassword" name="password" required>
            <div class="form-text">Password must be at least 8 characters long</div>
          </div>
          <div class="mb-4">
            <label for="userRegisterConfirmPassword" class="form-label">CONFIRM PASSWORD</label>
            <input type="password" class="form-control" id="userRegisterConfirmPassword" name="confirmPassword" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary-modal">Create Account</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <p>Already have an account? <a href="#" class="switch-to-login">Login</a></p>
      </div>
    </div>
  </div>
</div>

<!-- Provider Registration Modal -->
<div class="modal fade" id="providerRegisterModal" tabindex="-1" aria-labelledby="providerRegisterModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="providerRegisterModalLabel">Create Provider Account</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="providerRegisterErrorAlert" class="alert alert-danger <#if registerErrorMessage?? && showProviderRegisterModal??>d-block<#else>d-none</#if>">
          ${registerErrorMessage!'Error message will appear here'}
        </div>
        <form id="providerRegisterForm" method="post" action="/register/provider" enctype="multipart/form-data">
          <div class="mb-3">
            <label for="providerRegisterUsername" class="form-label">USERNAME</label>
            <input type="text" class="form-control" id="providerRegisterUsername" name="providerUsername" required>
          </div>
          <div class="mb-3">
            <label for="providerRegisterEmail" class="form-label">EMAIL ADDRESS</label>
            <input type="email" class="form-control" id="providerRegisterEmail" name="providerEmail" required>
          </div>
          <div class="mb-3">
            <label for="providerRegisterPassword" class="form-label">PASSWORD</label>
            <input type="password" class="form-control" id="providerRegisterPassword" name="password" required>
            <div class="form-text">Password must be at least 8 characters long</div>
          </div>
          <div class="mb-4">
            <label for="providerRegisterConfirmPassword" class="form-label">CONFIRM PASSWORD</label>
            <input type="password" class="form-control" id="providerRegisterConfirmPassword" name="confirmPassword" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary-modal">Create Provider Account</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <p>Already have an account? <a href="#" class="switch-to-login">Login</a></p>
      </div>
    </div>
  </div>
</div>

<!-- Auth modals CSS -->
<style>
        .modal-content {
          background-color: #1a1a1a!important;
          border: none!important;
          border-radius: 10px!important;
          box-shadow: 0 0 30px rgba(0, 0, 0, 0.6)!important;
        }

        .modal-header, .modal-footer {
          border: none!important;
          padding: 20px 24px!important;
        }

        .modal-header .modal-title {
          font-size: 24px!important;
          font-weight: 600!important;
          color: #fff!important;
        }

        .modal-body {
          padding: 20px 24px!important;
        }

        .form-label {
          font-size: 14px!important;
          font-weight: 500!important;
          color: #aaa!important;
          text-transform: uppercase!important;
          letter-spacing: 1px!important;
          margin-bottom: 8px!important;
        }

        .form-control {
              border: none!important;
              border-radius: 6px!important;
              font-size: 16px!important;
              padding: 12px 16px!important;
              height: auto!important;
            }

            .form-control:focus {
              box-shadow: 0 0 0 3px rgba(79, 166, 255, 0.25)!important;
            }

        .form-text {
            margin-top: .25rem!important;
            font-size: .8em!important;
            color: white!important;
        }

        .btn-primary-modal {
          background: linear-gradient(135deg, #4299e1, #3182ce)!important;
          border: none!important;
          border-radius: 6px!important;
          color: white!important;
          font-weight: 600!important;
          padding: 12px 0!important;
          transition: all 0.2s!important;
          margin: 0px!important;
        }

        .btn-primary-modal:hover {
          background: linear-gradient(135deg, #3182ce, #2b6cb0)!important;
          transform: translateY(-1px)!important;
        }

        .modal-footer {
          justify-content: center!important;
          background-color: #1a1a1a!important;
        }

        .modal-footer a {
          color: #4299e1!important;
          text-decoration: none!important;
        }

        .modal-footer a:hover {
          text-decoration: underline!important;
        }

        /* Registration options */
        .registration-options {
          display: flex!important;
          gap: 10px!important;
          justify-content: center!important;
          margin-top: 10px!important;
        }

        .registration-option {
          background-color: #2c2c2c!important;
          border: none!important;
          border-radius: 6px!important;
          color: #fff!important;
          font-weight: 500!important;
          padding: 10px 16px!important;
          transition: all 0.2s!important;
        }

        .registration-option:hover {
          background-color: #3a3a3a!important;
        }

.alert {
  border-radius: 6px;
  padding: 12px 16px;
  margin-bottom: 20px;
}

.btn-close-white {
  filter: invert(1) grayscale(100%) brightness(200%);
}
</style>

<!-- Auth modals JavaScript -->
<script>
document.addEventListener('DOMContentLoaded', function() {
  // Get references to modal elements
  const loginModal = document.getElementById('loginModal');
  const userRegisterModal = document.getElementById('userRegisterModal');
  const providerRegisterModal = document.getElementById('providerRegisterModal');

  // Get references to modal instances
  let loginModalInstance, userRegisterModalInstance, providerRegisterModalInstance;

  if (loginModal) {
    loginModalInstance = new bootstrap.Modal(loginModal);

    // Check if we should show login modal
    <#if showLoginModal?? && showLoginModal>
      loginModalInstance.show();
    </#if>

    // Handle login form submission
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
      loginForm.addEventListener('submit', function(event) {
        // You can add additional client-side validation here if needed
      });
    }
  }

  if (userRegisterModal) {
    userRegisterModalInstance = new bootstrap.Modal(userRegisterModal);

    // Check if we should show user register modal
    <#if showUserRegisterModal?? && showUserRegisterModal>
      userRegisterModalInstance.show();
    </#if>

    // Handle user registration form validation
    const userRegisterForm = document.getElementById('userRegisterForm');
    if (userRegisterForm) {
      userRegisterForm.addEventListener('submit', function(event) {
        const password = document.getElementById('userRegisterPassword').value;
        const confirmPassword = document.getElementById('userRegisterConfirmPassword').value;
        const errorAlert = document.getElementById('userRegisterErrorAlert');

        // Reset error message
        errorAlert.classList.add('d-none');

        // Validate password length
        if (password.length < 8) {
          event.preventDefault();
          errorAlert.textContent = 'Password must be at least 8 characters long.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        // Validate password match
        if (password !== confirmPassword) {
          event.preventDefault();
          errorAlert.textContent = 'Passwords do not match.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        // All validations passed
        return true;
      });
    }
  }

  if (providerRegisterModal) {
    providerRegisterModalInstance = new bootstrap.Modal(providerRegisterModal);

    // Check if we should show provider register modal
    <#if showProviderRegisterModal?? && showProviderRegisterModal>
      providerRegisterModalInstance.show();
    </#if>

    // Handle provider registration form validation
    const providerRegisterForm = document.getElementById('providerRegisterForm');
    if (providerRegisterForm) {
      providerRegisterForm.addEventListener('submit', function(event) {
        const password = document.getElementById('providerRegisterPassword').value;
        const confirmPassword = document.getElementById('providerRegisterConfirmPassword').value;
        const errorAlert = document.getElementById('providerRegisterErrorAlert');

        // Reset error message
        errorAlert.classList.add('d-none');

        // Validate password length
        if (password.length < 8) {
          event.preventDefault();
          errorAlert.textContent = 'Password must be at least 8 characters long.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        // Validate password match
        if (password !== confirmPassword) {
          event.preventDefault();
          errorAlert.textContent = 'Passwords do not match.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        // All validations passed
        return true;
      });
    }
  }

  // Handle switching from login to user registration
  const switchToUserRegisterButtons = document.querySelectorAll('.switch-to-user-register');
  switchToUserRegisterButtons.forEach(button => {
    button.addEventListener('click', function() {
      if (loginModalInstance) loginModalInstance.hide();
      if (userRegisterModalInstance) setTimeout(() => userRegisterModalInstance.show(), 500);
    });
  });

  // Handle switching from login to provider registration
  const switchToProviderRegisterButtons = document.querySelectorAll('.switch-to-provider-register');
  switchToProviderRegisterButtons.forEach(button => {
    button.addEventListener('click', function() {
      if (loginModalInstance) loginModalInstance.hide();
      if (providerRegisterModalInstance) setTimeout(() => providerRegisterModalInstance.show(), 500);
    });
  });

  // Handle switching from registration back to login
  const switchToLoginButtons = document.querySelectorAll('.switch-to-login');
  switchToLoginButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      if (userRegisterModalInstance) userRegisterModalInstance.hide();
      if (providerRegisterModalInstance) providerRegisterModalInstance.hide();
      if (loginModalInstance) setTimeout(() => loginModalInstance.show(), 500);
    });
  });

  // Update the navigation login link to show the modal instead of navigating
  const loginLinks = document.querySelectorAll('a[href="/login"], a[href="/login.html"]');
  loginLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      if (loginModalInstance) loginModalInstance.show();
    });
  });

  // Clean URL parameters after processing to prevent modal from showing on refresh
  function cleanUrlParameters() {
    if (window.location.search) {
      const url = new URL(window.location.href);

      // Check if we're showing modals
      const showLoginModal = url.searchParams.get('showLoginModal');
      const loginError = url.searchParams.get('loginError');
      const registered = url.searchParams.get('registered');

      if (showLoginModal || loginError || registered) {
        // Remove parameters and replace current history state
        url.searchParams.delete('showLoginModal');
        url.searchParams.delete('loginError');
        url.searchParams.delete('registered');

        window.history.replaceState({}, document.title, url.toString());
      }
    }
  }

  // Call this function after modals are shown
  cleanUrlParameters();

  // Ensure modals can be properly closed
  if (loginModal) {
    // Direct event handler for the login modal close button
    const loginModalCloseBtn = loginModal.querySelector('.btn-close');
    if (loginModalCloseBtn) {
      loginModalCloseBtn.addEventListener('click', function(e) {
        e.preventDefault();
        // Get or create the modal instance and force hide it
        if (loginModalInstance) {
          loginModalInstance.hide();
        } else {
          const newModalInstance = new bootstrap.Modal(loginModal);
          newModalInstance.hide();
        }
      });
    }
  }

  if (loginModal) {
    // Listen for the hidden.bs.modal event which fires after the modal is completely hidden
    loginModal.addEventListener('hidden.bs.modal', function() {
      // Clear any error messages
      const loginErrorAlert = document.getElementById('loginErrorAlert');
      if (loginErrorAlert) {
        loginErrorAlert.classList.add('d-none');
      }

      // Optionally, also clear the form fields
      const usernameField = document.getElementById('loginUsername');
      const passwordField = document.getElementById('loginPassword');

      if (usernameField) usernameField.value = '';
      if (passwordField) passwordField.value = '';
    });
  }

  if (userRegisterModal) {
    userRegisterModal.addEventListener('hide.bs.modal', function() {
      // Clean up any form fields or error messages if needed
      const errorAlert = document.getElementById('userRegisterErrorAlert');
      if (errorAlert) {
        errorAlert.classList.add('d-none');
      }
    });
  }

  if (providerRegisterModal) {
    providerRegisterModal.addEventListener('hide.bs.modal', function() {
      // Clean up any form fields or error messages if needed
      const errorAlert = document.getElementById('providerRegisterErrorAlert');
      if (errorAlert) {
        errorAlert.classList.add('d-none');
      }
    });
  }
});
</script>
</#macro>