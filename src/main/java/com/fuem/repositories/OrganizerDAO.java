/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.enums.Role;
import com.fuem.models.Organizer;
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

/**
 *
 * @author ADMIN
 */
public class OrganizerDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(OrganizerDAO.class.getName());
    private static final String SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD = "SELECT id, acronym, fullname, description, email, avatarPath, isAdmin FROM [Organizer] WHERE email = ? AND password = ?";
    private static final String UPDATE_ORGANIZER = "UPDATE [Organizer] SET fullname = ?, acronym = ?, email = ?, description = ? WHERE id = ?";
    private static final String SELECT_ORGANIZER_BY_ID = "SELECT id, acronym, fullname, description, email, avatarPath, isAdmin FROM [Organizer] WHERE id = ?";
    private static final String UPDATE_STUDENT_BY_ID = "UPDATE Organizer SET fullname = ?,  acronym = ?, email = ? WHERE  id = ?";
    private static final String DELETE_ORGANIZER_BY_ID = "DELETE FROM [Organizer] WHERE id=?";
    private static final String SELECT_ORGANIZER = "SELECT "
            + "id, "
            + "fullname, "
            + "acronym, "
            + "email, "
            + "COUNT(*) OVER() AS TotalRow "
            + "FROM [Organizer] "
            + "WHERE COALESCE(fullname, '') LIKE '%' + COALESCE(?, '') + '%' "
            + "OR COALESCE(acronym, '') LIKE '%' + COALESCE(?, '') + '%' "
            + "ORDER BY id ASC "
            + "OFFSET ? ROWS "
            + "FETCH NEXT ? ROWS ONLY";

    public OrganizerDAO() {
        super();
    }

    public boolean isEmailAndPasswordExist(String email, String password) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD, email, password);) {
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return false;
    }

    public Organizer getOrganizerByEmailAndPassword(String email, String password) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD, email, password);) {
            while (rs.next()) {
                Organizer organizer = new Organizer(
                        rs.getInt("id"),
                        rs.getString("acronym"),
                        rs.getString("fullname"),
                        rs.getString("description"),
                        rs.getString("email"),
                        rs.getString("avatarPath"),
                        rs.getBoolean("isAdmin") ? Role.ADMIN : Role.CLUB);
                return organizer;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return null;
    }

    /**
     *
     * @author TuDK
     */
    public boolean updateOrganizer(Organizer organizer) {
        boolean isUpdated = false;
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {

            Object[] values = {
                organizer.getFullname(),
                organizer.getAcronym(),
                organizer.getEmail(),
                organizer.getDescription(),
                organizer.getId()
            };
            int rowsAffected = executeUpdatePreparedStatement(conn, UPDATE_ORGANIZER, values);
            isUpdated = rowsAffected > 0;
            return isUpdated;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return false;
    }

    /**
     * @author TuDK
     */
    public Organizer getOrganizerById(int organizerId) {

        Organizer organizer = null;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZER_BY_ID, organizerId);) {

            if (rs.next()) {
                organizer = new Organizer(
                        rs.getInt("id"),
                        rs.getString("acronym"),
                        rs.getString("fullname"),
                        rs.getString("description"),
                        rs.getString("email"),
                        rs.getString("avatarPath"),
                        rs.getBoolean("isAdmin") == true ? Role.ADMIN : Role.CLUB
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving organizer by ID: ", e);
        }

        return organizer;
    }

    /**
     * @author TrinhHuy
     */
    public Page<Organizer> getOrganizer(PagingCriteria pagingCriteria, String searchKeyword) {
        Page<Organizer> page = new Page<>();
        ArrayList<Organizer> organizers = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZER, searchKeyword, searchKeyword, pagingCriteria.getOffset(), pagingCriteria.getFetchNext())) {

            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }

                Organizer organizer = new Organizer(
                        rs.getInt("id"),
                        rs.getNString("fullname"),
                        rs.getString("acronym"),
                        rs.getString("email")
                );

                organizers.add(organizer);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        page.setDatas(organizers);
        return page;
    }
    
    /**
     * @author; TrinhHuy
     */
    public boolean deleteOrganizerById(int id) {
        int affectedRows = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            affectedRows = executeUpdatePreparedStatement(conn, DELETE_ORGANIZER_BY_ID, id);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false;
        }
        return affectedRows > 0;
    }
    
    /**
     * @author; TrinhHuy
     */
    public boolean addOrganizer(Organizer club) {
        int result = 0;
        String sqlInsert = "INSERT INTO Organizer (fullname, acronym, email, password) VALUES (?, ?, ?, ?)";
        String sqlCheck = "SELECT COUNT(*) FROM Organizer WHERE email = ? OR acronym = ?";

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            // Kiểm tra xem email hoặc studentId đã tồn tại chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(sqlCheck)) {
                checkStmt.setString(1, club.getEmail());
                checkStmt.setString(2, club.getAcronym());
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;
                }
            }

            // Nếu không tồn tại, thực hiện câu lệnh chèn
            try (PreparedStatement pstmt = conn.prepareStatement(sqlInsert)) {
                String hashedPassword = Hash.doHash(club.getPassword());

                // Đặt các tham số cho PreparedStatement
                pstmt.setString(1, club.getFullname());
                pstmt.setString(2, club.getAcronym());
                pstmt.setString(3, club.getEmail());
                pstmt.setString(4, hashedPassword);
                result = pstmt.executeUpdate();
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error inserting club", e);
        }

        return result > 0;
    }
    
    /**
     * @author; TrinhHuy
     */
    public boolean updateOrganizerById(Organizer organizer) {

        int result = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            result = executeUpdatePreparedStatement(conn, UPDATE_STUDENT_BY_ID, organizer.getFullname(), organizer.getAcronym(), organizer.getEmail(), organizer.getId());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating.", e);
            throw new RuntimeException("Error updating.", e);
        }

        return result > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
    }
    
}
