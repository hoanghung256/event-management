/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import java.time.Duration;
import java.time.LocalDateTime;

/**
 *
 * @author AnhNQ
 */
public class Notification {
    private int id;
    private Organizer sender;
    private String content;
    private LocalDateTime sendingTime;
    private String timeAgo;
    
    public Notification(int id, Organizer sender, String content, LocalDateTime sendingTime) {
        this.id = id;
        this.sender = sender;
        this.content = content;
        this.sendingTime = sendingTime;
        this.timeAgo = getTimeAgo();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Organizer getSender() {
        return sender;
    }

    public void setSenderId(Organizer sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getSendingTime() {
        return sendingTime;
    }

    public void setSendingTime(LocalDateTime sendingTime) {
        this.sendingTime = sendingTime;
    }
    
    
    
    public String getTimeAgo() {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(sendingTime, now);
        
        long seconds = duration.getSeconds();
        long minutes = duration.toMinutes();
        long hours = duration.toHours();
        long days = duration.toDays();

        if (seconds < 60) {
            return seconds + " sec ago";
        } else if (minutes < 60) {
            return minutes + " min ago";
        } else if (hours < 24) {
            return hours + " h ago";
        } else {
            return days + " days ago";
        }
    }
}

