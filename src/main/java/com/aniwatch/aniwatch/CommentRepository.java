package com.aniwatch.aniwatch;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByWatchlist_WatchlistId(Long watchlistId);
    int countByUsername(String username);
    List<Comment> findByWatchlist_WatchlistIdAndParentCommentIsNull(Long watchlistId);
    List<Comment> findByParentComment_CommentId(Long parentCommentId);
    int countByWatchlist_WatchlistId(Long watchlistId);
    void deleteByWatchlist_WatchlistId(Long watchlistId);
}
