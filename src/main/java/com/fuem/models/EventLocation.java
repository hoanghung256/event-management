/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author hoang hung
 */
public class EventLocation {
    
    private int id;
    private String description;

    public EventLocation() {
    }
    
    public EventLocation(int id) {
        this.id = id;
    }

    public EventLocation(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "EventLocation{" + "id=" + id + ", description=" + description + '}';
    }
}
