/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

import com.fuem.enums.FileStatus;
import com.fuem.models.Document;
import com.fuem.models.Organizer;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
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
    private static final String SELECT_ALL_FILE = "SELECT "
            + "[File].id, "
            + "Organizer.id AS organizerId, "
            + "Organizer.acronym, "
            + "displayName, "
            + "fileType, "
            + "path, "
            + "processNote, "
            + "processTime, "
            + "status, "
            + "sendTime, "
            + "COUNT (*) OVER() AS 'TotalRow' "
            + "FROM [File] "
            + "JOIN [Organizer] ON [File].submitterId = [Organizer].id "
            + "ORDER BY "
            + "     CASE "
            + "         WHEN status = 'PENDING' THEN 1 "
            + "         ELSE 2 "
            + "     END, "
            + "     sendTime DESC "
            + "OFFSET ? ROWS "
            + "FETCH NEXT ? ROWS ONLY;";
    private static String UPDATE_FILE_STATUS_BY_ID = "UPDATE [File] SET status=?, processNote=?, processTime=GETDATE() WHERE id=?";
    
    /**
     *
     * @author HungHV
     */
    public int insertEventImages(int eventId, List<String> imagePaths) throws SQLException {
        int insertedRow = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            for (int i = 1; i < imagePaths.size(); i++) {
                insertedRow += executeUpdatePreparedStatement(conn, INSERT_NEW_IMAGE, eventId, imagePaths.get(i));
            }
        } catch (SQLException e) {
            throw e;
        }

        return insertedRow;
    }
    
    /**
     * 
     * @author HungHV 
     */
    public Page<Document> getFilesBySubmitterId(PagingCriteria pagingCriteria, int submitterId) {
        Page<Document> page = new Page<>();
        ArrayList<Document> docs = new ArrayList<>();
        
        try (Connection conn =  DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_FILE_BY_SUBMITTER_ID, submitterId, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page = new Page<>();
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                docs.add(
                        new Document(
                                rs.getInt("id"),
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
            rowChange = executeUpdatePreparedStatement(conn, INSERT_NEW_FILE, doc.getSubmittedBy().getId(), doc.getDisplayName(), doc.getType(), doc.getPath());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return (rowChange > 0);
    }
    
    /**
     * 
     * @author HungHV 
     */
    public Page<Document> getFiles(PagingCriteria pagingCriteria) {
        Page<Document> page = new Page<>();
        ArrayList<Document> docs = new ArrayList<>();
        
        try (Connection conn =  DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ALL_FILE, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                docs.add(
                        new Document(
                                rs.getInt("id"),
                                new Organizer(
                                        rs.getInt("organizerId"), 
                                        rs.getNString("acronym")
                                ), 
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
    public boolean updateFileStatus(int fileId, String status, String processNote) {
        int rowChange = 0;
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, UPDATE_FILE_STATUS_BY_ID, status, processNote, fileId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        
        return rowChange > 0;
    }
}