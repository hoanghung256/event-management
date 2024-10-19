package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Feedback;
import com.fuem.models.Student;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "FeedbackController", urlPatterns = {"/admin/feedback", "/club/feedback", "/student/feedback"})
public class FeedbackController extends HttpServlet {

    /**
     *
     * @author TuDK
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Organizer organizer = (Organizer) session.getAttribute("userInfor");

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            EventDAO eventDAO = new EventDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            
            Event event = eventDAO.getEventDetails(eventId);
            List<Feedback> feedbackList = feedbackDAO.getEventFeedbackByEventId(eventId); 
            request.setAttribute("event", event);
            request.setAttribute("feedbackList", feedbackList);

//            System.out.println(feedbackList);
            request.getRequestDispatcher("view-feedback.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @author KhiemHV
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Student user = (Student) request.getSession().getAttribute("userInfor");
        int guestId = user.getId();
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String content = request.getParameter("content");

        Feedback feedback = new Feedback(
                new Student(
                        guestId
                ),
                eventId,
                content
        );
        FeedbackDAO dao = new FeedbackDAO();
        boolean isSaved = dao.saveFeedback(feedback);

        if (isSaved) {
            request.setAttribute("success", "Sent successfully!");
        } else {
            request.setAttribute("error", "Unable to save feedback. Please try again.");
        }
        request.setAttribute("method", "get");
        request.getRequestDispatcher("/student/attended-events").forward(request, response);
    }
}
