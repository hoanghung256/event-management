/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author Administrator
 */
public class Feedback {

    private int guestId; // ID của sinh viên
    private int eventId; // ID của sự kiện
    private String content; // Nội dung phản hồi
    private String fullname; // Tên đầy đủ của sinh viên
    private String avatarPath; // Đường dẫn đến ảnh đại diện

    public Feedback() {
    }

    public Feedback(int guestId, int eventId, String content, String fullname, String avatarPath) {
        this.guestId = guestId; // ID sinh viên
        this.eventId = eventId; // ID sự kiện
        this.content = content; // Nội dung phản hồi
        this.fullname = fullname; // Tên đầy đủ
        this.avatarPath = avatarPath; // Đường dẫn ảnh
    }

    // Getter và setter cho các thuộc tính
    public int getGuestId() {
        return guestId;
    }

    public void setGuestId(int guestId) {
        this.guestId = guestId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    @Override
    public String toString() {
        return "Feedback{"
                + "guestId=" + guestId
                + ", eventId=" + eventId
                + ", content='" + content + '\''
                + ", fullname='" + fullname + '\''
                + ", avatarPath='" + avatarPath + '\''
                + '}';
    }
}
