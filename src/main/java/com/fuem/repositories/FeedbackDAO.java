package com.fuem.repositories;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.Feedback;
import com.fuem.models.Location;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
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
            + "    s.fullname AS student_name, "
            + "    f.content AS feedback, "
            + "    f.guestId AS guest_id "
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
            // Lấy thông tin phản hồi từ ResultSet
            String studentName = rs.getString("student_name");
            String feedbackContent = rs.getString("feedback");
            int guestId = rs.getInt("guest_id");

            // Tạo đối tượng Feedback mới
            Feedback feedback = new Feedback();
            feedback.setContent(feedbackContent);
            feedback.setEventId(eventId);
            feedback.setGuestId(guestId); // Thiết lập guest ID
            feedback.setFullname(studentName); // Thiết lập fullname

            // Nếu bạn muốn thêm đường dẫn ảnh đại diện
            // feedback.setAvatarPath("đường dẫn ảnh đại diện nếu cần thiết");

            feedbackList.add(feedback);
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
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); // Lấy kết nối từ phương thức getConnection()
             PreparedStatement ps = conn.prepareStatement(INSERT_FEEDBACK)) {
            
            ps.setInt(1, (int) feedback.getGuestId());  // Thiết lập guestId
            ps.setInt(2, (int) feedback.getEventId());  // Thiết lập eventId
            ps.setString(3, feedback.getContent()); // Thiết lập nội dung phản hồi
            
            return ps.executeUpdate() > 0; // Trả về true nếu đã lưu thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error saving feedback", e);
            return false; // Trả về false nếu có lỗi
        }
    }
}
