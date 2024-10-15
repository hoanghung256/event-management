/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Feedback;
import com.fuem.models.Student;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class FeedbackDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(FeedbackDAO.class.getName());
    private static final String SELECT_EVENT_FEEDBACK_BY_EVENTID = "SELECT "
            + "    s.fullname, "
            + "    f.content, "
            + "    f.guestId "
            + "FROM "
            + "    Feedback f "
            + "INNER JOIN "
            + "    Student s ON f.guestId = s.id "
            + "WHERE "
            + "    f.eventId = ?;";
    private static final String INSERT_FEEDBACK = "INSERT INTO Feedback (guestId, eventId, content) VALUES (?, ?, ?)";

    /**
     *
     * @author TuDK
     */ 
    public List<Feedback> getEventFeedbackByEventId(int eventId) throws SQLException {
    List<Feedback> feedbackList = new ArrayList<>();

    try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); 
         ResultSet rs = executeQueryPreparedStatement(conn, SELECT_EVENT_FEEDBACK_BY_EVENTID, eventId)) {

        while (rs.next()) {
            feedbackList.add(
                    new Feedback(
                            new Student(
                                    rs.getInt("guestId"),
                                    rs.getNString("fullname"),
                                    "", "", ""
                            ),
                            rs.getString("content")
                    )
            );
        }
    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error fetching feedback for eventId: " + eventId, e);
    }

    return feedbackList;
  }
  
  /**
   *
   * @author KhiemHV
   */ 
  public boolean saveFeedback(Feedback feedback) {
        int rowChange = 0;
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, INSERT_FEEDBACK, feedback.getGuest().getId(), feedback.getEventId(), feedback.getContent());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error saving feedback", e);
            return false;
        }
        
        return (rowChange > 0);
    }
}

