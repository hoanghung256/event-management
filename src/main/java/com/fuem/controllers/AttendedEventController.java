/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.repositories.EventAttendedDAO;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        PagingCriteria pagingCriteria = new PagingCriteria();
        String pageNumberStr = request.getParameter("page");
        
        Integer pageNumber = null;
        
        if (pageNumberStr == null) {
            pageNumber = 0;
        } else {
            pageNumber = Integer.valueOf(pageNumberStr);
        }
        
        pagingCriteria = new PagingCriteria(
                pageNumber, 
                10
        );
        
        Page<Event> attendedEvents = dao.getAttendedEventsList(pagingCriteria, 4);
        
        request.setAttribute("page", attendedEvents);
        request.getRequestDispatcher("student/attended-events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

}
