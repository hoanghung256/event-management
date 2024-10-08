/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.repositories.AdminDashboardDAO;
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
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin-dashboard"})
public class AdminDashboardController extends HttpServlet {
    private AdminDashboardDAO dao = new AdminDashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int totalOrganizedEvents = dao.getTotalOrganizedEvents(1);
        int totalClubs = dao.getTotalClub();
        int totalUpcomingEvents = dao.getTotalUpcomingEvents(1);
        ArrayList<Event> registrationList = dao.getRegistrationEvent();
        ArrayList<Event> organizedList = dao.getOrganizedEvent(1);
        ArrayList<Event> upcomingList = dao.getUpcomingEvent();
        
        System.out.println(organizedList);
        
        request.setAttribute("totalOrganizedEvents", totalOrganizedEvents);
        request.setAttribute("totalClubs", totalClubs);
        request.setAttribute("totalUpcomingEvents", totalUpcomingEvents);
        request.setAttribute("registrationList", registrationList);
        request.setAttribute("organizedList", organizedList);
        request.setAttribute("upcomingList", upcomingList);
        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
  
    }

}
