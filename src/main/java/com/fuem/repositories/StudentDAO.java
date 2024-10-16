package com.fuem.repositories;

import com.fuem.enums.Gender;
import com.fuem.enums.Role;
import com.fuem.models.Student;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import com.fuem.utils.Hash;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StudentDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(StudentDAO.class.getName());
    private static final String SELECT_STUDENT_BY_EMAIL = "SELECT * FROM [Student] WHERE email = ?";
    private static final String SELECT_STUDENT_BY_EMAIL_AND_PASSWORD = "SELECT id, fullname, studentId, email, avatarPath FROM [Student] WHERE email = ? AND password = ?";
    private static final String SELECT_STUDENT_BY_STUDENT_ID = "SELECT * FROM [Student] WHERE studentId=?";
    private static final String UPDATE_PASSWORD_BY_EMAIL = "Update [Student] "
            + "SET password = ? "
            + "WHERE email = ?";
    private static final String INSERT_STUDENT = "INSERT INTO [Student] (fullname, studentId, email, password) VALUES (?, ?, ?, ?)";
    private static final String SELECT_STUDENTS = "SELECT "
            + "id, "
            + "fullname, "
            + "studentId, "
            + "email, "
            + "gender, "
            + "COUNT (*) OVER() AS 'TotalRow' "
            + "FROM [Student] "
            + "WHERE  COALESCE(studentId, '') LIKE '%' + COALESCE(?, '') + '%' OR  COALESCE(fullname, '') LIKE '%' + COALESCE(?, '') + '%'\n"
            + "ORDER BY id ASC\n"
            + "OFFSET ? ROWS\n"
            + "FETCH NEXT ? ROWS ONLY";
    private static final String DELETE_STUDENT_BY_ID = "DELETE FROM [Student] WHERE studentId = ?";
    private static final String UPDATE_STUDENT_BY_ID = "UPDATE Student SET fullname = ?, email = ?, studentId = ?, gender= ? WHERE  id = ?";

    public StudentDAO() {
        super();
    }

    public void updatePassword(String email, String newPassword) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            executeUpdatePreparedStatement(conn, UPDATE_PASSWORD_BY_EMAIL, newPassword, email);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
    }

    public Student getUserByEmail(String email) {
        Student student = null;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STUDENT_BY_EMAIL, email);) {
            while (rs.next()) {
                student = new Student(
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

        return student;
    }

    public Student getStudentByEmailAndPassword(String email, String password) {
        Student user = null;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STUDENT_BY_EMAIL_AND_PASSWORD, email, password);) {
            while (rs.next()) {
                user = new Student(
                        rs.getInt("id"),
                        rs.getString("fullname"),
                        rs.getString("studentId"),
                        rs.getString("email"),
                        rs.getString("avatarPath"),
                        Role.STUDENT
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return user;
    }

    public boolean addUser(Student user) {
        int result = 0;
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            result = executeUpdatePreparedStatement(conn, INSERT_STUDENT, user.getFullname(), user.getStudentId(), user.getEmail(), user.getPassword());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return result > 0;
    }

    public boolean isStudentIdExist(String studentId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STUDENT_BY_STUDENT_ID, studentId);) {
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return false;
    }

    /**
     * @author TrinhHuy
     */
    public Page<Student> getStudents(PagingCriteria pagingCriteria, String searchKeyword) {
        Page<Student> page = new Page<>();
        ArrayList<Student> students = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STUDENTS, searchKeyword, searchKeyword, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {

            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                Student student = new Student(
                        rs.getInt("id"),
                        rs.getString("studentId"),
                        Gender.valueOf(rs.getString("gender")),
                        rs.getString("fullname"),
                        rs.getString("email")
                );
                students.add(student);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(students);

        return page;
    }

    /**
     * @author; TrinhHuy
     */
    public boolean deleteStudentById(String studentId) {
        int affectedRows = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            affectedRows = executeUpdatePreparedStatement(conn, DELETE_STUDENT_BY_ID, studentId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return affectedRows > 0;
    }

    /**
     * @author; TrinhHuy
     */
    public boolean addStudent(Student user) {
        int result = 0;
        String sqlInsert = "INSERT INTO Student (fullname, studentId, email, password, gender) VALUES (?, ?, ?, ?, ?)";
        String sqlCheck = "SELECT COUNT(*) FROM Student WHERE email = ? OR studentId = ?";

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            // Kiểm tra xem email hoặc studentId đã tồn tại chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(sqlCheck)) {
                checkStmt.setString(1, user.getEmail());
                checkStmt.setString(2, user.getStudentId());
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;
                }
            }

            // Nếu không tồn tại, thực hiện câu lệnh chèn
            try (PreparedStatement pstmt = conn.prepareStatement(sqlInsert)) {
                String hashedPassword = Hash.doHash(user.getPassword());

                // Đặt các tham số cho PreparedStatement
                pstmt.setString(1, user.getFullname());
                pstmt.setString(2, user.getStudentId());
                pstmt.setString(3, user.getEmail());
                pstmt.setString(4, hashedPassword);
                pstmt.setString(5, user.getGender().toString());

                result = pstmt.executeUpdate();
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error inserting student", e);
        }

        return result > 0;
    }

    /**
     * @author TrinhHuy
     */
    public boolean updateStudent(Student student) {

        int result = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            result = executeUpdatePreparedStatement(conn, UPDATE_STUDENT_BY_ID, student.getFullname(), student.getEmail(), student.getStudentId(), student.getGender(), student.getId());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating student", e);
            throw new RuntimeException("Error updating student", e);
        }

        return result > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
    }
}
