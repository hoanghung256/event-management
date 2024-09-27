/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author hoang hung
 */
public class Cookies {
    
    public static void add(String name, Object o, int expiredHours, HttpServletResponse response) {
        try {
            String encodedValue = URLEncoder.encode(o.toString(), StandardCharsets.UTF_8.toString());
            System.out.println(encodedValue);
            Cookie cookie = new Cookie(name, encodedValue);

            cookie.setMaxAge(60 * 60 * expiredHours);
            cookie.setPath("/");

            response.addCookie(cookie);
        } catch (UnsupportedEncodingException e) {
            Logger.getLogger(Cookies.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
    public static Object get(String name, HttpServletRequest request) {
        Object rs = null;
        
        try {
            Cookie[] cookies = request.getCookies();

            for (Cookie c : cookies) {
                if (c.getName().equals(name)) {
                    String cookieValueToString = URLDecoder.decode(c.getValue(), StandardCharsets.UTF_8.toString());
                    rs = Cast.cast(cookieValueToString);
                }
            }
        } catch (UnsupportedEncodingException e) {
            Logger.getLogger(Cookies.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return rs;
    }
}
