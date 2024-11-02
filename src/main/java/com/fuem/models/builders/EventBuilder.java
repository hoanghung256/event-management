/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models.builders;

import com.fuem.enums.EventStatus;
import com.fuem.models.Category;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Organizer;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 *
 * @author hoang hung
 */
public class EventBuilder {

    private int id;
    private Organizer organizer;
    private String fullname;
    private EventStatus status;
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

    public EventBuilder setId(int id) {
        this.id = id;
        return this;
    }

    public EventBuilder setOrganizer(Organizer organizer) {
        this.organizer = organizer;
        return this;
    }

    public EventBuilder setFullname(String fullname) {
        this.fullname = fullname;
        return this;
    }

    public EventBuilder setStatus(EventStatus status) {
        this.status = status;
        return this;
    }

    public EventBuilder setDescription(String description) {
        this.description = description;
        return this;
    }

    public EventBuilder setCategory(Category category) {
        this.category = category;
        return this;
    }

    public EventBuilder setLocation(Location location) {
        this.location = location;
        return this;
    }

    public EventBuilder setDateOfEvent(LocalDate dateOfEvent) {
        this.dateOfEvent = dateOfEvent;
        return this;
    }

    public EventBuilder setStartTime(LocalTime startTime) {
        this.startTime = startTime;
        return this;
    }

    public EventBuilder setEndTime(LocalTime endTime) {
        this.endTime = endTime;
        return this;
    }

    public EventBuilder setGuestRegisterLimit(int guestRegisterLimit) {
        this.guestRegisterLimit = guestRegisterLimit;
        return this;
    }

    public EventBuilder setGuestRegisterDeadline(LocalDate guestRegisterDeadline) {
        this.guestRegisterDeadline = guestRegisterDeadline;
        return this;
    }

    public EventBuilder setGuestRegisterCount(int guestRegisterCount) {
        this.guestRegisterCount = guestRegisterCount;
        return this;
    }

    public EventBuilder setCollaboratorRegisterLimit(int collaboratorRegisterLimit) {
        this.collaboratorRegisterLimit = collaboratorRegisterLimit;
        return this;
    }

    public EventBuilder setCollaboratorRegisterDeadline(LocalDate collaboratorRegisterDeadline) {
        this.collaboratorRegisterDeadline = collaboratorRegisterDeadline;
        return this;
    }

    public EventBuilder setCollaboratorRegisterCount(int collaboratorRegisterCount) {
        this.collaboratorRegisterCount = collaboratorRegisterCount;
        return this;
    }

    public EventBuilder setImages(List<String> images) {
        this.images = images;
        return this;
    }

    public int getId() {
        return id;
    }

    public Organizer getOrganizer() {
        return organizer;
    }

    public String getFullname() {
        return fullname;
    }

    public EventStatus getStatus() {
        return status;
    }

    public String getDescription() {
        return description;
    }

    public Category getCategory() {
        return category;
    }

    public Location getLocation() {
        return location;
    }

    public LocalDate getDateOfEvent() {
        return dateOfEvent;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public int getGuestRegisterLimit() {
        return guestRegisterLimit;
    }

    public LocalDate getGuestRegisterDeadline() {
        return guestRegisterDeadline;
    }

    public int getGuestRegisterCount() {
        return guestRegisterCount;
    }

    public int getCollaboratorRegisterLimit() {
        return collaboratorRegisterLimit;
    }

    public LocalDate getCollaboratorRegisterDeadline() {
        return collaboratorRegisterDeadline;
    }

    public int getCollaboratorRegisterCount() {
        return collaboratorRegisterCount;
    }

    public List<String> getImages() {
        return images;
    }

    public Event build() {
        Event event = new Event();
        event.setId(this.id);
        event.setOrganizer(this.organizer);
        event.setFullname(this.fullname);
        event.setStatus(this.status);
        event.setDescription(this.description);
        event.setCategory(this.category);
        event.setLocation(this.location);
        event.setDateOfEvent(this.dateOfEvent);
        event.setStartTime(this.startTime);
        event.setEndTime(this.endTime);
        event.setGuestRegisterLimit(this.guestRegisterLimit);
        event.setGuestRegisterDeadline(this.guestRegisterDeadline);
        event.setGuestRegisterCount(this.guestRegisterCount);
        event.setCollaboratorRegisterLimit(this.collaboratorRegisterLimit);
        event.setCollaboratorRegisterDeadline(this.collaboratorRegisterDeadline);
        event.setCollaboratorRegisterCount(this.collaboratorRegisterCount);
        event.setImages(this.images);
        return event;
    }
}
