/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.repositories.ClubDashboardDAO;
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
@WebServlet(name = "ClubDashboardController", urlPatterns = {"/club/dashboard"})
public class ClubDashboardController extends HttpServlet {
    private ClubDashboardDAO dao = new ClubDashboardDAO();
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //HttpSession session = request.getSession();
        //session.getAttribute("organizeId", organizeId);
        int totalEvents = dao.getTotalEventOrganized(3);
        int totalFollowers = dao.getTotalFollowers(3);
        int totalUpcomingEvents = dao.getTotalUpcomingEvents(3);
        ArrayList<Event> organizedEvent = dao.getOrganizedEvent(3);
        ArrayList<Event> upcomingEvent = dao.getUpcomingEvent(3);
        
        System.out.println(upcomingEvent);
        
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
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
