package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/register")
public class RegistrationController {

    @Autowired
    private ProviderService providerService;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/provider")
    public String showProviderRegistrationForm(Model model) {
        model.addAttribute("provider", new Provider());
        return "register-provider";
    }

    @PostMapping("/provider")
    public String registerProvider(
            @ModelAttribute Provider provider,
            @RequestParam String password,
            @RequestParam(required = false) MultipartFile profileImage,
            RedirectAttributes redirectAttributes) {

        try {
            System.out.println("Starting provider registration for username: " + provider.getProviderUsername());

            // Another check for if username already exists
            if (userService.findByUsername(provider.getProviderUsername()).isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Username already exists");
                return "redirect:/?registrationError=provider&message=Username+already+exists";
            }

            // Create and save the provider
            Long providerId = providerService.createProvider(provider, profileImage);
            System.out.println("Provider created with the ID: " + providerId);

            // Create user with provider role
            User user = userService.registerProviderUser(provider.getProviderUsername(), password, providerId);
            System.out.println("User created with the ID: " + user.getId());

            return "redirect:/?registered=true";
        } catch (Exception e) {
            System.err.println("Oh no, I encountered an error during provider registration: " + e.getMessage());
            e.printStackTrace();

            String errorMsg = e.getMessage();
            if (errorMsg.length() > 100) {
                errorMsg = "Registration failed. Please try again.";
            }

            return "redirect:/?registrationError=provider&message=" + errorMsg.replace(" ", "+");
        }
    }

    @GetMapping("/user")
    public String showUserRegistrationForm(Model model) {
        return "register-user";
    }

    @PostMapping("/user")
    public String registerUser(
            @RequestParam String username,
            @RequestParam String password,
            RedirectAttributes redirectAttributes) {

        try {
            System.out.println("Starting user registration for the username: " + username);

            // Check if username already exists
            if (userService.findByUsername(username).isPresent()) {
                return "redirect:/?registrationError=user&message=Username+already+exists";
            }

            // Create user with USER role
            User user = userService.registerRegularUser(username, password);
            System.out.println("User created with the ID: " + user.getId());

            return "redirect:/?registered=true";
        } catch (Exception e) {
            System.err.println("Error during user registration: " + e.getMessage());
            e.printStackTrace();

            String errorMsg = e.getMessage();
            if (errorMsg.length() > 100) {
                errorMsg = "Registration failed. Please try again.";
            }

            return "redirect:/?registrationError=user&message=" + errorMsg.replace(" ", "+");
        }
    }

    // Adding AJAX endpoint for username validation
    @GetMapping("/validate-username")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> validateUsername(@RequestParam String username) {
        Map<String, Object> response = new HashMap<>();
        boolean exists = userService.findByUsername(username).isPresent();

        response.put("valid", !exists);
        response.put("message", exists ? "Username already taken" : "Username available");

        return ResponseEntity.ok(response);
    }
}