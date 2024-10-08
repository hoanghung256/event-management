package com.fuem.repositories;

import com.fuem.models.Student;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StudentDAO extends SQLDatabase {
    
    private static final Logger logger = Logger.getLogger(StudentDAO.class.getName());
    private static final String SELECT_STUDENT_BY_EMAIL = "SELECT * FROM [Student] WHERE email = ?";
    private static final String SELECT_STUDENT_BY_EMAIL_AND_PASSWORD = "SELECT id, fullname, studentId, email, avatarPath FROM [Student] WHERE email = ? AND password = ?";
    private static final String SELECT_STUDENT_BY_STUDENT_ID = "SELECT * FROM [Student] WHERE studentId=?";
    private static final String UPDATE_PASSWORD_BY_EMAIL = "Update [Student] " +
                                                            "SET password = ? " +
                                                            "WHERE email = ?";
    private static final String INSERT_STUDENT = "INSERT INTO [Student] (fullname, studentId, email, password) VALUES (?, ?, ?, ?)";

    public StudentDAO() {
        super();
    }

    public void updatePassword(String email, String newPassword) {
        int updateRow = executeUpdatePreparedStatement(UPDATE_PASSWORD_BY_EMAIL, newPassword, email);
    }

    public Student getUserByEmail(String email) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_STUDENT_BY_EMAIL, email);
        Student user = null;

        try {
            while (rs.next()) {
                user = new Student(
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

    public Student getStudentByEmailAndPassword(String email, String password) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_STUDENT_BY_EMAIL_AND_PASSWORD, email, password);
        Student user = null;

        try {
            while (rs.next()) {
                user = new Student(
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


    public boolean addUser(Student user) {
        int result = executeUpdatePreparedStatement(INSERT_STUDENT, user.getFullname(), user.getStudentId(), user.getEmail(), user.getPassword());
        return result > 0; 
    }
    
    public boolean isStudentIdExist(String studentId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_STUDENT_BY_STUDENT_ID, studentId);

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
