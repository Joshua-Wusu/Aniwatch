package com.aniwatch.aniwatch;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WatchlistRepository extends JpaRepository<Watchlist, Long> {
    List<Watchlist> findByProviderId(Long providerId);
    List<Watchlist> findByWatchlistId(Long watchlistId);
}
