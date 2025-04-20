package com.aniwatch.aniwatch;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    @Query(value = "SELECT COUNT(DISTINCT s.user_id) FROM subscriptions s " +
            "JOIN watchlists w ON s.watchlist_id = w.watchlist_id " +
            "WHERE w.provider_id = :providerId", nativeQuery = true)
    int countUniqueSubscribersByProviderId(@Param("providerId") Long providerId);

    int countByWatchlistId(Long watchlistId);

    List<Subscription> findByUserId(Long userId);
    List<Subscription> findByWatchlistId(Long watchlistId);
    boolean existsByUserIdAndWatchlistId(Long userId, Long watchlistId);
    void deleteByUserIdAndWatchlistId(Long userId, Long watchlistId);
    void deleteByWatchlistId(Long watchlistId);
}