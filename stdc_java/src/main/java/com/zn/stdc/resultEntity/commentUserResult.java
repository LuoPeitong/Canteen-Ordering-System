package com.zn.stdc.resultEntity;

import java.io.Serializable;

public class commentUserResult implements Serializable {
    private String content;
    private String commentTime;
    private int comment;
    private int commentId;
    private int orderId;
    private int canteenId;
    private String location;
    private String floor;
    private String CanteenPicUrl;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public int getComment() {
        return comment;
    }

    public void setComment(int comment) {
        this.comment = comment;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCanteenId() {
        return canteenId;
    }

    public void setCanteenId(int canteenId) {
        this.canteenId = canteenId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getCanteenPicUrl() {
        return CanteenPicUrl;
    }

    public void setCanteenPicUrl(String canteenPicUrl) {
        CanteenPicUrl = canteenPicUrl;
    }
}
