/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.enums.Gender;
import com.fuem.enums.Role;

/**
 *
 * @author AnhNQ
 */
public class Student extends User{
    
    private String studentId;
    private Gender gender;

    public Student() {
    }
    
    public Student(int id) {
        super(id);
    }

    public Student(String studentId, Gender gender, int id) {
        super(id);
        this.studentId = studentId;
        this.gender = gender;
    }

    public Student(int id, String studentId, Gender gender, String fullname, String email) {
        super(fullname, id, email);
        this.studentId = studentId;
        this.gender = gender;
    }

    public Student(String fullname, String studentId, String email, String password) {
        super(fullname, email, password);
        this.studentId = studentId;
    }

   
    
  
    public Student(int id, String fullname, String studentId, String email, String avatarPath, Role role ) {
        super(id, fullname, email, avatarPath, role);
        this.studentId = studentId;
    }

    public Student(int id, String fullname, String studentId, String email,  String avatarPath) {
        super(id, fullname, email, avatarPath);
        this.studentId = studentId;
    }
    
    public Student(int id, String fullname, String studentId, Gender gender, String email,  String avatarPath) {
        super(id, fullname, email, avatarPath);
        this.studentId = studentId;
        this.gender = gender;
    }
     public Student(String fullname, String studentId, String email) {
        super(fullname, email, null); 
        this.studentId = studentId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public Gender getGender() {
        return gender;
    }
    

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "Student{" + super.toString() + "studentId=" + studentId + ", gender=" + gender + '}';
    }
}
