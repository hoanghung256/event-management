/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author HungHV
 */
public class Feedback {

    private Student guest;
    private int eventId;
    private String content;

    public Feedback() {
    }
    
    public Feedback(Student guest, String content) {
        this.guest = guest;
        this.content = content;
    }

    public Feedback(Student guest, int eventId, String content) {
        this.guest = guest;
        this.eventId = eventId;
        this.content = content;
    }

    public Student getGuest() {
        return guest;
    }

    public void setGuest(Student guest) {
        this.guest = guest;
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
}