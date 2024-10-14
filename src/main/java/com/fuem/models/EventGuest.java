/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author ADMIN
 */
public class EventGuest {
    private int studentId;
    private int eventId;

    public EventGuest(int studentId, int eventId) {
        this.studentId = studentId;
        this.eventId = eventId;
    }

    public int getStudentId() {
        return studentId;
    }

    public int getEventId() {
        return eventId;
    }
}