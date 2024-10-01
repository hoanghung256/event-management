/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import java.sql.Timestamp;


/**
 *
 * @author hoang hung
 */
import java.util.Date;

public class Event {
    
    private int id;
    private Organizer organizer;
    private String fullName;
    private String description;
    private EventType type;
    private EventLocation location;
    private Date dateOfEvent;
    private Timestamp startTime;
    private Timestamp endTime;
    private int guestRegisterLimit;
    private Date registerDeadline;
    private int guestAttendedCount;

    public Event() {
    }

    public Event(int id, Organizer organizer, String fullname, String description, EventType type, EventLocation location, Date dateOfEvent, Timestamp startTime, Timestamp endTime, int guestRegisterLimit, Date registerDeadline, int guestAttendedCount) {
        this.id = id;
        this.organizer = organizer;
        this.fullName = fullname;
        this.description = description;
        this.type = type;
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
        this.guestRegisterLimit = guestRegisterLimit;
        this.registerDeadline = registerDeadline;
        this.guestAttendedCount = guestAttendedCount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Organizer getOrganizerId() {
        return organizer;
    }

    public void setOrganizerId(Organizer organizer) {
        this.organizer = organizer;
    }

    public String getFullname() {
        return fullName;
    }

    public void setFullname(String fullname) {
        this.fullName = fullname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public EventType getType() {
        return type;
    }

    public void setType(EventType type) {
        this.type = type;
    }

    public EventLocation getLocation() {
        return location;
    }

    public void setLocation(EventLocation location) {
        this.location = location;
    }

    public Date getDateOfEvent() {
        return dateOfEvent;
    }

    public void setDateOfEvent(Date dateOfEvent) {
        this.dateOfEvent = dateOfEvent;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public int getGuestRegisterLimit() {
        return guestRegisterLimit;
    }

    public void setGuestRegisterLimit(int guestRegisterLimit) {
        this.guestRegisterLimit = guestRegisterLimit;
    }

    public Date getRegisterDeadline() {
        return registerDeadline;
    }

    public void setRegisterDeadline(Date registerDeadline) {
        this.registerDeadline = registerDeadline;
    }

    public int getGuestAttendedCount() {
        return guestAttendedCount;
    }

    public void setGuestAttendedCount(int guestAttendedCount) {
        this.guestAttendedCount = guestAttendedCount;
    }

    @Override
    public String toString() {
        return "Event{" + "id=" + id + ", organizer=" + organizer + ", fullname=" + fullName + ", description=" + description + ", type=" + type + ", location=" + location + ", dateOfEvent=" + dateOfEvent + ", startTime=" + startTime + ", endTime=" + endTime + ", guestRegisterLimit=" + guestRegisterLimit + ", registerDeadline=" + registerDeadline + ", guestAttendedCount=" + guestAttendedCount + '}';
    }
}