package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/watchlists")
public class WatchlistController {

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProviderService providerService;

    @GetMapping("/{watchlistId}")
    public String getWatchlist(@PathVariable Long watchlistId, Model model) {
        watchlistService.incrementWatchlistViews(watchlistId);
        Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);
        model.addAttribute("watchlistId", watchlist.getWatchlistId());
        model.addAttribute("title", watchlist.getTitle());
        model.addAttribute("description", watchlist.getDescription());
        model.addAttribute("providerUsername", watchlist.getProviderUsername());
        model.addAttribute("providerId", watchlist.getProviderId());
        model.addAttribute("avatar", watchlist.getAvatar());
        model.addAttribute("views", watchlist.getViews());
        model.addAttribute("rating", watchlist.getRating() != null ?
                String.format("%.1f", watchlist.getRating()) : "0.0");
        model.addAttribute("ratingStars", getRatingStars(watchlist.getRating()));
        model.addAttribute("comments", watchlist.getComments());

        // Get authentication state
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null &&
                authentication.isAuthenticated() &&
                !authentication.getName().equals("anonymousUser");

        model.addAttribute("isAuthenticated", isAuthenticated);

        if (isAuthenticated) {
            String username = authentication.getName();
            model.addAttribute("username", username);
            model.addAttribute("currentUser", username);

            // Add current user avatar for comments
            String currentUserAvatar = getCurrentUserAvatar(username);
            model.addAttribute("currentUserAvatar", currentUserAvatar);

            // Get user details if needed
            User user = userService.findByUsername(username).orElse(null);
            if (user != null) {
                model.addAttribute("userAvatar", user.getProfileImage() != null ?
                        user.getProfileImage() : "/pics/default-profile.jpg");

                boolean isProvider = userService.isProvider(username);
                model.addAttribute("isProvider", isProvider);

                if (isProvider) {
                    Long currProviderId = userService.getProviderId(username);
                    model.addAttribute("currProviderId", currProviderId);
                }

                // Check if subscribed
                boolean isSubscribed = watchlistService.isSubscribed(username, watchlistId);
                model.addAttribute("isSubscribed", isSubscribed);
            } else {
                model.addAttribute("userAvatar", "/pics/default-profile.jpg");
            }
        } else {
            // Default for non-authenticated users
            model.addAttribute("currentUser", "Guest");
            model.addAttribute("currentUserAvatar", "/pics/default-profile.jpg");
            model.addAttribute("userAvatar", "/pics/default-profile.jpg");
        }

