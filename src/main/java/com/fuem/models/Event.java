/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.models.EventLocation;
import com.fuem.models.Organizer;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;


/**
 *
 * @author hoang hung
 */
import java.util.Date;
import java.util.List;

public class Event {
    
    private int id;
    private Organizer organizer;
    private String fullname;
    private String description;
    private EventType type;
    private EventLocation location;
    private Date dateOfEvent;
    private LocalTime startTime;
    private LocalTime endTime;
    private int guestRegisterLimit;
    private LocalDateTime registerDeadline;
    private int guestAttendedCount;
    private List<String> images;

    public Event() {
    }

    public Event(int id, Organizer organizer, String fullname, String description, EventType type, EventLocation location, Date dateOfEvent, LocalTime startTime, LocalTime endTime, int guestRegisterLimit, LocalDateTime registerDeadline, int guestAttendedCount, List<String> images) {
        this.id = id;
        this.organizer = organizer;
        this.fullname = fullname;
        this.description = description;
        this.type = type;
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
        this.guestRegisterLimit = guestRegisterLimit;
        this.registerDeadline = registerDeadline;
        this.guestAttendedCount = guestAttendedCount;
        this.images = images;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Organizer getOrganizer() {
        return organizer;
    }

    public void setOrganizer(Organizer organizer) {
        this.organizer = organizer;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public int getGuestRegisterLimit() {
        return guestRegisterLimit;
    }

    public void setGuestRegisterLimit(int guestRegisterLimit) {
        this.guestRegisterLimit = guestRegisterLimit;
    }

    public LocalDateTime getRegisterDeadline() {
        return registerDeadline;
    }

    public void setRegisterDeadline(LocalDateTime registerDeadline) {
        this.registerDeadline = registerDeadline;
    }

    public int getGuestAttendedCount() {
        return guestAttendedCount;
    }

    public void setGuestAttendedCount(int guestAttendedCount) {
        this.guestAttendedCount = guestAttendedCount;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return "Event{" + "id=" + id + ", organizer=" + organizer + ", fullname=" + fullname + ", description=" + description + ", type=" + type + ", location=" + location + ", dateOfEvent=" + dateOfEvent + ", startTime=" + startTime + ", endTime=" + endTime + ", guestRegisterLimit=" + guestRegisterLimit + ", registerDeadline=" + registerDeadline + ", guestAttendedCount=" + guestAttendedCount + ", images=" + images + '}';
    }

    
}