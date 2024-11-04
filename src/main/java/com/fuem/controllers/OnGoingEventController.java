/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuem.controllers;

import com.fuem.daos.EventDAO;
import com.fuem.enums.EventStatus;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 *
 * @author HungHV
 */
@WebServlet(name="OnGoingEventController", urlPatterns={"/club/on-going-event", "/admin/on-going-event"})
public class OnGoingEventController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        
        switch (action) {
            case "access":
                String eventName = new EventDAO().getEventNameById(eventId);
                
                request.setAttribute("eventId", eventId);
                request.setAttribute("eventName", eventName);
                request.getRequestDispatcher("landing.jsp").forward(request, response);
                break;
            case "get-attend-count":
                PrintWriter out = response.getWriter();
                
                EventDAO dao = new EventDAO();
                int attendedCount = dao.getAttendedCount(eventId);
                
                out.print(
                        "{"
                            + "\"attendedCount\":" + attendedCount + 
                        "}");
                break;
            case "end":
                EventDAO eventDao = new EventDAO();
                eventDao.changeEventStatus(eventId, EventStatus.END);
                request.getRequestDispatcher("dashboard").forward(request, response);
                break;
            default:
                throw new AssertionError();
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request, response);
    }
}
