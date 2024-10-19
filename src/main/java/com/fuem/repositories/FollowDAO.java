/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TuDK
 */
public class FollowDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(FollowDAO.class.getName());

    private static final String SELECT_FOLLOW_BY_FOLLOWER_AND_FOLLOWED = "SELECT COUNT(*) FROM [Follow] WHERE [studentId] = ? AND [organizerId] = ?";
    private static final String INSERT_FOLLOW = "INSERT INTO [Follow] ([studentId], [organizerId]) VALUES (?, ?)";
    private static final String DELETE_FOLLOW = "DELETE FROM [Follow] WHERE [studentId] = ? AND [organizerId] = ?";

    /**
     * 
     * @author TuDK 
     */
    public boolean isUserFollowing(int followerId, int followedId) {
       try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
        ResultSet rs = executeQueryPreparedStatement(conn,SELECT_FOLLOW_BY_FOLLOWER_AND_FOLLOWED, followerId, followedId);) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking if user is following: ", e);
        }
        return false;
    }

    /**
     * 
     * @author TuDK 
     */
    public boolean doFollow(int studentId, int organizerId) {
        int rowChange = 0;
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, INSERT_FOLLOW, studentId, organizerId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding follow: ", e);
        }
        
        return (rowChange == 1);
    }

    /**
     * 
     * @author TuDK 
     */
    public boolean doUnfollow(int studentId, int organizerId) {
        int rowChange = 0;
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, DELETE_FOLLOW, studentId, organizerId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error removing follow: ", e);
        }
        
        return (rowChange == 1);
    }
}
