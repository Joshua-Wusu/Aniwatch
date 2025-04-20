document.addEventListener('DOMContentLoaded', function() {
  // Get references to modal elements
  const loginModal = document.getElementById('loginModal');
  const userRegisterModal = document.getElementById('userRegisterModal');
  const providerRegisterModal = document.getElementById('providerRegisterModal');
  
  // Get references to modal instances
  let loginModalInstance, userRegisterModalInstance, providerRegisterModalInstance;
  
  if (loginModal) {
    loginModalInstance = new bootstrap.Modal(loginModal);
    
    // Handle login form submission
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
      loginForm.addEventListener('submit', function(event) {
        // anymore login validation can be added here
      });
    }
  }
  
  if (userRegisterModal) {
    userRegisterModalInstance = new bootstrap.Modal(userRegisterModal);
    
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
    
    const providerRegisterForm = document.getElementById('providerRegisterForm');
    if (providerRegisterForm) {
      providerRegisterForm.addEventListener('submit', function(event) {
        const password = document.getElementById('providerRegisterPassword').value;
        const confirmPassword = document.getElementById('providerRegisterConfirmPassword').value;
        const errorAlert = document.getElementById('providerRegisterErrorAlert');
        
        errorAlert.classList.add('d-none');
        
        if (password.length < 8) {
          event.preventDefault();
          errorAlert.textContent = 'Password must be at least 8 characters long.';
          errorAlert.classList.remove('d-none');
          return false;
        }
        
        if (password !== confirmPassword) {
          event.preventDefault();
          errorAlert.textContent = 'Passwords do not match.';
          errorAlert.classList.remove('d-none');
          return false;
        }
        
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
  
  const urlParams = new URLSearchParams(window.location.search);
  
  if (urlParams.has('error') && loginModalInstance) {
    const loginErrorAlert = document.getElementById('loginErrorAlert');
    if (loginErrorAlert) loginErrorAlert.classList.remove('d-none');
    loginModalInstance.show();
  }
  
  if (urlParams.has('registered') && loginModalInstance) {
    const registrationSuccessAlert = document.getElementById('registrationSuccessAlert');
    if (registrationSuccessAlert) registrationSuccessAlert.classList.remove('d-none');
    loginModalInstance.show();
  }
  
  if (urlParams.has('registrationError')) {
    const errorType = urlParams.get('registrationError');
    const errorMessage = urlParams.get('message') || 'Registration failed. Please try again.';
    
    if (errorType === 'user' && userRegisterModalInstance) {
      const errorAlert = document.getElementById('userRegisterErrorAlert');
      if (errorAlert) {
        errorAlert.textContent = errorMessage.replace(/\+/g, ' ');
        errorAlert.classList.remove('d-none');
      }
      userRegisterModalInstance.show();
    } else if (errorType === 'provider' && providerRegisterModalInstance) {
      const errorAlert = document.getElementById('providerRegisterErrorAlert');
      if (errorAlert) {
        errorAlert.textContent = errorMessage.replace(/\+/g, ' ');
        errorAlert.classList.remove('d-none');
      }
      providerRegisterModalInstance.show();
    }
  }
  
  // Shows the modal instead of navigating
  const loginLinks = document.querySelectorAll('a[href="/login"], a[href="/login.html"]');
  loginLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      if (loginModalInstance) loginModalInstance.show();
    });
  });
});