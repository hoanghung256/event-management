/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Feedback;
import com.fuem.models.Organizer;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "ViewEventFeedbackController", urlPatterns = {"/admin/view-feedback", "/club/view-feedback"})
public class ViewEventFeedbackController extends HttpServlet {

    @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       HttpSession session = request.getSession();
        Organizer organizer = (Organizer) session.getAttribute("userInfor");
        try {
            int eventId = Integer.parseInt(request.getParameter("eventId")); // Lấy ID sự kiện từ request
            EventDAO eventDAO = new EventDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            
            Event event = eventDAO.getEventDetails(eventId);// Lấy thông tin sự kiện
            List<Feedback> feedbackList = feedbackDAO.getEventFeedbackByEventId(eventId); // Lấy danh sách phản hồi
            request.setAttribute("event", event); 
            request.setAttribute("feedbackList", feedbackList); 
            
            System.out.println(feedbackList);
            request.getRequestDispatcher("view-feedback.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewEventFeedbackController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
