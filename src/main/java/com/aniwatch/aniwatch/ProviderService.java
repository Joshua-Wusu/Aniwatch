package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Service
public class ProviderService {

    @Autowired
    private ProviderRepository providerRepository;

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    public Provider getProviderByProviderId(Long providerId) {
        return providerRepository.findByProviderId(providerId)
                .orElseThrow(() -> new RuntimeException("Oops, provider not found with the id: " + providerId));
    }

    public Provider getProviderByProviderUsername(String providerUsername) {
        return providerRepository.findByProviderUsername(providerUsername);
    }

    public List<Provider> getAllProviders() {
        return providerRepository.findAll();
    }

    public Long createProvider(Provider provider, MultipartFile profileImage) {

        if (profileImage != null && !profileImage.isEmpty()) {

            String imagePath = saveProfileImage(profileImage);
            provider.setProviderProfileImage(imagePath);
        } else {
            // Set default profile image, you might like this foday lol
            provider.setProviderProfileImage("/pics/default-profile.jpg");
        }

        if (provider.getCreatedAt() == null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            provider.setCreatedAt(LocalDateTime.now().format(formatter));
        }

        Provider savedProvider = providerRepository.save(provider);
        return savedProvider.getProviderId();
    }

    public String saveProfileImage(MultipartFile file) {
        try {
            String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads/profiles";
            Path uploadPath = Paths.get(uploadDir);

            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            String filename = UUID.randomUUID().toString() + "_" +
                    file.getOriginalFilename().replaceAll("\\s+", "_");
            Path filePath = uploadPath.resolve(filename);

            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            return "/uploads/profiles/" + filename;
        } catch (IOException e) {
            throw new RuntimeException("You're so trash that I failed to save your profile image", e);
        }
    }

    public Provider updateProviderProfile(Long providerId, String providerUsername,
                                          String providerBio, MultipartFile providerProfileImage) {
        Provider provider = getProviderByProviderId(providerId);

        if (providerUsername != null && !providerUsername.isEmpty()) {
            provider.setProviderUsername(providerUsername);
        }

        if (providerBio != null) {
            provider.setProviderBio(providerBio);
        }

        if (providerProfileImage != null && !providerProfileImage.isEmpty()) {
            String imagePath = saveProfileImage(providerProfileImage);
            provider.setProviderProfileImage(imagePath);
        }

        return providerRepository.save(provider);
    }

    public int countProviderComments(Long providerId) {
        Provider provider = providerRepository.findById(providerId)
                .orElseThrow(() -> new RuntimeException("Provider not found with ID: " + providerId));

        return commentRepository.countByUsername(provider.getProviderUsername());
    }

    public ProviderStats calculateProviderStats(Long providerId) {
        Provider provider = getProviderByProviderId(providerId);
        ProviderStats stats = new ProviderStats();

        List<Watchlist> providerWatchlists = watchlistService.getWatchlistsByProviderId(providerId);

        stats.setTotalWatchlists(providerWatchlists.size());

        if (!providerWatchlists.isEmpty()) {
            double totalRating = 0.0;
            int ratedWatchlists = 0;
            int totalComments = 0;

            for (Watchlist watchlist : providerWatchlists) {
                if (watchlist.getRating() != null && watchlist.getRating() > 0) {
                    totalRating += watchlist.getRating();
                    ratedWatchlists++;
                }
                // Count comments for a specific watchlist
                totalComments += commentRepository.countByWatchlist_WatchlistId(watchlist.getWatchlistId());
            }

            if (ratedWatchlists > 0) {
                stats.setAverageRating(totalRating / ratedWatchlists);
            }

            stats.setTotalComments(totalComments);

            int commentsMadeByProvider = commentRepository.countByUsername(provider.getProviderUsername());
            stats.setCommentsMade(commentsMadeByProvider);

            try {
                stats.setTotalSubscribers(subscriptionRepository.countUniqueSubscribersByProviderId(providerId));
            } catch (Exception e) {
                // Fallback to count subscriptions manually if the query still fails
                int totalSubscribers = 0;
                for (Watchlist watchlist : providerWatchlists) {
                    totalSubscribers += subscriptionRepository.countByWatchlistId(watchlist.getWatchlistId());
                }
                stats.setTotalSubscribers(totalSubscribers);
            }
        }

        return stats;
    }

    // Method to delete a watchlist
    public void deleteWatchlist(Long providerId, Long watchlistId) {
        Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);

        // Check that this watchlist belongs to the provider
        if (!watchlist.getProviderId().equals(providerId)) {
            throw new RuntimeException("Unauthorized: Cannot delete another provider's watchlist");
        }

        watchlistService.deleteWatchlist(watchlistId);
    }

    public Provider saveProvider(Provider provider) {
        return providerRepository.save(provider);
    }
}