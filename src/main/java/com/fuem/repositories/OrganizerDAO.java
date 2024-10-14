/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.enums.Role;
import com.fuem.models.Organizer;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    public OrganizerDAO() {
        super();
    }

    public boolean isEmailAndPasswordExist(String email, String password) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD, email, password);){
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return false;
    }

    public Organizer getOrganizerByEmailAndPassword(String email, String password) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD, email, password);){
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
       try(Connection conn = DataSourceWrapper.getDataSource().getConnection();)
               
               {
           
        Object[] values = {
                organizer.getFullname(),
                organizer.getAcronym(),
                organizer.getEmail(),
                organizer.getDescription(),
                organizer.getId()
        };
        int rowsAffected = executeUpdatePreparedStatement(conn,UPDATE_ORGANIZER, values);
        isUpdated = rowsAffected > 0;
         return isUpdated;
       } catch(SQLException e){
           logger.log(Level.SEVERE, null, e);
       }
       return false;
    }

    /**
     * @author TuDK
     */
    public Organizer getOrganizerById(int organizerId) {
        
        Organizer organizer = null;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn,SELECT_ORGANIZER_BY_ID, organizerId);) {
            
            if (rs.next()) {
                organizer = new Organizer(
                        rs.getInt("id"),
                        rs.getString("acronym"),
                        rs.getString("fullname"),
                        rs.getString("description"),
                        rs.getString("email"),
                        rs.getString("avatarPath"),
                        Role.valueOf(rs.getString("role")));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving organizer by ID: ", e);
        }

        return organizer;
    }
}
