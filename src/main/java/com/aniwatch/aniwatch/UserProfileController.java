package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class UserProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProviderService providerService;

    @Autowired
    private WatchlistService watchlistService;

    @GetMapping("/user-profile/{userId}")
    public String userProfile(@PathVariable Long userId, Model model) {
        // Get current authenticated user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null &&
                authentication.isAuthenticated() &&
                !authentication.getName().equals("anonymousUser");

        model.addAttribute("isAuthenticated", isAuthenticated);

        // Get the viewed user profile (this should work for both authenticated and non-authenticated users)
        User viewedUser = userService.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        model.addAttribute("user", viewedUser);

        // Default values for non-authenticated users
        boolean isOwnProfile = false;
        String username = "Guest";

        if (isAuthenticated) {
            // Only get current user info if authenticated
            username = authentication.getName();
            User currentUser = userService.findByUsername(username)
                    .orElseThrow(() -> new RuntimeException("Current user not found"));

            isOwnProfile = currentUser.getId().equals(viewedUser.getId());

            boolean isProvider = userService.isProvider(username);
            model.addAttribute("isProvider", isProvider);
        } else {
            // Non-authenticated users are not providers
            model.addAttribute("isProvider", false);
        }

        model.addAttribute("isOwnProfile", isOwnProfile);
        model.addAttribute("username", username);

        int commentCount = userService.countUserComments(userId);
        model.addAttribute("commentCount", commentCount);

        // Check if the user's subscribed watchlists are public or if it's the user's own profile
        boolean canViewSubscriptions = isOwnProfile || viewedUser.isPublicSubscribedWatchlists();

        if (canViewSubscriptions) {
            List<Watchlist> subscribedWatchlists = watchlistService.getSubscribedWatchlists(viewedUser.getUsername());
            model.addAttribute("subscribedWatchlists", subscribedWatchlists);
            model.addAttribute("subscriptionCount", subscribedWatchlists.size());
        }

        return "user-profile";
    }

    @PostMapping("/user-profile/update")
    public String updateUserProfile(
            @RequestParam(required = false) String bio,
            @RequestParam(required = false) MultipartFile profileImage,
            @RequestParam(value = "publicSubscribedWatchlists", required = false) Boolean publicSubscribedWatchlists,
            RedirectAttributes redirectAttributes) {

        try {
            // Get current authenticated user
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            User user = userService.findByUsername(username)
                    .orElseThrow(() -> new RuntimeException("User not found"));

            // Set privacy settings (null, this means unchecked)
            user.setPublicSubscribedWatchlists(publicSubscribedWatchlists != null);
            userService.saveUser(user);

            userService.updateUserProfile(username, bio, profileImage);

            redirectAttributes.addFlashAttribute("message", "Profile updated successfully");
            return "redirect:/user-profile/" + user.getId();
        } catch (Exception e) {
            User user = userService.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            return "redirect:/user-profile/" + user.getId();
        }
    }

    @GetMapping("/provider-profile/{providerId}")
    public String providerProfile(@PathVariable Long providerId, Model model) {
        try {
            Provider provider = providerService.getProviderByProviderId(providerId);
            model.addAttribute("provider", provider);

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            boolean isAuthenticated = authentication != null &&
                    authentication.isAuthenticated() &&
                    !authentication.getName().equals("anonymousUser");

            model.addAttribute("isAuthenticated", isAuthenticated);

            boolean isOwnProfile = false;

            if (isAuthenticated) {
                String username = authentication.getName();
                model.addAttribute("username", username);

                boolean isProvider = userService.isProvider(username);
                model.addAttribute("isProvider", isProvider);

                // Check if the current user is the provider being viewed
                if (isProvider) {
                    Long currentProviderId = userService.getProviderId(username);
                    isOwnProfile = providerId.equals(currentProviderId);
                    model.addAttribute("isOwnProfile", isOwnProfile);
                    model.addAttribute("providerId", currentProviderId);
                } else {
                    model.addAttribute("isOwnProfile", false);
                }
            }

            // Determine visibility of watchlists
            boolean canViewActiveWatchlists = provider.isPublicActiveWatchlists() || isAuthenticated || isOwnProfile;
            boolean canViewSubscribedWatchlists = provider.isPublicSubscribedWatchlists() || isAuthenticated || isOwnProfile;

            model.addAttribute("canViewActiveWatchlists", canViewActiveWatchlists);
            model.addAttribute("canViewSubscribedWatchlists", canViewSubscribedWatchlists);

            // Only add watchlists if viewable
            if (canViewActiveWatchlists) {
                List<Watchlist> watchlists = watchlistService.getWatchlistsByProviderId(providerId);
                model.addAttribute("watchlists", watchlists);
            }

            // To add subscribed watchlists if viewing own profile or if they're public
            if (isOwnProfile || (isAuthenticated && canViewSubscribedWatchlists)) {
                List<Watchlist> subscribedWatchlists = watchlistService.getSubscribedWatchlists(provider.getProviderUsername());
                model.addAttribute("subscribedWatchlists", subscribedWatchlists);
            }

            ProviderStats stats = providerService.calculateProviderStats(providerId);
            model.addAttribute("stats", stats);

            return "provider-profile";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading provider profile: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/provider-profile/subscribed-watchlists")
    public String subscribedWatchlists(@RequestParam(required = false) Long providerId, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() ||
                authentication.getName().equals("anonymousUser")) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        boolean isProvider = userService.isProvider(username);
        Long currentProviderId = isProvider ? userService.getProviderId(username) : null;

        // If no providerId specified, default to current user
        if (providerId == null) {
            if (!isProvider) {
                return "redirect:/user-profile";
            }
            providerId = currentProviderId;
        }

        try {
            Provider provider = providerService.getProviderByProviderId(providerId);
            model.addAttribute("provider", provider);

            boolean isOwnProfile = isProvider && providerId.equals(currentProviderId);

            // Check if user can view subscribed watchlists
            boolean canViewSubscribedWatchlists = isOwnProfile || provider.isPublicSubscribedWatchlists();

            if (!canViewSubscribedWatchlists) {
                model.addAttribute("error", "This provider's subscribed watchlists are private");
                return "error";
            }

            String providerUsername = provider.getProviderUsername();

            List<Watchlist> subscribedWatchlists = watchlistService.getSubscribedWatchlists(providerUsername);
            model.addAttribute("subscribedWatchlists", subscribedWatchlists);

            model.addAttribute("isAuthenticated", true);
            model.addAttribute("isOwnProfile", isOwnProfile);
            model.addAttribute("isProvider", isProvider);
            model.addAttribute("username", username);

            model.addAttribute("providerId", providerId);
            model.addAttribute("currentProviderId", currentProviderId);

            return "provider-subscribed-watchlists";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading subscribed watchlists: " + e.getMessage());
            return "error";
        }
    }

    @PostMapping("/provider-profile/update")
    public String updateProviderProfile(
            @RequestParam(required = false) String username,
            @RequestParam(required = false) String bio,
            @RequestParam(required = false) MultipartFile profileImage,
            RedirectAttributes redirectAttributes,
            @RequestParam(value = "publicActiveWatchlists", required = false) Boolean publicActiveWatchlists,
            @RequestParam(value = "publicSubscribedWatchlists", required = false) Boolean publicSubscribedWatchlists) {

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String currentUsername = authentication.getName();

            Long providerId = userService.getProviderId(currentUsername);

            if (providerId == null) {
                throw new RuntimeException("You are not a provider");
            }

            Provider provider = providerService.getProviderByProviderId(providerId);
            provider.setProviderBio(bio);

            // Set privacy settings (null means unchecked)
            provider.setPublicActiveWatchlists(publicActiveWatchlists != null);
            provider.setPublicSubscribedWatchlists(publicSubscribedWatchlists != null);

            providerService.updateProviderProfile(providerId, username, bio, profileImage);

            redirectAttributes.addFlashAttribute("message", "Profile updated successfully");
            return "redirect:/provider-profile/" + providerId;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error updating profile: " + e.getMessage());
            return "redirect:/provider-profile/" + userService.getProviderId(SecurityContextHolder.getContext().getAuthentication().getName());
        }
    }

    @GetMapping("/user-profile/subscribed-watchlists")
    public String userSubscribedWatchlists(@RequestParam(required = false) Long userId, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() ||
                authentication.getName().equals("anonymousUser")) {
            return "redirect:/login";
        }

        String username = authentication.getName();

        User currentUser = userService.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // If userId is provided, try to view that user's subscribed watchlists instead
        User viewedUser = currentUser;
        boolean isOwnProfile = true;

        if (userId != null && !userId.equals(currentUser.getId())) {
            viewedUser = userService.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            isOwnProfile = false;

            // Check if the viewed user allows their subscribed watchlists to be seen
            if (!viewedUser.isPublicSubscribedWatchlists()) {
                model.addAttribute("error", "This user's subscribed watchlists are private");
                return "error";
            }
        }

        model.addAttribute("user", viewedUser);
        model.addAttribute("isOwnProfile", isOwnProfile);

        List<Watchlist> subscribedWatchlists = watchlistService.getSubscribedWatchlists(viewedUser.getUsername());
        model.addAttribute("subscribedWatchlists", subscribedWatchlists);

        model.addAttribute("isAuthenticated", true);
        model.addAttribute("username", username);
        model.addAttribute("isProvider", false);

        int subscriptionCount = subscribedWatchlists.size();
        model.addAttribute("subscriptionCount", subscriptionCount);

        return "user-subscribed-watchlists";
    }

    @GetMapping("/provider-profile/provider-watchlist/all")
    public String viewAllProviderWatchlists(@RequestParam(required = false) Long providerId, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null &&
                authentication.isAuthenticated() &&
                !authentication.getName().equals("anonymousUser");

        if (!isAuthenticated) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        boolean isProvider = userService.isProvider(username);
        Long currentProviderId = isProvider ? userService.getProviderId(username) : null;

        if (providerId == null) {
            if (!isProvider) {
                return "redirect:/user-profile";
            }
            providerId = currentProviderId;
        }

        try {
            Provider provider = providerService.getProviderByProviderId(providerId);
            model.addAttribute("provider", provider);

            boolean isOwnProfile = isProvider && providerId.equals(currentProviderId);

            boolean canViewWatchlists = isOwnProfile || provider.isPublicActiveWatchlists();

            if (!canViewWatchlists) {
                model.addAttribute("error", "This provider's watchlists are private");
                return "error";
            }

            List<Watchlist> watchlists = watchlistService.getWatchlistsByProviderId(providerId);
            model.addAttribute("watchlists", watchlists);

            model.addAttribute("isAuthenticated", isAuthenticated);
            model.addAttribute("isOwnProfile", isOwnProfile);
            model.addAttribute("isProvider", isProvider);
            model.addAttribute("username", username);

            // Important: Make sure providerId is explicitly set in the model
            model.addAttribute("providerId", providerId);
            model.addAttribute("currentProviderId", currentProviderId);

            return "provider-watchlist-all";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading watchlists: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/user/check-type")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkUserType(@RequestParam String username) {
        Map<String, Object> response = new HashMap<>();

        Optional<User> userOpt = userService.findByUsername(username);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            response.put("exists", true);

            boolean isProvider = userService.isProvider(username);
            response.put("isProvider", isProvider);

            if (isProvider) {
                Long providerId = userService.getProviderId(username);
                response.put("providerId", providerId);
            } else {
                response.put("userId", user.getId());
            }

            return ResponseEntity.ok(response);
        } else {
            response.put("exists", false);
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/user-profile/stats")
    public String userStats(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        User user = userService.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        model.addAttribute("user", user);

        return "user-stats";
    }

    @GetMapping("/provider-profile/stats")
    public String providerStats(Model model) {
        // Get current authenticated user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        boolean isProvider = userService.isProvider(username);
        if (!isProvider) {
            return "redirect:/user-profile";
        }

        Long providerId = userService.getProviderId(username);

        Provider provider = providerService.getProviderByProviderId(providerId);
        model.addAttribute("provider", provider);

        ProviderStats stats = providerService.calculateProviderStats(providerId);
        model.addAttribute("stats", stats);

        // Get all watchlists for this provider
        List<Watchlist> watchlists = watchlistService.getWatchlistsByProviderId(providerId);
        model.addAttribute("watchlists", watchlists);

        return "provider-stats";
    }
}