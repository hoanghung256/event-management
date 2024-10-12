/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.repositories.AdminDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author hoang hung
 */
@WebServlet(name="OrganizedEventController", urlPatterns={"/club/organized-event", "/admin/organized-event"})
public class OrganizedEventController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();
        HttpSession session = request.getSession();
        Organizer organizer = (Organizer) session.getAttribute("userInfor");
        int organizerId = organizer.getId();

        ArrayList<Event> organizedList = dao.getOrganizedEvent(organizerId);
        request.setAttribute("organizedList", organizedList);
        request.getRequestDispatcher("organized-events.jsp").forward(request, response);
    }
}
