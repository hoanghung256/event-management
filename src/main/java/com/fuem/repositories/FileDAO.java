/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.enums.FileStatus;
import com.fuem.models.Document;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Handle Images and Documents 
 * 
 * @author HungHV
 */
public class FileDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(FileDAO.class.getName());
    private static final String INSERT_NEW_IMAGE = "INSERT INTO [EventImage] ("
            + "eventId, "
            + "path) "
            + "VALUES (?, ?)";
    private static final String SELECT_FILE_BY_SUBMITTER_ID = "SELECT "
            + "id, "
            + "submitterId, "
            + "displayName, "
            + "fileType, "
            + "path, "
            + "processNote, "
            + "processTime, "
            + "status, "
            + "sendTime, "
            + "COUNT (*) OVER() AS 'TotalRow' "
            + "FROM [File] "
            + "WHERE submitterId = ?"
            + "ORDER BY sendTime DESC "
            + "OFFSET ? ROWS "
            + "FETCH NEXT ? ROWS ONLY;";
    private static final String INSERT_NEW_FILE = "INSERT INTO [File] (submitterId, displayName, fileType, path) VALUES (?, ?, ?, ?)";
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
    
    /**
     * 
     * @author HungHV 
     */
    public Page<Document> getFilesBySubmitterId(PagingCriteria pagingCriteria, int submitterId) {
        Page<Document> page = null;
        ArrayList<Document> docs = new ArrayList<>();
        
        try (Connection conn =  DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_FILE_BY_SUBMITTER_ID, submitterId, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page == null) {
                    page = new Page<>();
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                docs.add(
                        new Document(
                                rs.getInt("id"),
                                submitterId, 
                                rs.getString("displayName"),
                                rs.getNString("fileType"),
                                rs.getNString("path"), 
                                rs.getTimestamp("sendTime").toLocalDateTime(),
                                rs.getNString("processNote"),
                                rs.getTimestamp("processTime") != null ? rs.getTimestamp("processTime").toLocalDateTime() : null,
                                FileStatus.valueOf(rs.getString("status"))
                        )
                );
            }
            
            page.setDatas(docs);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        
        return page;
    }
    
    /**
     * 
     * @author HungHV
     */
    public boolean insertFile(Document doc) {
        int rowChange = 0;
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, INSERT_NEW_FILE, doc.getSubmitterId(), doc.getDisplayName(), doc.getType(), doc.getPath());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        } finally {
            return (rowChange > 0);
        }
    }
}
