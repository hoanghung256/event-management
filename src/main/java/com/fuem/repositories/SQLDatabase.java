/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.utils.Configuration;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public abstract class SQLDatabase {

    private static Connection conn;
    
    public static Connection generateConnection() {
        try {
            Class<?> clazz = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            DriverManager.registerDriver((Driver) clazz.getDeclaredConstructor().newInstance());
            String url = Configuration.getDatabaseConnectUrl();
            
            conn =  DriverManager.getConnection(url);
        } catch (ClassNotFoundException | NoSuchMethodException | InstantiationException | SQLException | IllegalAccessException | IllegalArgumentException | InvocationTargetException ex) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }

    public Connection getConnection() {
        return conn;
    }

    /**
     * Check if it did connect
     *
     * @return
     */
    public boolean isConnected() {
        return conn != null;
    }

    public Statement getStatement() {
        Statement statement = null;
        try {
            statement = conn.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return statement;
    }

    private boolean checkNString(String des) {
        for (int i = 0; i < des.length(); i++) {
            if (des.charAt(i) >= 128) {
                return true;
            }
        }
        return false;
    }

    private PreparedStatement getPreparedStatement(String sql, Object... values) {
        if (conn == null) return null;
        
        PreparedStatement statement = null;
        
        try {
            statement = conn.prepareStatement(sql);

            if (values.length == 0) {
                return statement;
            }

            for (int i = 0; i < values.length; i++) {
                if (values[i] == null) {
                    if (values[i] instanceof Date) {
                        statement.setNull(i + 1, Types.DATE);
                    } else {
                        statement.setNull(i + 1, Types.NULL);
                    }
                } else if (values[i] instanceof Character) {
                    statement.setString(i + 1, values[i] + "");
                } else if (values[i] instanceof Integer) {
                    statement.setInt(i + 1, (int) values[i]);
                } else if (values[i] instanceof Double) {
                    statement.setDouble(i + 1, (double) values[i]);
                } else if (values[i] instanceof String) {
                    if (checkNString((String) values[i])) {
                        statement.setNString(i + 1, (String) values[i]);
                    } else {
                        statement.setString(i + 1, (String) values[i]);
                    }
                } else if (values[i] instanceof Date) {
                    statement.setString(i + 1, new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS").format((Date) values[i]));
                } else if (values[i] instanceof java.sql.Date) {
                    statement.setDate(i + 1, (java.sql.Date) values[i]);
                } else {
                    statement.setString(i + 1, values[i].toString());
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
            
        return statement;
    }

    public void executePreparedStatement(String sql, Object... values) {
        try {
            getPreparedStatement(sql, values).execute();
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }

    }

    /**
     * Use for INSERT, UPDATE, DELETE action
     * 
     * @return number of changed records
     */
    public int executeUpdatePreparedStatement(String sql, Object... values) {
        int i = -1;
        try {
            i = getPreparedStatement(sql, values).executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }

        return i;
    }

    /**
     * Use for SELECT action
     */
    public ResultSet executeQueryPreparedStatement(String sql, Object... values) {
        ResultSet rs = null;
        
        try {
            rs = getPreparedStatement(sql, values).executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }
    
    public static void closeConnection() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
