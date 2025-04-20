package com.aniwatch.aniwatch;

public class ProviderStats {
    private int totalWatchlists;
    private double averageRating;
    private int totalComments;
    private int commentsMade;
    private int totalSubscribers;

    public ProviderStats() {
        this.totalWatchlists = 0;
        this.averageRating = 0.0;
        this.totalComments = 0;
        this.totalSubscribers = 0;
    }

    public int getTotalWatchlists() {
        return totalWatchlists;
    }

    public void setTotalWatchlists(int totalWatchlists) {
        this.totalWatchlists = totalWatchlists;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public int getTotalComments() {
        return totalComments;
    }

    public void setTotalComments(int totalComments) {
        this.totalComments = totalComments;
    }

    public int getCommentsMade() {
        return commentsMade;
    }

    public void setCommentsMade(int commentsMade) {
        this.commentsMade = commentsMade;
    }

    public int getTotalSubscribers() {
        return totalSubscribers;
    }

    public void setTotalSubscribers(int totalSubscribers) {
        this.totalSubscribers = totalSubscribers;
    }
}