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

    private static Properties properties;
    private static final Logger logger = Logger.getLogger(Configuration.class.getName());

    private static void loadProperties() {
        if (properties == null) {
            properties = new Properties();
            try (InputStream input = Configuration.class.getClassLoader().getResourceAsStream("application.properties")) {
                if (input != null) {
                    properties.load(input);
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, null, e);
            }
        }
    }

    public static String getProperty(String key) {
        if (properties == null) {
            loadProperties();
        }
        return properties.getProperty(key);
    }
}
