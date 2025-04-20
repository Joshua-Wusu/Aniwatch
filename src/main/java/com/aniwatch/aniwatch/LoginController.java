package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/login")
    public String loginPage(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "registered", required = false) String registered) {

        // Create a one-time modal display
        return "redirect:/?showLoginModal=true" +
                (error != null ? "&loginError=true" : "") +
                (registered != null ? "&registered=true" : "");
    }

    // Redirects to home upon error
    @GetMapping("/login-error")
    public String loginError() {
        return "redirect:/?error=true";
    }

    @GetMapping("/login-success")
    public String loginSuccess() {
        return "redirect:/home";
    }

    // Debug endpoint to see all users in the database, will remove later
    @GetMapping("/debug/users")
    public String debugUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "debug-users";
    }

    // Checks if a username already exists (for AJAX validation)
    @GetMapping("/check-username")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkUsername(@RequestParam String username) {
        boolean exists = userRepository.findByUsername(username).isPresent();

        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);

        return ResponseEntity.ok(response);
    }
}