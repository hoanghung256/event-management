/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author AnhNQ
 */
public class NotificationReceiver {
    private int notificationId;
    private int receiverId;

    public NotificationReceiver(int notificationId, int receiverId) {
        this.notificationId = notificationId;
        this.receiverId = receiverId;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }
}

