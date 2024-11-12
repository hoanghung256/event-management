/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public class ConfigurationGetter {

    private static Properties properties;

    private static void loadProperties() {
        if (properties == null) {
            properties = new Properties();
            try (InputStream input = ConfigurationGetter.class.getClassLoader().getResourceAsStream("application.properties")) {
                if (input != null) {
                    properties.load(input);
                }
            } catch (IOException e) {
                Logger.getLogger(ConfigurationGetter.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public static String getProperty(String key) {
        if (properties == null) {
            loadProperties();
        }
        return properties.getProperty(key);
    }

    public static String getConnectionString() {
        String server = getProperty("db.server");
        String databaseName = getProperty("db.database");
        String username = getProperty("db.username");
        String password = getProperty("db.password");

        return "jdbc:sqlserver://" + server + ":1433;database=" + databaseName + ";encrypt=true;trustServerCertificate=true;loginTimeout=30;user=" + username + ";password=" + password;
    }
}
