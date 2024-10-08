/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.enums.Role;

/**
 *
 * @author AnhNQ
 */

public class Organizer extends User {
    
    private String acronym;
    private String description;
    private String coverPath;

    public Organizer() {
    }

    public Organizer(int id, String acronym) {
        super(id);
        this.acronym = acronym;
    }

    public Organizer(int id, String acronym, String fullname, String description, String email, String password,
            String avatarPath, Role role) {
        super(id, fullname, email, password, avatarPath, role);
        this.acronym = acronym;
        this.description = description;
    }

    public Organizer(int id, String acronym, String fullname, String description, String email, String avatarPath, Role role) {
        super(id, fullname, email, avatarPath, role);
        this.acronym = acronym;
        this.description = description;
    }

    public String getAcronym() {
        return acronym;
    }

    public void setAcronym(String acronym) {
        this.acronym = acronym;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverPath() {
        return coverPath;
    }

    public void setCoverPath(String coverPath) {
        this.coverPath = coverPath;
    }

    @Override
    public String toString() {
        return "Organizer{" + super.toString() + "acronym=" + acronym + ", description=" + description + ", coverPath=" + coverPath + '}';
    }
}
