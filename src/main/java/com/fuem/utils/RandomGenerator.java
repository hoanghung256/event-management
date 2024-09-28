/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

/**
 *
 * @author hoang hung
 */
public class RandomGenerator {
    
    private static final String[] SEED = {"abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "0123456789"};
    public static final int NUMERIC = 1;
    public static final int LOWERCASE = 2;
    public static final int UPPERCASE = 3;
    
    public static String generate(int type, int length) {
        String seed = "";
        StringBuilder result = new StringBuilder();
        
        if (type == NUMERIC) {
            seed = SEED[2];
        } else if (type == LOWERCASE) {
            seed = SEED[0];
        } else if (type == UPPERCASE) {
            seed = SEED[1];
        }
        
        for (int i = 0; i < length; i++) {
            result.append(seed.charAt(randomNumber(0, seed.length())));
        }
        return result.toString();
    }
    
    public static int randomNumber(int min, int max) {
        return (int) (Math.random() * (max)) + min;
    }
}
