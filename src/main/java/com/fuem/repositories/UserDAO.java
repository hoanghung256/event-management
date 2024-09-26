/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MinhThang
 */
public class UserDAO extends SQLDatabase{
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    private static final String SELECT_USER_BY_EMAIL = "SELECT email FROM [User] WHERE email = ?";
    private static final String UPDATE_PASSWORD_BY_EMAIL =  "Update [User] \n" +
                                                            "SET password = ?\n" +
                                                            "WHERE email = ?";
    
    //check email
    public boolean isEmailInDatabase(String toEmail){
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
        int updateRow = executeUpdatePreparedStatement( UPDATE_PASSWORD_BY_EMAIL, newPassword, email);
    }
}