        return "watchlist";
    }

    // Method to get the correct avatar for the current user
    private String getCurrentUserAvatar(String username) {
        User user = userService.findByUsername(username).orElse(null);
        if (user == null) {
            return "/pics/default-profile.jpg";
        }

        // If user is a provider, use provider profile image
        if (userService.isProvider(username)) {
            Long providerId = userService.getProviderId(username);
            if (providerId != null) {
                try {
                    Provider provider = providerService.getProviderByProviderId(providerId);
                    return provider.getProviderProfileImage() != null ?
                            provider.getProviderProfileImage() : "/pics/default-profile.jpg";
                } catch (Exception e) {
                    return user.getProfileImage() != null ?
                            user.getProfileImage() : "/pics/default-profile.jpg";
                }
            }
        }

        return user.getProfileImage() != null ?
                user.getProfileImage() : "/pics/default-profile.jpg";
    }

    @GetMapping ("/watchlist-list")
    public String listWatchlists(Model model) {
        List<Watchlist> watchlists = watchlistService.getAllWatchlists();
        model.addAttribute("watchlists", watchlists);

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
            }
        }
        return "watchlist-list";
    }

    @GetMapping("/new")
    public String showCreateWatchlistForm(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() ||
                authentication.getName().equals("anonymousUser")) {
            return "redirect:/login";
        }

        String username = authentication.getName();

        // Check if the user is a provider
        boolean isProvider = userService.isProvider(username);
        if (!isProvider) {
            return "redirect:/home"; // Redirect non-providers
        }

        Long providerId = userService.getProviderId(username);

        model.addAttribute("isAuthenticated", true);
        model.addAttribute("isProvider", true);
        model.addAttribute("username", username);
        model.addAttribute("providerId", providerId);

        return "create-watchlist";
    }

    @PostMapping("/create")
    public String createWatchlist(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("providerId") Long providerId,
            @RequestParam("providerUsername") String providerUsername,
            @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
            RedirectAttributes redirectAttributes) {

        try {
            // Create a new watchlist
            Watchlist watchlist = new Watchlist();
            watchlist.setTitle(title);
            watchlist.setDescription(description);
            watchlist.setProviderId(providerId);
            watchlist.setProviderUsername(providerUsername);

            Provider provider = providerService.getProviderByProviderId(providerId);
            if (provider != null) {
                watchlist.setAvatar(provider.getProviderProfileImage());
            } else {
                watchlist.setAvatar("/pics/default-profile.jpg");
            }

            watchlist.setRating(0.0);
            watchlist.setViews(0L);
            watchlist.setNumRatings(0);

            // Handle thumbnail upload
            if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
                try {
                    String uploadDir = "src/main/resources/static/uploads/watchlists";
                    Path uploadPath = Paths.get(uploadDir);
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }

                    String filename = UUID.randomUUID().toString() + "_" + thumbnailFile.getOriginalFilename();
                    Path filePath = uploadPath.resolve(filename);

                    Files.copy(thumbnailFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                    watchlist.setThumbnail("/uploads/watchlists/" + filename);
                } catch (IOException e) {
                    e.printStackTrace();
                    redirectAttributes.addFlashAttribute("error", "Failed to upload thumbnail: " + e.getMessage());
                    return "redirect:/watchlists/new";
                }
            } else {
                watchlist.setThumbnail("/pics/default-watchlist.jpg");
            }

            // Save the watchlist
            watchlistService.createWatchlist(watchlist);

            // Redirect to the provider's profile
            return "redirect:/provider-profile/" + providerId;

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to create watchlist: " + e.getMessage());
            return "redirect:/watchlists/new";
        }
    }

    private String getRatingStars(Double rating) {
        if (rating == null) return "☆☆☆☆☆";
        int stars = (int) Math.round(rating);
        return "★".repeat(stars) + "☆".repeat(5 - stars);
    }

    @PostMapping("/{watchlistId}/rate")
    @ResponseBody
    public Watchlist rateWatchlist(@PathVariable Long watchlistId, @RequestParam Integer rating) {
        Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);

        Double currentRating = watchlist.getRating() != null ? watchlist.getRating() : 0.0;
        int numRatings = watchlist.getNumRatings() != null ? watchlist.getNumRatings() : 0;

        double newRating = ((currentRating * numRatings) + rating) / (numRatings + 1);
        watchlist.setRating(newRating);
        watchlist.setNumRatings(numRatings + 1);

        return watchlistService.updateWatchlist(watchlist);
    }

    @GetMapping("/edit/{watchlistId}")
    public String showEditWatchlistForm(@PathVariable Long watchlistId, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() ||
                authentication.getName().equals("anonymousUser")) {
            return "redirect:/login";
        }

        String username = authentication.getName();

        // Check if the user is a provider and owns this watchlist
        boolean isOwner = watchlistService.isWatchlistOwner(watchlistId, username);
        if (!isOwner) {
            return "redirect:/home"; // Redirect non-owners
        }

        Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);

        model.addAttribute("watchlist", watchlist);
        model.addAttribute("isAuthenticated", true);
        model.addAttribute("isProvider", true);
        model.addAttribute("username", username);
        model.addAttribute("providerId", watchlist.getProviderId());

        return "edit-watchlist";
    }

    @PostMapping("/update/{watchlistId}")
    public String updateWatchlist(
            @PathVariable Long watchlistId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
            RedirectAttributes redirectAttributes) {

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            // Check if user is authorized to edit this watchlist
            boolean isOwner = watchlistService.isWatchlistOwner(watchlistId, username);
            if (!isOwner) {
                redirectAttributes.addFlashAttribute("error", "You don't have permission to edit this watchlist");
                return "redirect:/home";
            }

            Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);

            watchlist.setTitle(title);
            watchlist.setDescription(description);

            // Handle thumbnail upload if provided
            if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
                try {
                    String uploadDir = "src/main/resources/static/uploads/watchlists";
                    Path uploadPath = Paths.get(uploadDir);
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }

                    String filename = UUID.randomUUID().toString() + "_" + thumbnailFile.getOriginalFilename();
                    Path filePath = uploadPath.resolve(filename);

                    Files.copy(thumbnailFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                    watchlist.setThumbnail("/uploads/watchlists/" + filename);
                } catch (IOException e) {
                    e.printStackTrace();
                    redirectAttributes.addFlashAttribute("error", "Failed to upload thumbnail: " + e.getMessage());
                    return "redirect:/watchlists/edit/" + watchlistId;
                }
            }

            watchlistService.updateWatchlist(watchlist);

            redirectAttributes.addFlashAttribute("success", "Watchlist updated successfully");

            return "redirect:/watchlists/" + watchlistId;

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to update watchlist: " + e.getMessage());
            return "redirect:/watchlists/edit/" + watchlistId;
        }
    }

    @PostMapping("/delete/{watchlistId}")
    @ResponseBody
    public ResponseEntity<?> deleteWatchlist(@PathVariable Long watchlistId) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            // Check if user is authorized to delete this watchlist
            boolean isOwner = watchlistService.isWatchlistOwner(watchlistId, username);

            if (!isOwner) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("You don't have permission to delete this watchlist");
            }

            // Delete the watchlist
            watchlistService.deleteWatchlist(watchlistId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error deleting watchlist: " + e.getMessage());
        }
    }
}