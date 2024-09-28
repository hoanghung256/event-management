package com.fuem.dao;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public class DatabaseConnection {
    private static Connection connection;
    private static final String URL = "jdbc:sqlserver://localhost:8080;database=EventManagement;encrypt=true;trustServerCertificate=true;loginTimeout=30;";

  
    private static final String USERNAME = "sa"; // Kiểm tra người dùng này
    private static final String PASSWORD = "30042004"; // Kiểm tra mật khẩu này
    
    public DatabaseConnection() {
    }
    
    public static void createConnection() {
        try {
            DriverManager.registerDriver(new SQLServerDriver());
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            Logger.getLogger(DatabaseConnection.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                createConnection();
            }    
        } catch (SQLException e) {
            Logger.getLogger(DatabaseConnection.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return connection;
    }
    
    public static void setConnection() {
        connection = getConnection();
    }
    
    public static void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            Logger.getLogger(DatabaseConnection.class.getName()).log(Level.SEVERE, null, e);
        }
    }
	
    public static void printInfo() {
        try {
            if (connection != null) {
                DatabaseMetaData mtdt = connection.getMetaData();
                System.out.println(mtdt.getDatabaseProductName());
                System.out.println(mtdt.getDatabaseProductVersion());
            }
        } catch (SQLException e) {
            Logger.getLogger(DatabaseConnection.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
