/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.models.EventLocation;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author hoang hung
 */
public class Event {

    private int id;
    private Organizer organizer;
    private String fullname;
    private String description;
    private EventType type;
    private String status;
    private EventLocation location;
    private LocalDate dateOfEvent;
    private LocalTime startTime;
    private LocalTime endTime;
    private int guestRegisterLimit;
    private int guestRegisterCount;
    private LocalDateTime registerDeadline;
    private int collaboratorRegisterLimit;
    private List<String> images;

    public Event() {
    }

    public Event(int id, Organizer organizer, String fullname, String description, EventType type,
            EventLocation location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime,
            int guestRegisterLimit,
            LocalDateTime registerDeadline, int guestAttendedCount, int collaboratorRegisterLimit,
            List<String> images) {
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
    }

    public Event(String fullname, String organizerAcronym, String avatarPath, LocalDate dateOfEvent) {
        this.fullname = fullname;
        this.organizer = new Organizer();
        this.organizer.setAcronym(organizerAcronym);
        this.organizer.setAvatarPath(avatarPath);
        this.dateOfEvent = dateOfEvent;
    }

    public Event(int id, Organizer organizer, String fullname, String description, EventType type, EventLocation location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime, int guestRegisterLimit, LocalDateTime registerDeadline) {
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
    }
    
    public Event(String fullname, LocalDate dateOfEvent, String locationName, String category){
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.location = new EventLocation();
        this.location.setDescription(locationName);
        this.type = new EventType();
        this.type.setName(category);
    }
    
     public Event(int id, String fullname, LocalDate dateOfEvent, String locationName, String category, String status, int registerLimit, int registerCount){
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.location = new EventLocation();
        this.location.setDescription(locationName);
        this.type = new EventType();
        this.type.setName(category);
        this.status = status;
        this.guestRegisterLimit = registerLimit;
        this.guestRegisterCount = registerCount;
    }
     
    public Event(int id, String clubName, String avatarPath, String fullname, LocalDate dateOfEvent, String category, String location, String status){
        this.id = id;
        this.organizer = new Organizer();
        this.organizer.setFullname(clubName);
        this.organizer.setAvatarPath(avatarPath);
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.type = new EventType();
        this.type.setName(category);
        this.location = new EventLocation();
        this.location.setDescription(location);
        this.status = status; 
    }
    
    public Event(String eventName, String clubName, LocalDate dateOfEvent, String location, String category){
        this.fullname = eventName;
        this.organizer = new Organizer();
        this.organizer.setAcronym(clubName);
        this.dateOfEvent = dateOfEvent;
        this.location = new EventLocation();
        this.location.setDescription(location);
        this.type = new EventType();
        this.type.setName(category);
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

    public LocalDate getDateOfEvent() {
        return dateOfEvent;
    }

    public void setDateOfEvent(LocalDate dateOfEvent) {
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getGuestRegisterLimit() {
        return guestRegisterLimit;
    }

    public void setGuestRegisterLimit(int guestRegisterLimit) {
        this.guestRegisterLimit = guestRegisterLimit;
    }

    public int getGuestRegisterCount() {
        return guestRegisterCount;
    }

    public void setGuestRegisterCount(int guestRegisterCount) {
        this.guestRegisterCount = guestRegisterCount;
    }

    public LocalDateTime getRegisterDeadline() {
        return registerDeadline;
    }

    public void setRegisterDeadline(LocalDateTime registerDeadline) {
        this.registerDeadline = registerDeadline;
    }

    public int getCollaboratorRegisterLimit() {
        return collaboratorRegisterLimit;
    }

    public void setCollaboratorRegisterLimit(int collaboratorRegisterLimit) {
        this.collaboratorRegisterLimit = collaboratorRegisterLimit;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return "Event{" + "id=" + id + ", organizer=" + organizer + ", fullname=" + fullname + ", description="
                + description + ", type=" + type + ", location=" + location + ", dateOfEvent=" + dateOfEvent
                + ", startTime=" + startTime + ", endTime=" + endTime + ", guestRegisterLimit=" + guestRegisterLimit
                + ", registerDeadline=" + registerDeadline + ", collaboratorRegisterLimit=" + collaboratorRegisterLimit
                + ", images="
                + images + '}';
    }
}
