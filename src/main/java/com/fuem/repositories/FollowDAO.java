/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Follow;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

    // Các câu truy vấn SQL
    private static final String SELECT_FOLLOW_BY_FOLLOWER_AND_FOLLOWED = "SELECT COUNT(*) FROM [Follow] WHERE [followerId] = ? AND [followedId] = ?";
    private static final String INSERT_FOLLOW = "INSERT INTO [Follow] ([followerId], [followedId]) VALUES (?, ?)";
    private static final String DELETE_FOLLOW = "DELETE FROM [Follow] WHERE [followerId] = ? AND [followedId] = ?";

    // Kiểm tra xem người dùng đã theo dõi tổ chức hay chưa
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

    public void addFollow(int userId, int organizerId) {
        try (PreparedStatement statement = getPreparedStatement(INSERT_FOLLOW, userId, organizerId)) {
            if (statement != null) {
                statement.executeUpdate();
            } else {
                logger.log(Level.SEVERE, "PreparedStatement is null, cannot execute addFollow.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding follow: ", e);
        }
    }

    // Xóa theo dõi
    public void removeFollow(int userId, int organizerId) {
        try (PreparedStatement statement = getPreparedStatement(DELETE_FOLLOW, userId, organizerId)) {
            if (statement != null) {
                statement.executeUpdate();
            } else {
                logger.log(Level.SEVERE, "PreparedStatement is null, cannot execute removeFollow.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error removing follow: ", e);
        }
    }

    private PreparedStatement getPreparedStatement(String INSERT_FOLLOW, int userId, int organizerId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
