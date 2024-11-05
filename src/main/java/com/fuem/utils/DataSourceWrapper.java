/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public class DataSourceWrapper {
    
    private static HikariDataSource dataSource;
    
    static {
        try {
            String driverClass = ConfigurationGetter.getProperty("db.driver");
            System.out.println("driver " + driverClass);
            Logger.getLogger(DataSourceWrapper.class.getName()).log(Level.CONFIG, driverClass);
            String connectionString = ConfigurationGetter.getConnectionString();
            System.out.println("connectioStr " + connectionString);
            Logger.getLogger(DataSourceWrapper.class.getName()).log(Level.CONFIG, connectionString);
            
            HikariConfig config = new HikariConfig();
            config.setDriverClassName(driverClass);
            config.setJdbcUrl(connectionString);
            config.setConnectionTimeout(20000);
            config.setIdleTimeout(600000);
            config.setMaxLifetime(1800000);
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(5);
            dataSource = new HikariDataSource(config);
        } catch (Exception e) {
            Logger.getLogger(DataSourceWrapper.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
    public static HikariDataSource getDataSource() {
        return dataSource;
    }
    
    public static void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}
