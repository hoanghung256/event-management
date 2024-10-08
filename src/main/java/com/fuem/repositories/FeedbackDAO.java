package com.fuem.repositories;

import com.fuem.models.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FeedbackDAO extends SQLDatabase {
    
    private static final Logger logger = Logger.getLogger(FeedbackDAO.class.getName());
    
    // SQL truy vấn để chèn phản hồi vào bảng Feedback
    private static final String INSERT_FEEDBACK = 
            "INSERT INTO Feedback (guestId, eventId, content) VALUES (?, ?, ?)";

 
    public boolean saveFeedback(Feedback feedback) {
        try (Connection conn = getConnection(); // Lấy kết nối từ phương thức getConnection()
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
//     public boolean saveFeedback(Feedback feedback) {
//        String sql = "INSERT INTO Feedback (guestId, eventId, content) VALUES (?, ?, ?)";
//        try (Connection conn = getConnection();
//                PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            pstmt.setInt(1, (int) feedback.getGuestId());
//            pstmt.setInt(2, (int) feedback.getEventId());
//            pstmt.setString(3, feedback.getContent());
//
//            int rowsAffected = pstmt.executeUpdate();
//            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 dòng được thêm
//        } catch (SQLException e) {
//            logger.log(Level.SEVERE, "Error saving feedback: ", e); // Ghi lại lỗi
//            return false; // Trả về false nếu có lỗi
//        }
}

