/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.repositories.EventAttendedDAO;
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
@WebServlet(name = "AttendedEventController", urlPatterns = {"/attended"})
public class AttendedEventController extends HttpServlet {
    private EventAttendedDAO dao = new EventAttendedDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //if sign-in
        /*
        HttpSession session = request.getSession();
        session.getAttribute("userId", userId);    
        */
        ArrayList<Event> attendedEvents = dao.getAttendedEventsList(4);

        request.setAttribute("event", attendedEvents);
        request.getRequestDispatcher("student/attended-events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

}
