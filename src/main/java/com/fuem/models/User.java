/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.enums.Role;

/**
 *
 * @author hoang hung
 */
public abstract class User {
    
    private int id;
    private String fullname;
    private String email;
    private String password;
    private String avatarPath;
    private Role role;

    public User() {
    }
    
    public User(int id) {
        this.id = id;
    }
    
    public User(String fullname, String email, String password) {
        this.fullname = fullname;
        this.email = email;
        this.password = password;
    }
    
    public User(int id, String fullname, String email, String avatarPath) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.avatarPath = avatarPath;
    }
    
    public User(int id, String fullname, String email, String password, String avatarPath) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.avatarPath = avatarPath;
    }
    
    public User(int id, String fullname, String email, String avatarPath, Role role) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.avatarPath = avatarPath;
        this.role = role;
    }

    public User(int id, String fullname, String email, String password, String avatarPath, Role role) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.avatarPath = avatarPath;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", fullname=" + fullname + ", email=" + email + ", password=" + password + ", avatarPath=" + avatarPath + ", role=" + role + '}';
    }
}
