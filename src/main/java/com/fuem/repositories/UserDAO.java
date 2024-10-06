package com.fuem.repositories;

import com.fuem.models.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO extends SQLDatabase {
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM [User] WHERE email = ?";
    private static final String SELECT_USER_BY_EMAIL_AND_PASSWORD = "SELECT id, fullname, studentId, email, avatarPath FROM [User] WHERE email = ? AND password = ?";
    private static final String SELECT_USER_BY_STUDENT_ID = "SELECT * FROM [User] WHERE studentId=?";
    private static final String UPDATE_PASSWORD_BY_EMAIL = "Update [User] " +
            "SET password = ? " +
            "WHERE email = ?";
    private static final String INSERT_USER = "INSERT INTO [User] (fullname, studentId, email, password) VALUES (?, ?, ?, ?)";

    public UserDAO() {
        super();
    }
    
    // Check email
    public boolean isEmailInDatabase(String toEmail) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_USER_BY_EMAIL, toEmail);

        try {
            while (rs.next()) {
                return toEmail.equalsIgnoreCase(rs.getString("email"));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, toEmail, e);
        }

        return false;
    }

    public void updatePassword(String email, String newPassword) {
        int updateRow = executeUpdatePreparedStatement(UPDATE_PASSWORD_BY_EMAIL, newPassword, email);
    }

    public User getUserByEmail(String email) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_USER_BY_EMAIL, email);
        User user = null;

        try {
            while (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("fullname"),
                        rs.getString("studentId"),
                        rs.getString("email"),
                        rs.getString("avatarPath")
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return user;
    }

    // Lấy thông tin người dùng qua email và mật khẩu
    public User getUserByEmailAndPassword(String email, String password) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_USER_BY_EMAIL_AND_PASSWORD, email, password);
        User user = null;

        try {
            while (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("fullname"),
                        rs.getString("studentId"),
                        rs.getString("email"),
                        rs.getString("avatarPath")
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return user;
    }

    public boolean isEmailAndPasswordExist(String email, String password) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_USER_BY_EMAIL_AND_PASSWORD, email, password);

        try {
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return false;
    }

    // Phương thức thêm người dùng mới vào cơ sở dữ liệu
    public boolean addUser(User user) {
        int result = executeUpdatePreparedStatement(INSERT_USER, user.getFullname(), user.getStudentId(), user.getEmail(), user.getPassword());
        return result > 0; 
    }
    
    public boolean isStudentIdExist(String studentId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_USER_BY_STUDENT_ID, studentId);

        try {
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return false;
    }
}
