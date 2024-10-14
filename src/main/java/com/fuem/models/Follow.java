/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author Administrator
 */
public class Follow {
     private int followerId; 
    private int followedId;

    public Follow(int followerId, int followedId) {
        this.followerId = followerId;
        this.followedId = followedId;
    }

    public int getFollowerId() {
        return followerId;
    }

    public void setFollowerId(int followerId) {
        this.followerId = followerId;
    }

    public int getFollowedId() {
        return followedId;
    }

    public void setFollowedId(int followedId) {
        this.followedId = followedId;
    }

    @Override
    public String toString() {
        return "Follow{" + "followerId=" + followerId + ", followedId=" + followedId + '}';
    }
    
}
