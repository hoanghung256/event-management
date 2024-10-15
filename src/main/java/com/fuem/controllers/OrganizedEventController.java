/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.repositories.AdminDAO;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hoang hung
 */
@WebServlet(name = "OrganizedEventController", urlPatterns = {"/club/organized-event", "/admin/organized-event"})
public class OrganizedEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();
        HttpSession session = request.getSession();
        Organizer organizer = (Organizer) session.getAttribute("userInfor");
        int organizerId = organizer.getId();

        //paging
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

        Page<Event> organizedList = dao.getOrganizedEventWithPaging(pagingCriteria, organizerId);
        request.setAttribute("page", organizedList);
        request.getRequestDispatcher("organized-events.jsp").forward(request, response);
    }
}
