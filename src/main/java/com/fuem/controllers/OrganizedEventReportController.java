/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.repositories.AdminDAO;
import com.fuem.repositories.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author ThangNM
 */
@WebServlet(name = "OrganizedEventReportController", urlPatterns = {"/admin/organized-event-report", "/club/organized-event-report"})
public class OrganizedEventReportController extends HttpServlet {

    /**
     * 
     * @queryParameter action "detail" or "compared"
     * @queryParameter eventIdDetail for identity event getting report
     * @queryParameter eventIdSelected for identity event getting compared when action is "compared"
     * @author ThangNM
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        EventDAO eventDAO = new EventDAO();
        AdminDAO adminDAO = new AdminDAO();
        int eventId = Integer.parseInt(request.getParameter("eventIdDetail"));
        int organizerId = Integer.parseInt(request.getParameter("organizerId"));
        int totalRegister, totalAttended, totalCollaborator, totalCancel;

        Event event = eventDAO.getEventDetails(eventId);
        ArrayList<Event> organizedList = adminDAO.getOrganizedEventExceptTheChoosen(organizerId, eventId);
        int[] statisticNumber = eventDAO.getTotalStatisticNumberOfEvent(eventId);

        totalRegister = statisticNumber[0];
        totalAttended = statisticNumber[1];
        totalCollaborator = statisticNumber[2];
        totalCancel = statisticNumber[3];

        request.setAttribute("event", event);
        request.setAttribute("totalRegister", totalRegister);
        request.setAttribute("totalAttended", totalAttended);
        request.setAttribute("totalCollaborator", totalCollaborator);
        request.setAttribute("totalCancel", totalCancel);
        request.setAttribute("organizedList", organizedList);

        switch (action) {
            case "detail":
                request.getRequestDispatcher("organized-event-report.jsp").forward(request, response);
                break;

            case "compared":
                int totalSelectedRegister, totalSelectedAttended, totalSelectedCollaborator, totalSelectedCancel;
                int eventIdSelected = Integer.parseInt(request.getParameter("eventIdSelected"));
                int[] statisticSelectedNumber = eventDAO.getTotalStatisticNumberOfEvent(eventIdSelected);
                Event selectedEvent = eventDAO.getEventDetails(eventIdSelected);
                
                String selectedEventName = selectedEvent.getFullname();
                totalSelectedRegister = statisticSelectedNumber[0];
                totalSelectedAttended = statisticSelectedNumber[1];
                totalSelectedCollaborator = statisticSelectedNumber[2];
                totalSelectedCancel = statisticSelectedNumber[3];

                request.setAttribute("totalSelectedRegister", totalSelectedRegister);
                request.setAttribute("totalSelectedAttended", totalSelectedAttended);
                request.setAttribute("totalSelectedCollaborator", totalSelectedCollaborator);
                request.setAttribute("totalSelectedCancel", totalSelectedCancel);
                request.setAttribute("selectedEventName", selectedEventName);
                request.getRequestDispatcher("organized-event-report.jsp").forward(request, response);
                break;
        }
    }
}
