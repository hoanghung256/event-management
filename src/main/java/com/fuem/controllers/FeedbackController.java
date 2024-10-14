package com.fuem.controllers;

import com.fuem.models.Feedback;
import com.fuem.repositories.FeedbackDAO;
import com.fuem.models.User; // Đảm bảo bạn đã nhập User model
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "FeedbackController", urlPatterns = {"/FeedbackController"})
public class FeedbackController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
//
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession(false); // Lấy phiên hiện tại
    if (session == null || session.getAttribute("userInfor") == null) {
        // Nếu chưa đăng nhập, chuyển hướng đến trang lỗi
        request.setAttribute("errorMessage", "User not logged in");
        request.getRequestDispatcher("error.jsp").forward(request, response);
        return;
    }

    User user = (User) session.getAttribute("userInfor"); // Lấy thông tin người dùng từ session
    int guestId = user.getId(); // Lấy userId để sử dụng làm guestId
    int eventId = 2; // Lấy eventId từ request
    String content = request.getParameter("feedback");

//    // Đảm bảo eventId không null
//    try {
//        eventId = Integer.parseInt(request.getParameter("eventId"));
//    } catch (NumberFormatException e) {
//        request.setAttribute("errorMessage", "Invalid Event ID.");
//        request.getRequestDispatcher("error.jsp").forward(request, response);
//        return;
//    }
//
    Feedback feedback = new Feedback(guestId, eventId, content); // Tạo đối tượng Feedback
    FeedbackDAO feedbackDAO = new FeedbackDAO();
    boolean isSaved = feedbackDAO.saveFeedback(feedback); // Lưu phản hồi

    if (isSaved) {
       
        request.getRequestDispatcher("index.html").forward(request, response);
    } else {
        // Xử lý lỗi, thông báo cho người dùng
        request.setAttribute("errorMessage", "Unable to save feedback. Please try again.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
     String[] additionalFeedbacks = request.getParameterValues("additionalFeedbacks");
    if (additionalFeedbacks != null) {
        for (String additionalFeedback : additionalFeedbacks) {
            Feedback additionalFeedbackObj = new Feedback(guestId, eventId, additionalFeedback);
            feedbackDAO.saveFeedback(additionalFeedbackObj);
        }
    }

    if (isSaved) {
        response.sendRedirect("success.jsp"); // Chuyển hướng đến trang thành công
    } else {
        request.setAttribute("errorMessage", "Unable to save feedback. Please try again.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}

    
}
