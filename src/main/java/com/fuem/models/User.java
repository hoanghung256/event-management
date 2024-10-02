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
    private String fullname; // Chỉnh sửa từ fullName thành fullname
    private String studentId;
    private String email;
    private String password;
    private String avatarPath;

    public User() {
    }

    public User(String fullname, String studentId, String email, String password) {
        this.fullname = fullname;
        this.studentId = studentId;
        this.email = email;
        this.password = password;
    }

  
    public User(int id, String fullname, String studentId, String email, String password, String avatarPath) {
        this.id = id;
        this.fullname = fullname;
        this.studentId = studentId;
        this.email = email;
        this.password = password;
        this.avatarPath = avatarPath;
    }

    public User(int id, String fullname, String studentId, String email,  String avatarPath) {
       this.id = id;
        this.fullname = fullname;
        this.studentId = studentId;
        this.email = email;
        this.avatarPath = avatarPath;
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

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", fullname=" + fullname + ", studentId=" + studentId + ", email=" + email + ", password=" + password + ", avatarPath=" + avatarPath + '}';
    }
}
