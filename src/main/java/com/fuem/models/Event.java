/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.enums.Status;
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
    private Status status;
    private String description;
    private Category category;
    private Location location;
    private LocalDate dateOfEvent;
    private LocalTime startTime;
    private LocalTime endTime;
    private int guestRegisterLimit;
    private LocalDate guestRegisterDeadline;
    private int guestRegisterCount;
    private int collaboratorRegisterLimit;
    private LocalDate collaboratorRegisterDeadline;
    private int collaboratorRegisterCount;
    private List<String> images;
    private int guestAttendedCount;

    public Event() {
    }
    
    public Event(int id, Organizer organizer, String fullname, String description, Category category,
            Location location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime,
            int guestRegisterLimit,
            LocalDate guestRegisterDeadline, int guestAttendedCount, int collaboratorRegisterLimit,
            List<String> images) {
        this.id = id;
        this.organizer = organizer;
        this.fullname = fullname;
        this.description = description;
        this.category = category;
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
        this.guestRegisterLimit = guestRegisterLimit;
        this.guestRegisterDeadline = guestRegisterDeadline;
    }

    public Event(String fullname, String organizerAcronym, String organizerAvatarPath, LocalDate dateOfEvent) {
        this.fullname = fullname;
        this.organizer = new Organizer();
        this.organizer.setAcronym(organizerAcronym);
        this.organizer.setAvatarPath(organizerAvatarPath);
        this.dateOfEvent = dateOfEvent;
    }

    public Event(String fullname, String description, Category category, Location location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime) {
        this.fullname = fullname;
        this.description = description;
        this.category = category;
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public Event(int id, Organizer organizer, String fullname, String description, Category category, Location location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime, int guestRegisterLimit, LocalDate guestRegisterDeadline) {
        this.id = id;
        this.organizer = organizer;
        this.fullname = fullname;
        this.description = description;
        this.category = category;
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
        this.guestRegisterLimit = guestRegisterLimit;
        this.guestRegisterDeadline = guestRegisterDeadline;
    }
    
    public Event(int id, Organizer organizer, String fullname, Status status, String description, String category, Location location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime, int guestRegisterLimit, LocalDate guestRegisterDeadline, int guestRegisterCount, int collaboratorRegisterLimit, LocalDate collaboratorRegisterDeadline, int collaboratorRegisterCount, List<String> images) {
        this.id = id;
        this.organizer = organizer;
        this.fullname = fullname;
        this.status = status;
        this.description = description;
        this.category = new Category();
        this.category.setName(category);
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
        this.guestRegisterLimit = guestRegisterLimit;
        this.guestRegisterDeadline = guestRegisterDeadline;
        this.guestRegisterCount = guestRegisterCount;
        this.collaboratorRegisterLimit = collaboratorRegisterLimit;
        this.collaboratorRegisterDeadline = collaboratorRegisterDeadline;
        this.collaboratorRegisterCount = collaboratorRegisterCount;
        this.images = images;
    }
    
    public Event(int eventId, String fullname, LocalDate dateOfEvent, String locationName, String category){
        this.id = eventId;
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.location = new Location();
        this.location.setDescription(locationName);
        this.category = new Category();
        this.category.setName(category);
    }
    
    public Event(int eventId, String fullname, LocalDate dateOfEvent, String clubName, String locationName, String category){
        this.id = eventId;
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.organizer = new Organizer();
        this.organizer.setAcronym(clubName);
        this.location = new Location();
        this.location.setDescription(locationName);
        this.category = new Category();
        this.category.setName(category);
    }
    
    public Event(int id, String fullname, LocalDate dateOfEvent, String locationName, String category, Status status, int registerLimit, int registerCount, LocalTime startTime, LocalTime endTime){
        this.id = id;
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.location = new Location();
        this.location.setDescription(locationName);
        this.category = new Category();
        this.category.setName(category);
        this.status = status;
        this.guestRegisterLimit = registerLimit;
        this.guestRegisterCount = registerCount;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public Event(Organizer organizer, String fullname, LocalDate dateOfEvent, String locationName, String category, Status status, int registerLimit, int registerCount, LocalTime startTime, LocalTime endTime){
        this.organizer = organizer;
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.location = new Location();
        this.location.setDescription(locationName);
        this.category = new Category();
        this.category.setName(category);
        this.status = status;
        this.guestRegisterLimit = registerLimit;
        this.guestRegisterCount = registerCount;
        this.startTime = startTime;
        this.endTime = endTime;
    }
     
    public Event(int id, String clubName, String avatarPath, String fullname, LocalDate dateOfEvent, String category, String location, Status status){
        this.id = id;
        this.organizer = new Organizer();
        //??
        this.organizer.setFullname(clubName);
        this.organizer.setAcronym(clubName);
        //??
        this.organizer.setAvatarPath(avatarPath);
        this.fullname = fullname;
        this.dateOfEvent = dateOfEvent;
        this.category = new Category();
        this.category.setName(category);
        this.location = new Location();
        this.location.setDescription(location);
        this.status = status; 
    }
    
    public Event(String eventName, String clubName, LocalDate dateOfEvent, String location, String category){
        this.fullname = eventName;
        this.organizer = new Organizer();
        this.organizer.setAcronym(clubName);
        this.dateOfEvent = dateOfEvent;
        this.location = new Location();
        this.location.setDescription(location);
        this.category = new Category();
        this.category.setName(category);
    }

    public Event(int id, String fullname, Location location, LocalDate dateOfEvent, LocalTime startTime, LocalTime endTime, int guestRegisterCount, int guestAttendedCount) {
        this.id = id;
        this.fullname = fullname;
        this.location = location;
        this.dateOfEvent = dateOfEvent;
        this.startTime = startTime;
        this.endTime = endTime;
        this.guestRegisterCount = guestRegisterCount;
        this.guestAttendedCount = guestAttendedCount;
    }

//    public Event(int eventId, String eventName, LocalDate eventDate, String locationName, String category) {
//       this.id = eventId;
//        this.fullname = eventName;
//        this.dateOfEvent = eventDate;
//        this.location = new Location(locationName);
//        this.category = new Category();
//        this.category.setName(category);
//    }
    
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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
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

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getGuestRegisterLimit() {
        return guestRegisterLimit;
    }

    public void setGuestRegisterLimit(int guestRegisterLimit) {
        this.guestRegisterLimit = guestRegisterLimit;
    }

    public LocalDate getRegisterDeadline() {
        return guestRegisterDeadline;
    }

    public void setRegisterDeadline(LocalDate guestRegisterDeadline) {
        this.guestRegisterDeadline = guestRegisterDeadline;
    }

    public int getCollaboratorRegisterLimit() {
        return collaboratorRegisterLimit;
    }

    public void setCollaboratorRegisterLimit(int collaboratorRegisterLimit) {
        this.collaboratorRegisterLimit = collaboratorRegisterLimit;
    }

    public LocalDate getGuestRegisterDeadline() {
        return guestRegisterDeadline;
    }

    public void setGuestRegisterDeadline(LocalDate guestRegisterDeadline) {
        this.guestRegisterDeadline = guestRegisterDeadline;
    }

    public int getGuestRegisterCount() {
        return guestRegisterCount;
    }

    public void setGuestRegisterCount(int guestRegisterCount) {
        this.guestRegisterCount = guestRegisterCount;
    }

    public LocalDate getCollaboratorRegisterDeadline() {
        return collaboratorRegisterDeadline;
    }

    public void setCollaboratorRegisterDeadline(LocalDate collaboratorRegisterDeadline) {
        this.collaboratorRegisterDeadline = collaboratorRegisterDeadline;
    }

    public int getCollaboratorRegisterCount() {
        return collaboratorRegisterCount;
    }

    public void setCollaboratorRegisterCount(int collaboratorRegisterCount) {
        this.collaboratorRegisterCount = collaboratorRegisterCount;
    } 

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public int getGuestAttendedCount() {
        return guestAttendedCount;
    }

    public void setGuestAttendedCount(int guestAttendedCount) {
        this.guestAttendedCount = guestAttendedCount;
    }

    

    @Override
    public String toString() {
        return "Event{" + "id=" + id + ", organizer=" + organizer + ", fullname=" + fullname + ", status=" + status + ", description=" + description + ", category=" + category + ", location=" + location + ", dateOfEvent=" + dateOfEvent + ", startTime=" + startTime + ", endTime=" + endTime + ", guestRegisterLimit=" + guestRegisterLimit + ", guestRegisterDeadline=" + guestRegisterDeadline + ", guestRegisterCount=" + guestRegisterCount + ", collaboratorRegisterLimit=" + collaboratorRegisterLimit + ", collaboratorRegisterDeadline=" + collaboratorRegisterDeadline + ", collaboratorRegisterCount=" + collaboratorRegisterCount + ", images=" + images + '}';
    }
}
