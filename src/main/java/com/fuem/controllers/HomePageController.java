/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Notification;
import com.fuem.models.User;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.NotificationDAO;
import jakarta.mail.Session;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author AnhNQ
 */
@WebServlet(name="HomePageController", urlPatterns={"/event-list"})
public class HomePageController extends HttpServlet {
    private EventDAO eventDAO = new EventDAO();
    private NotificationDAO notiDAO = new NotificationDAO();
    private static final Logger logger = Logger.getLogger(HomePageController.class.getName());
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<Event> eventList = eventDAO.getAllEvents();
        request.setAttribute("eventList", eventList);
//        User user = (User) request.getSession().getAttribute("userInfor");

        List<Notification> notiList = notiDAO.getNotificationsForUser(1);
        System.out.println(notiList.size());
        request.setAttribute("notiList", notiList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("student/homepage.jsp");
        dispatcher.forward(request, response);
    } 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
