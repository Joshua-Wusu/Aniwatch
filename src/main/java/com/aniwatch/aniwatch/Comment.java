package com.aniwatch.aniwatch;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long commentId;

    @ManyToOne
    @JoinColumn(name = "watchlist_id", nullable = false)
    @JsonBackReference
    private Watchlist watchlist;

    @Column(nullable = false)
    private String username;

    @Column
    private String avatarSrc;

    @Column(nullable = false)
    private String text;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "likes")
    private int likes = 0;

    @Column(name = "dislikes")
    private int dislikes = 0;

    public Comment(Watchlist watchlist, String username, String text) {
        this.watchlist = watchlist;
        this.username = username;
        this.text = text;
        this.createdAt = LocalDateTime.now();
    }

    public Comment(Watchlist watchlist, String username, String text, Comment parentComment) {
        this.watchlist = watchlist;
        this.username = username;
        this.text = text;
        this.parentComment = parentComment;
        this.createdAt = LocalDateTime.now();
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_comment_id")
    @JsonBackReference(value = "parent-comment")
    private Comment parentComment;

    @OneToMany(mappedBy = "parentComment", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference(value = "parent-comment")
    private List<Comment> replies = new ArrayList<>();

    public Comment() {
        this.createdAt = LocalDateTime.now();
    }

    public Long getCommentId() { return commentId; }

    public void setCommentId(Long commentId) { this.commentId = commentId; }

    public Watchlist getWatchlist() { return watchlist; }

    public void setWatchlist(Watchlist watchlist) { this.watchlist = watchlist; }

    public String getUsername() { return username; }

    public void setUsername(String username) { this.username = username; }

    public String getAvatarSrc() {
        return avatarSrc;
    }

    public void setAvatarSrc(String avatarSrc) {
        this.avatarSrc = avatarSrc;
    }

    public String getText() { return text; }

    public void setText(String text) { this.text = text; }

    public LocalDateTime getCreatedAt() { return createdAt; }

    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public int getLikes() { return likes; }

    public void setLikes(int likes) { this.likes = likes; }

    public int getDislikes() { return dislikes; }

    public void setDislikes(int dislikes) { this.dislikes = dislikes; }

    public Comment getParentComment() { return parentComment; }

    public void setParentComment(Comment parentComment) { this.parentComment = parentComment; }

    public List<Comment> getReplies() { return replies; }

    public void setReplies(List<Comment> replies) { this.replies = replies; }

    public void addReply(Comment reply) {
        replies.add(reply);
        reply.setParentComment(this);
        reply.setWatchlist(this.watchlist); // This ensures reply inherits a given watchlist
    }
}