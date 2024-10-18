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
    private static final String SELECT_STUDENT_BY_ID = "SELECT fullname, studentId, email, gender, avatarPath FROM [Student] WHERE id=?";
    private static final String CHECK_PASSWORD_QUERY = "SELECT * FROM Student WHERE email = ? AND password = ?";
  
    public StudentDAO() {
        super();
    }

    public boolean checkCurrentPassword(String email, String currentPasswordHash) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(CHECK_PASSWORD_QUERY)) {
             
            pstmt.setString(1, email);
            pstmt.setString(2, currentPasswordHash);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next(); 
            }
        } catch (SQLException e) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

public void updatePassword(String email, String newPassword) {
    try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
         PreparedStatement pstmt = conn.prepareStatement(UPDATE_PASSWORD_BY_EMAIL)) {
         
        pstmt.setString(1, hashedPassword);
        pstmt.setString(2, email);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                        rs.getString("gender") != null ? Gender.valueOf(rs.getString("gender")) : null,
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

    /**
     * @author; TrinhHuy
     */
    public List<Student> searchStudents(String searchValue) {
        List<Student> students = new ArrayList<>();

        // Sử dụng try-with-resources để đảm bảo tự động đóng kết nối
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); PreparedStatement pstmt = conn.prepareStatement(FIND_STUDENT)) {

            pstmt.setString(1, searchValue); // Gán giá trị cho studentId
            pstmt.setString(2, "%" + searchValue + "%"); // Gán giá trị cho fullname với ký tự đại diện

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng Student từ ResultSet
                    Student student = new Student(
                            rs.getInt("id"),
                            rs.getString("studentId"),
                            rs.getString("gender") == null ? null : Gender.valueOf(rs.getString("gender")),
                            rs.getString("fullname"),
                            rs.getString("email")
                    );
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching students", e);
            throw new RuntimeException("Error searching students", e); // Ném ngoại lệ để xử lý ở cấp cao hơn nếu cần
        }

        return students; // Trả về danh sách sinh viên tìm thấy
    }

    /**
     * 
     * @author HungHV 
     */
    public Student getStudentById(int id) {
        Student s = null;
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STUDENT_BY_ID, id)) {
            if (rs.next()) {
                s = new Student(
                        id,
                        rs.getNString("fullname"), 
                        rs.getString("studentId"), 
                        rs.getNString("email"), 
                        rs.getNString("avatarPath")
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        
        return s;
    }
}
