/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.models.EventLocation;
import java.sql.Timestamp;
/**
 *
 * @author hoang hung
 */
import java.sql.Date;

public class Event {
    
    private int id;
    private Organizer organizer;
    private String fullname;
    private String description;
    private EventType type;
    private EventLocation location;
    private Date dateOfEvent;
    private Timestamp startTime;
    private Timestamp endTime;
    private int guestRegisterLimit;
    private Date registerDeadline;
    private int guestAttendedCount;

    public Event(int id, Organizer organizer, String fullname, String description, EventType type, EventLocation location, Date dateOfEvent, Timestamp startTime, Timestamp endTime, int guestRegisterLimit, Date registerDeadline, int guestAttendedCount) {
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
    }
    
    public Event(String fullname, String organizerAcronym, String avatarPath, Date dateOfEvent){
        this.fullname = fullname;
        this.organizer = new Organizer();
        this.organizer.setAcronym(organizerAcronym);
        this.organizer.setAvatarPath(avatarPath);
        this.dateOfEvent = dateOfEvent;
    }
    
    public Event(){
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
    
    public String getAvatarPath() {
        return organizer != null ? organizer.getAvatarPath() : null;
    }
    
    public String getOrganizerName() {
        return organizer != null ? organizer.getAcronym() : null;
    }



    @Override
    public String toString() {
        return "Event{" + "id=" + id + ", organizer=" + organizer + ", fullname=" + fullname + ", description=" + description + ", type=" + type + ", location=" + location + ", dateOfEvent=" + dateOfEvent + ", startTime=" + startTime + ", endTime=" + endTime + ", guestRegisterLimit=" + guestRegisterLimit + ", registerDeadline=" + registerDeadline + ", guestAttendedCount=" + guestAttendedCount + '}';
    }
    
    public void print(){
        System.out.println("Event Name: " + fullname + ", Organizer Name: " + organizer.getAcronym() + ", Avatar Path: " + organizer.getAvatarPath() + ", Event Date: " + dateOfEvent); 
    }
}