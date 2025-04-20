package com.aniwatch.aniwatch;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "watchlists")
public class Watchlist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long watchlistId;

    @Column(nullable = false)
    private Long providerId;

    @Column(nullable = false)
    private String title;

    private String description;

    @Column(nullable = false)
    private String providerUsername;

    private String avatar;

    private String thumbnail;

    private Double rating;

    @Transient // Mark as transient so it doesn't persist to the database
    private String ratingStars;

    private Integer numRatings = 0;


    @OneToMany(mappedBy = "watchlist", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference // Serializes this side of the relationship
    private List<Comment> comments = new ArrayList<>();

    public Long getWatchlistId() {
        return watchlistId;
    }

    public void setWatchlistId(Long watchlistId) {
        this.watchlistId = watchlistId;
    }

    public Long getProviderId() {
        return providerId;
    }

    public void setProviderId(Long providerId) {
        this.providerId = providerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProviderUsername() {
        return providerUsername;
    }

    public void setProviderUsername(String providerUsername) {
        this.providerUsername = providerUsername;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    @Column(nullable = false)
    private Long views = 0L;

    public String getRatingStars() {
        return ratingStars;
    }

    public void setRatingStars(String ratingStars) {
        this.ratingStars = ratingStars;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public Integer getNumRatings() { return numRatings; }

    public void setNumRatings(Integer numRatings) { this.numRatings = numRatings; }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }


    public List<Comment> getComments() {
        return comments != null ? comments : new ArrayList<>();
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}
