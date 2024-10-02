/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Organizer;
import com.fuem.models.User;
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

    public boolean isEmailAndPasswordExist(String email, String password) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD, email, password);

        try {
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return false;
    }

    public Organizer getOrganizerByEmailAndPassword(String email, String password) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ORGANIZER_BY_EMAIL_AND_PASSWORD, email, password);
        Organizer organizer = new Organizer();

        try {
            while (rs.next()) {
                organizer = new Organizer(
                        rs.getInt("id"),
                        rs.getString("acronym"),
                        rs.getString("fullname"),
                        rs.getString("description"),
                        rs.getString("email"),
                        rs.getString("avatarPath"),
                        rs.getBoolean("isAdmin")
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return organizer;
    }
}
