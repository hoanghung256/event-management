/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author AnhNQ
 */
public class User {
    private int id;
    private String fullName;
    private String studentId;
    private String email;
    private String password;
    private String avatarPath;
    private boolean isClubPresident;
    private boolean isAdmin;

    public User() {
    }

    public User(int id, String fullName, String studentId, String email, String password, String avatarPath, boolean isClubPresident, boolean isAdmin) {
        this.id = id;
        this.fullName = fullName;
        this.studentId = studentId;
        this.email = email;
        this.password = password;
        this.avatarPath = avatarPath;
        this.isClubPresident = isClubPresident;
        this.isAdmin = isAdmin;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
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

    public boolean isIsClubPresident() {
        return isClubPresident;
    }

    public void setIsClubPresident(boolean isClubPresident) {
        this.isClubPresident = isClubPresident;
    }

    public boolean isIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", studentId='" + studentId + '\'' +
                ", email='" + email + '\'' +
                ", avatarPath='" + avatarPath + '\'' +
                ", isClubPresident=" + isClubPresident +
                ", isAdmin=" + isAdmin +
                '}';
    }

}
