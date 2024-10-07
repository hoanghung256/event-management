/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

/**
 *
 * @author hoang hung
 */
public class DataSourceWrapper {
    
    private static HikariDataSource dataSource;
    
    static {
        HikariConfig config = new HikariConfig();
        config.setDriverClassName(Configuration.getProperty("db.driver"));
        config.setJdbcUrl(Configuration.getProperty("db.url"));
        config.setUsername(Configuration.getProperty("db.user"));
        config.setPassword(Configuration.getProperty("db.password"));
        config.setConnectionTimeout(20000);
        config.setIdleTimeout(600000);
        config.setMaxLifetime(1800000);
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(5);
        dataSource = new HikariDataSource(config);
    }
    
    public static HikariDataSource getDataSource() {
        return dataSource;
    }
}