/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.daos.AdminDAO;
import com.fuem.daos.ClubDAO;
import com.fuem.enums.Role;
import com.fuem.models.Organizer;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hoang hung
 */
@WebServlet(name = "OrganizedEventController", urlPatterns = {"/club/organized-event", "/admin/organized-event"})
public class OrganizedEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Organizer org = (Organizer) request.getSession().getAttribute("userInfor");
        Page<Event> organizedList = new Page<>();

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

        if (org.getRole().equals(Role.CLUB)) {
            ClubDAO clubDao = new ClubDAO();
            
            organizedList = clubDao.getOrganizedEventWithPaging(org.getId(), pagingCriteria);
        } else {
            AdminDAO adminDao = new AdminDAO();

            organizedList = adminDao.getOrganizedEventWithPaging(pagingCriteria);
        }
        request.setAttribute("page", organizedList);
        request.getRequestDispatcher("organized-events.jsp").forward(request, response);
    }
}
