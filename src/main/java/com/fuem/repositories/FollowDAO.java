/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Follow;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Administrator
 */
public class FollowDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(FollowDAO.class.getName());
    
    // Các câu truy vấn SQL
    private static final String SELECT_FOLLOW_BY_FOLLOWER_AND_FOLLOWED = "SELECT COUNT(*) FROM [Follow] WHERE [followerId] = ? AND [followedId] = ?";
    private static final String INSERT_FOLLOW = "INSERT INTO [Follow] ([followerId], [followedId]) VALUES (?, ?)";
    private static final String DELETE_FOLLOW = "DELETE FROM [Follow] WHERE [followerId] = ? AND [followedId] = ?";

    // Kiểm tra xem người dùng đã theo dõi tổ chức hay chưa
    public boolean isUserFollowing(int followerId, int followedId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_FOLLOW_BY_FOLLOWER_AND_FOLLOWED, followerId, followedId);
        try {
            if (rs.next()) {
                return rs.getInt(1) > 0; 
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking if user is following: ", e);
        }
        return false; // Nếu không có kết quả, trả về false
    }

    // Thêm theo dõi
    public void addFollow(int followerId, int followedId) {
        try (PreparedStatement pstmt = getConnection().prepareStatement(INSERT_FOLLOW)) {
            pstmt.setInt(1, followerId);
            pstmt.setInt(2, followedId);
            pstmt.executeUpdate(); // Thực thi câu lệnh insert
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding follow: ", e);
        }
    }

    // Xóa theo dõi
    public void removeFollow(int followerId, int followedId) {
        try (PreparedStatement pstmt = getConnection().prepareStatement(DELETE_FOLLOW)) {
            pstmt.setInt(1, followerId);
            pstmt.setInt(2, followedId);
            pstmt.executeUpdate(); // Thực thi câu lệnh delete
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error removing follow: ", e);
        }
    }
}