/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Student;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.EventRegisteredDAO;
import jakarta.servlet.ServletException;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author TuDK
 */
@WebServlet(name = "EventDetailsController", urlPatterns = {"/event-detail"})
public class EventDetailsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Student student =  (Student) request.getSession().getAttribute("userInfor");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        EventDAO eventDAO = new EventDAO();
        EventRegisteredDAO eventRegisteredDAO = new EventRegisteredDAO();

        Event event = eventDAO.getEventDetails(eventId);

        if (event != null) {
            request.setAttribute("event", event);
            
            boolean[] isRegis = eventRegisteredDAO.isStudentRegistered(student.getId(), eventId);
            request.setAttribute("isGuestRegis", isRegis[0]);
            request.setAttribute("isCollabRegis", isRegis[1]);
            
            System.out.println("geust " + isRegis[0]);
            System.out.println("collab " + isRegis[1]);
        } else {
            request.setAttribute("error", "Get data failed!");
        }

        request.getRequestDispatcher("event-details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("userInfor");
        EventRegisteredDAO eventRegisteredDAO = new EventRegisteredDAO();

        // Kiểm tra xem sinh viên có được xác thực hay không
        if (student == null) {
            request.setAttribute("error", "You need to be logged in to register for events.");
            request.getRequestDispatcher("event-details.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        boolean result;

        try {
            switch (action) {
                case "registerCollaborator":
                    // Đăng ký như một collaborator
                    result = eventRegisteredDAO.registerCollaborator(student.getId(), eventId);
                    if (result) {
                        request.setAttribute("message", "Successfully registered as a collaborator.");
                    } else {
                        request.setAttribute("error", "Failed to register as a collaborator. Please try again.");
                    }
                    break;

                case "cancelCollaborator":
                    // Hủy đăng ký collaborator
                    result = eventRegisteredDAO.cancelCollaboratorRegistration(student.getId(), eventId);
                    if (result) {
                        request.setAttribute("message", "Successfully canceled collaborator registration.");
                    } else {
                        request.setAttribute("error", "Failed to cancel collaborator registration. Please try again.");
                    }
                    break;

                case "registerGuest":
                    // Đăng ký như một guest
                    result = eventRegisteredDAO.registerGuest(student.getId(), eventId);
                    if (result) {
                        request.setAttribute("message", "Successfully registered as a guest.");
                    } else {
                        request.setAttribute("error", "Failed to register as a guest. Please try again.");
                    }
                    break;

                case "cancelGuest":
                    // Hủy đăng ký guest
                    result = eventRegisteredDAO.cancelGuestRegistration(student.getId(), eventId);
                    if (result) {
                        request.setAttribute("message", "Successfully canceled guest registration.");
                    } else {
                        request.setAttribute("error", "Failed to cancel guest registration. Please try again.");
                    }
                    break;

                default:
                    request.setAttribute("error", "Invalid action.");
                    break;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid event ID.");
        }
      
        doGet(request, response);
    }
}
