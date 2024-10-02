/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author AnhNQ
 */

public class Organizer {
    private int id;
    private String acronym;
    private String fullname;
    private String description;
    private String email;
    private String password;
    private String avatarPath;
    private boolean isAdmin;

    public Organizer() {
    }

    public Organizer(int id, String acronym, String fullname, String description, String email, String password, String avatarPath, boolean isAdmin) {
        this.id = id;
        this.acronym = acronym;
        this.fullname = fullname;
        this.description = description;
        this.email = email;
        this.password = password;
        this.avatarPath = avatarPath;
        this.isAdmin = isAdmin;
    }
    
    public Organizer(int id, String acronym, String fullname, String description, String email, String avatarPath, boolean isAdmin) {
        this.id = id;
        this.acronym = acronym;
        this.fullname = fullname;
        this.description = description;
        this.email = email;
        this.avatarPath = avatarPath;
        this.isAdmin = isAdmin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAcronym() {
        return acronym;
    }

    public void setAcronym(String acronym) {
        this.acronym = acronym;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
<<<<<<< HEAD
}
=======

    @Override
    public String toString() {
        return "Organizer{" + "id=" + id + ", acronym=" + acronym + ", fullname=" + fullname + ", description=" + description + ", email=" + email + ", password=" + password + ", avatarPath=" + avatarPath + ", isAdmin=" + isAdmin + '}';
    }
    
}

>>>>>>> master
