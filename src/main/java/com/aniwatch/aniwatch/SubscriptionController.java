package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/subscriptions")
public class SubscriptionController {

    @Autowired
    private WatchlistService watchlistService;

    @PostMapping("/subscribe/{watchlistId}")
    public ResponseEntity<?> subscribe(@PathVariable Long watchlistId) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            watchlistService.subscribeToWatchlist(username, watchlistId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/unsubscribe/{watchlistId}")
    public ResponseEntity<?> unsubscribe(@PathVariable Long watchlistId) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            watchlistService.unsubscribeFromWatchlist(username, watchlistId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/check/{watchlistId}")
    public ResponseEntity<Boolean> checkSubscription(@PathVariable Long watchlistId) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            boolean isSubscribed = watchlistService.isSubscribed(username, watchlistId);
            return ResponseEntity.ok(isSubscribed);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(false);
        }
    }
}