/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

/**
 *
 * @author hoang hung
 */
public class Validator {
    
    public static boolean isEmailBelongFPT(String email) {
        String[] emailSplits = email.split("@");
        
        return "fpt.edu.vn".equalsIgnoreCase(emailSplits[1]);
    }
}
