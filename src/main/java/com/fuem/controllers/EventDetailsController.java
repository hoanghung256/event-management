/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.repositories.EventDAO;
import jakarta.servlet.ServletException;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author TuDK
 */
@WebServlet(name = "EventDetailsController", urlPatterns = {"/event-detail"})
public class EventDetailsController extends HttpServlet {

    EventDAO eventDAO = new EventDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        Event event = eventDAO.getEventDetails(eventId);

        if (event != null) {
            request.setAttribute("event", event);
            System.out.println("Event found: " + event.getFullname());
        } else {
            request.setAttribute("error", "Get data failed!");
            System.out.println("No event found for eventId: " + eventId);
        }
        request.getRequestDispatcher("event-details.jsp").forward(request, response);

    }
}
