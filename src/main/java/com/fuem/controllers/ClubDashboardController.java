/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.repositories.AdminDAO;
import com.fuem.repositories.ClubDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
/**
 *
 * @author ThangNM
 */
@WebServlet(name = "ClubDashboardController", urlPatterns = {"/club/dashboard"})
public class ClubDashboardController extends HttpServlet {
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClubDAO dao = new ClubDAO();
        HttpSession session = request.getSession();
        Organizer organizer = (Organizer) session.getAttribute("userInfor");
        int organizerId = organizer.getId();
        
        int totalEvents = dao.getTotalEventOrganized(organizerId);
        int totalFollowers = dao.getTotalFollowers(organizerId);
        int totalUpcomingEvents = dao.getTotalUpcomingEvents(organizerId);
        ArrayList<Event> organizedEvent = dao.getOrganizedEvent(organizerId);
        ArrayList<Event> upcomingEvent = dao.getUpcomingEvent(organizerId);
        
        
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("totalFollowers", totalFollowers);
        request.setAttribute("totalUpcomingEvents", totalUpcomingEvents);
        request.setAttribute("organizedEvent", organizedEvent);
        request.setAttribute("upcomingEvent", upcomingEvent);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String event = request.getParameter("event");
        ClubDAO dao = new ClubDAO();
        HttpSession session = request.getSession();
        Organizer organizer = (Organizer) session.getAttribute("userInfor");
        int organizerId = organizer.getId();

        if (event.equalsIgnoreCase("organized-event")) {
            ArrayList<Event> organizedList = dao.getOrganizedEvent(organizerId);
            request.setAttribute("organizedList", organizedList);
            request.getRequestDispatcher("organized-events.jsp").forward(request, response);
        }
    }
}
