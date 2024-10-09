/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

/**
 *
 * @author ADMIN
 */
public class UserGoogle{
    private String id;
    private String email;
    private String name;
    private String given_name;
    private String family_name;
    private String picture;
    private boolean verified_email;


    public UserGoogle() {
    }


    public UserGoogle(String id, String email, String name, String given_name, String family_name, String picture, boolean verified_email) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.given_name = given_name;
        this.family_name = family_name;
        this.picture = picture;
        this.verified_email = verified_email;
    }


    public String getId() {
        return id;
    }


    public void setId(String id) {
        this.id = id;
    }


    public String getEmail() {
        return email;
    }


    public void setEmail(String email) {
        this.email = email;
    }


    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }


    public String getGiven_name() {
        return given_name;
    }


    public void setGiven_name(String given_name) {
        this.given_name = given_name;
    }


    public String getFamily_name() {
        return family_name;
    }


    public void setFamily_name(String family_name) {
        this.family_name = family_name;
    }


    public String getPicture() {
        return picture;
    }


    public void setPicture(String picture) {
        this.picture = picture;
    }


    public boolean isVerified_email() {
        return verified_email;
    }


    public void setVerified_email(boolean verified_email) {
        this.verified_email = verified_email;
    }


    @Override
    public String toString() {
        return "UserGoogle{" + "id=" + id + ", email=" + email + ", name=" + name + ", given_name=" + given_name + ", family_name=" + family_name + ", picture=" + picture + ", verified_email=" + verified_email + '}';
    }
}