/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author ADMIN
 */

public class Feedback {
    private long guestId; // Cập nhật kiểu dữ liệu
    private long eventId; // Cập nhật kiểu dữ liệu
    private String content;

    public Feedback(long guestId, long eventId, String content) {
        this.guestId = guestId;
        this.eventId = eventId;
        this.content = content;
    }

    // Các phương thức getter và setter

    public long getGuestId() {
        return guestId;
    }

    public void setGuestId(long guestId) {
        this.guestId = guestId;
    }

    public long getEventId() {
        return eventId;
    }

    public void setEventId(long eventId) {
        this.eventId = eventId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Feedback{" + "guestId=" + guestId + ", eventId=" + eventId + ", content=" + content + '}';
    }
}

    // Getters and Setters
