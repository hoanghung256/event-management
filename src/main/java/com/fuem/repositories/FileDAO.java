/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HungHV
 */
public class FileDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(FileDAO.class.getName());
    private static final String INSERT_NEW_IMAGE = "INSERT INTO [EventImage] ("
            + "eventId, "
            + "path) "
            + "VALUES (?, ?)";

    /**
     * 
     * @author HungHV
     */
    public int insertEventImages(int eventId, List<String> imagePaths) {
        int insertedRow = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            for (int i = 1; i < imagePaths.size(); i++) {
                insertedRow += executeUpdatePreparedStatement(conn, INSERT_NEW_IMAGE, eventId, imagePaths.get(i));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return insertedRow;
    }
}
