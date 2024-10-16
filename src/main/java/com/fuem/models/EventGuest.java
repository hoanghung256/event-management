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
    private Student student;
    private Event event;

    public EventGuest(Student student, Event event) {
        this.student = student;
        this.event = event;
    }

    public Student getStudent() {
        return student;
    }

    public Event getEvent() {
        return event;
    }
}