package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private WatchlistService watchlistService;

    public List<Comment> getCommentsByWatchlistId(Long watchlistId) {
        return commentRepository.findByWatchlist_WatchlistIdAndParentCommentIsNull(watchlistId);
    }

    public Comment addComment(Long watchlistId, String username, String text) {
        Watchlist watchlist;
        try {
            watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Oh no watchlist not found with the ID: " + watchlistId, e);
        }
        Comment comment = new Comment();
        comment.setWatchlist(watchlist);
        comment.setUsername(username);
        comment.setText(text);
        return commentRepository.save(comment);
    }

    public Comment addReply(Long parentCommentId, String username, String text) {
        Comment parentComment = commentRepository.findById(parentCommentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Ouch, parent comment not found with the ID: " + parentCommentId));
        Comment reply = new Comment();
        reply.setUsername(username);
        reply.setText(text);
        parentComment.addReply(reply);
        return commentRepository.save(reply);
    }

    public List<Comment> getReplies(Long parentCommentId) {
        return commentRepository.findByParentComment_CommentId(parentCommentId);
    }

    public Comment likeComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Whelp, comment not found with the ID: " + commentId));
        comment.setLikes(comment.getLikes() + 1);
        return commentRepository.save(comment);
    }

    public Comment dislikeComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Sorry not sorry, comment not found with the ID: " + commentId));
        comment.setDislikes(comment.getDislikes() + 1);
        return commentRepository.save(comment);
    }
}