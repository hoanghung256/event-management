/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
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
}
