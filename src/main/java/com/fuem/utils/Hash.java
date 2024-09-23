/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public class Hash {
    
    /**
     * Salt increase application security
     * prevent application from dictionary attacks and reverse hash table attacks
     */
    private static final String SALT = "ajngkjewfwopk23r940";
    
    /**
     * Because of security, the raw password like "password123321" will not be insert directly into database.
     * This function use to hash the raw password to hash code like "8e9f350a76779c757bc4d7d85f6868b1fc40c4db83bc123b32d19794a1437dc5" before.
     * 
     * The two case that need to use this function is
     * 1. When user sign up for the first time and provide a password, the string insert into database is the hash code of this password
     * 2. When user sign in, hash input password then compare to the hash code in database
     */
    public static String doHash(String input) {
        String rs = null;
        
        try {
            input += SALT;
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] inputBytes = md.digest(input.getBytes());

            BigInteger bigInt = new BigInteger(1, inputBytes);
            rs = bigInt.toString(16);
        } catch (NoSuchAlgorithmException e) {
            Logger.getLogger(Hash.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return rs;
    }
}
