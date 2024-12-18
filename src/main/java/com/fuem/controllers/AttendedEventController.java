/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Student;
import com.fuem.daos.EventAttendedDAO;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
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
@WebServlet(name = "AttendedEventController", urlPatterns = {"/student/attended-events"})
public class AttendedEventController extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = (String) request.getAttribute("method");
        
        switch (method) {
            case "get":
                doGet(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Student user = (Student) request.getSession().getAttribute("userInfor");
        EventAttendedDAO eventAttendedDAO = new EventAttendedDAO();

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
        
        Page<Object[]> attendedEvents = eventAttendedDAO.getAttendedEventsList(pagingCriteria, user.getId());
        
        request.setAttribute("page", attendedEvents);
        request.getRequestDispatcher("attended-events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}
