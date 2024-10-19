/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Student;
import com.fuem.repositories.EventRegisteredDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author TuDK
 */
@WebServlet(name = "StudentEventRegisteredController", urlPatterns = {"/student/registered-event"})
public class StudentEventRegisteredController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EventRegisteredDAO dao = new EventRegisteredDAO();
        Student student = (Student) request.getSession().getAttribute("userInfor");
        
        String studentId = student.getStudentId();
        List<Event> registeredEvents = dao.getRegisteredEventListByStudentId(studentId);

        request.setAttribute("registeredEvents", registeredEvents);
        request.getRequestDispatcher("registered-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        EventRegisteredDAO dao = new EventRegisteredDAO();
        Student student = (Student) request.getSession().getAttribute("userInfor");
        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String role = request.getParameter("role");

            boolean isCancelled = false;

            if ("GUEST".equals(role)) {
                isCancelled = dao.cancelGuestRegistration(student.getId(), eventId);
            } else if ("COLLABORATOR".equals(role)) {
                isCancelled = dao.cancelCollaboratorRegistration(student.getId(), eventId);
            }

            if (isCancelled) {
                request.setAttribute("message", "Successfully cancelled registration.");
            } else {
                request.setAttribute("error", "Failed to cancel registration.");
            }
            
            doGet(request, response);
        }
    }
}
