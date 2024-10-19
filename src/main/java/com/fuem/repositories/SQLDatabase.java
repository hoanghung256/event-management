/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public abstract class SQLDatabase {

    public SQLDatabase() {
    }

    private boolean checkNString(String des) {
        for (int i = 0; i < des.length(); i++) {
            if (des.charAt(i) >= 128) {
                return true;
            }
        }
        return false;
    }

    public PreparedStatement getPreparedStatement(PreparedStatement statement, Connection conn, String sql, Object... values) {
        if (conn == null) {
            return null;
        }
        
        try {
            if (statement == null) {
                statement = conn.prepareStatement(sql);
            }

            if (values.length == 0) {
                return statement;
            }

            for (int i = 0;i < values.length; i++) {
                if (values[i] == null) {
                    statement.setNull(i + 1, Types.NULL);
                }  else if (values[i] instanceof Character) {
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
                } else if (values[i] instanceof java.util.Date) {
                    statement.setTimestamp(i + 1, new Timestamp(((java.util.Date) values[i]).getTime()));
                } else if (values[i] instanceof java.sql.Date) {
                    statement.setTimestamp(i + 1, new Timestamp(((java.util.Date) values[i]).getTime()));
                } else if (values[i] instanceof LocalDate) {
                    statement.setDate(i + 1, Date.valueOf((LocalDate) values[i]));
                } else if (values[i] instanceof LocalTime) {
                    statement.setTime(i + 1, Time.valueOf((LocalTime) values[i]));
                } else if (values[i] instanceof LocalDateTime) {
                    statement.setTimestamp(i + 1, Timestamp.valueOf((LocalDateTime) values[i]));
                } else {
                    statement.setObject(i + 1, values[i].toString());
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return statement;
    }

    public void executePreparedStatement(Connection conn, String sql, Object... values) {
        try {
            getPreparedStatement(null, conn, sql, values).execute();
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }

    }

    /**
     * Use for INSERT, UPDATE, DELETE action
     *
     * @return number of changed records
     */
    public int executeUpdatePreparedStatement(Connection conn, String sql, Object... values) {
        int i = -1;
        try {
            PreparedStatement stm = getPreparedStatement(null, conn, sql, values);
            i = stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }

        return i;
    }

    /**
     * Use for SELECT action
     */
    public ResultSet executeQueryPreparedStatement(Connection conn, String sql, Object... values) {
        ResultSet rs = null;

        try {
            PreparedStatement ps = getPreparedStatement(null, conn, sql, values);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(SQLDatabase.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }
}
