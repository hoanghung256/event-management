/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public class Configuration {
    
    private static Properties properties = new Properties();
    private static Logger logger = Logger.getLogger(Configuration.class.getName());
    
    static {
        try (InputStream input = Configuration.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, null, e);
        }
    }
    
    private static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    public static String getDatabaseConnectUrl() {
        String url = Configuration.getProperty("db.url");
        String user = Configuration.getProperty("db.user");
        String password = Configuration.getProperty("db.password");
        
        return url + ";user=" + user + ";password=" + password + ";";
    }
}
