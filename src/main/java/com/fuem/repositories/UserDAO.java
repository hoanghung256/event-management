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
 * @author ASUS
 */
public class UserDAO extends SQLDatabase{
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    
    //check email
    public boolean isEmailInDatabase(String toEmail){
        ResultSet rs = executeQueryPreparedStatement("SELECT email FROM [User] WHERE email = ?", toEmail);
        
        try {
            while (rs.next()) {
                return toEmail.equalsIgnoreCase(rs.getString("email"));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, toEmail, e);
        }
        
       return false; 
    }
    
    //change password
    public int updatePassword(String email, String newPassword) {
        int updateRow = executeUpdatePreparedStatement( "Update [User] \n" +
                                                        "set password = ?\n" +
                                                        "where email = ?", newPassword, email);
        return updateRow;
    }
}
