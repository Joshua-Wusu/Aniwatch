package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String redirectToHome(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "registered", required = false) String registered,
            @RequestParam(value = "registrationError", required = false) String registrationError,
            @RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "showLoginModal", required = false) Boolean showLoginModal,
            @RequestParam(value = "loginError", required = false) Boolean loginError,
            Model model) {

        // To preserve parameters in the process of being redirected
        StringBuilder redirectUrl = new StringBuilder("/home");
        boolean hasParam = false;

        if (error != null) {
            redirectUrl.append("?error=").append(error);
            hasParam = true;
        }

        if (registered != null) {
            redirectUrl.append(hasParam ? "&" : "?").append("registered=").append(registered);
            hasParam = true;
        }

        if (registrationError != null) {
            redirectUrl.append(hasParam ? "&" : "?").append("registrationError=").append(registrationError);
            hasParam = true;

            if (message != null) {
                redirectUrl.append("&message=").append(message);
            }
        }

        // Pass the login modal parameters
        if (showLoginModal != null && showLoginModal) {
            redirectUrl.append(hasParam ? "&" : "?").append("showLoginModal=true");
            hasParam = true;
        }

        if (loginError != null && loginError) {
            redirectUrl.append(hasParam ? "&" : "?").append("loginError=true");
        }

        return "redirect:" + redirectUrl.toString();
    }

    @GetMapping("/home")
    public String home(
            @RequestParam(value = "showLoginModal", required = false) Boolean showLoginModal,
            @RequestParam(value = "loginError", required = false) Boolean loginError,
            @RequestParam(value = "registered", required = false) String registered,
            Model model) {
        // This just gets a few random watchlists to display in home
        List<Watchlist> featuredWatchlists = watchlistService.getRandomWatchlists(4);

        model.addAttribute("featuredWatchlists", featuredWatchlists);

        // Add authentication info to model
        addAuthInfoToModel(model);

        // Add login modal attributes
        if (showLoginModal != null && showLoginModal) {
            model.addAttribute("showLoginModal", true);
        }

        if (loginError != null && loginError) {
            model.addAttribute("loginError", true);
        }

        if (registered != null) {
            model.addAttribute("registered", true);
        }

        // Something extra to determine current season ;-)
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();

        String currentSeason;
        if (month >= 1 && month <= 3) {
            currentSeason = "Winter";
        } else if (month >= 4 && month <= 6) {
            currentSeason = "Spring";
        } else if (month >= 7 && month <= 9) {
            currentSeason = "Summer";
        } else {
            currentSeason = "Fall";
        }

        model.addAttribute("currentSeason", currentSeason);

        return "home";
    }

    private void addAuthInfoToModel(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null &&
                authentication.isAuthenticated() &&
                !authentication.getName().equals("anonymousUser");

        model.addAttribute("isAuthenticated", isAuthenticated);

        if (isAuthenticated) {
            String username = authentication.getName();
            model.addAttribute("username", username);

            boolean isProvider = userService.isProvider(username);
            model.addAttribute("isProvider", isProvider);

            if (isProvider) {
                Long providerId = userService.getProviderId(username);
                model.addAttribute("providerId", providerId);
            } else {

                User user = userService.findByUsername(username).orElse(null);
                if (user != null) {
                    model.addAttribute("userId", user.getId());
                }

            }
        }
    }
}