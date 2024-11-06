/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.daos.EventDAO;
import com.fuem.daos.NotificationDAO;
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
 * @author AnhNQ
 */
@WebServlet(name="SendNotificationController", urlPatterns={"/club/send-event-notification", "/admin/send-event-notification"})
public class SendNotificationController extends HttpServlet {
    
    public static NotificationDAO notiDAO = new NotificationDAO();
    public static EventDAO eventDAO = new EventDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Organizer organizer = (Organizer) request.getSession().getAttribute("userInfor");
        List<Event> upcomingEvents = eventDAO.getIncomingEventByOrganizerId(organizer.getId());
        
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.getRequestDispatcher("send-event-notification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Organizer organizer = (Organizer) request.getSession().getAttribute("userInfor");
        String content = request.getParameter("content");
        
        int newNotiId = notiDAO.insertAndGetIdOfNewNotification(organizer.getId(), content);
        String[] ids = request.getParameterValues("event-id");
        if(ids.length == 0){
            
        }
        int numberOfReceivers = 0;
        try {
            numberOfReceivers = notiDAO.insertIntoNotificationReceiver( ids, newNotiId);
        } catch (SQLException ex) {
            Logger.getLogger(SendNotificationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("numberOfReceivers", numberOfReceivers);
        List<Event> upcomingEvents = eventDAO.getIncomingEventByOrganizerId(organizer.getId());
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.getRequestDispatcher("send-event-notification.jsp").forward(request, response);
    }
}
