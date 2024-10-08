/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.enums.Status;
import com.fuem.models.Location;
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
    private int collaboratorRegisterLimit;
    private LocalDate collaboratorRegisterDeadline;
    private List<String> images;

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

    public Event(String fullname, String organizerAcronym, String avatarPath, LocalDate dateOfEvent) {
        this.fullname = fullname;
        this.organizer = new Organizer();
        this.organizer.setAcronym(organizerAcronym);
        this.organizer.setAvatarPath(avatarPath);
        this.dateOfEvent = dateOfEvent;
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

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return "Event{" + "id=" + id + ", organizer=" + organizer + ", fullname=" + fullname + ", description="
                + description + ", category=" + category + ", location=" + location + ", dateOfEvent=" + dateOfEvent
                + ", startTime=" + startTime + ", endTime=" + endTime + ", guestRegisterLimit=" + guestRegisterLimit
                + ", guestRegisterDeadline=" + guestRegisterDeadline + ", collaboratorRegisterLimit=" + collaboratorRegisterLimit
                + ", images="
                + images + '}';
    }
}