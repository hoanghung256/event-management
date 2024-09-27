package com.fuem.dao;

import com.fuem.enums.Gender;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.fuem.models.User;
import java.sql.*;
import com.fuem.models.User;
import com.fuem.enums.Role;
import java.time.LocalDate;

public class UserDAO {

    private final Connection conn;

    public UserDAO() {
        this.conn = DatabaseConnection.getConnection();
    }

    // Phương thức để kiểm tra xem người dùng có tồn tại không
    public User getUserByUsernameAndPassword(String username, String password) {
        User user = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT * FROM [User] WHERE username = ? AND password = ?";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        "Not avaiable",
                        resultSet.getString("email"),
                        resultSet.getString("phone"),
                        Gender.valueOf(resultSet.getString("gender")),
                        resultSet.getTimestamp("dob").toLocalDateTime().toLocalDate(),
                        resultSet.getTimestamp("joinAt").toLocalDateTime().toLocalDate(),
                        resultSet.getString("avatarUrl"),
                        resultSet.getString("address"),
                        resultSet.getBoolean("isShop") ? Role.ADMIN : Role.STUDENT,
                        resultSet.getInt("balance")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user;
    }

    // Phương thức để lấy thông tin của một người dùng dựa trên username
    public User getUserByUsername(String username) {
        User user = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT * FROM [User] WHERE username = ?";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, username);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setUsername(resultSet.getString("username"));
                // Lấy thêm các thông tin khác của người dùng nếu cần
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user;
    }

    // Phương thức để thêm người dùng mới vào cơ sở dữ liệu
    public boolean addUser(User user) {
        boolean success = false;
        PreparedStatement preparedStatement = null;

        try {
            String sql = "INSERT INTO [User] (username, password, email) VALUES (?, ?, ?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                success = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return success;
    }

    public boolean isUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM [User] WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra xem email đã tồn tại chưa
    public boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM [User] WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void saveUser(User user) {
        String sql = "INSERT INTO [User](username, password, email, phone, gender, dob, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getGender().toString());
            statement.setDate(6, java.sql.Date.valueOf(user.getDob()));
            statement.setNString(7, user.getAddress());
            int a = statement.executeUpdate();
            System.out.println(a);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Gender getGenderFromString(String genderStr) {
        try {
            return Gender.valueOf(genderStr.toUpperCase());
        } catch (IllegalArgumentException | NullPointerException e) {

            return Gender.OTHER;
        }
    }

    public User getUserProfileByUsername(String username) {
        User user = null;
        String sql = "SELECT username, email, phone, gender, dob, address FROM [User] WHERE username = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User();
                    user.setUsername(resultSet.getString("username"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPhone(resultSet.getString("phone"));
                    user.setGender(getGenderFromString(resultSet.getString("gender")));
                    user.setDob(resultSet.getDate("dob").toLocalDate());
                    user.setAddress(resultSet.getString("address"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user;
    }

    // Các phương thức khác như update, delete có thể được triển khai tương tự
    // Đóng kết nối
    public void closeConnection() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public User getUserByEmail(String email) {
        User user = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT * FROM [User] WHERE email = ?";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, email);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        "Not available",
                        resultSet.getString("email"),
                        resultSet.getString("phone"),
                        Gender.valueOf(resultSet.getString("gender")),
                        resultSet.getTimestamp("dob").toLocalDateTime().toLocalDate(),
                        resultSet.getTimestamp("joinAt").toLocalDateTime().toLocalDate(),
                        resultSet.getString("avatarUrl"),
                        resultSet.getString("address"),
                        resultSet.getBoolean("isAdmin") ? Role.ADMIN : Role.STUDENT,
                        resultSet.getInt("balance")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user;
    }
}
