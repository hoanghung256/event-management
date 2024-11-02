/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Notification;
import com.fuem.models.Organizer;
import com.fuem.daos.AdminDAO;
import com.fuem.daos.NotificationDAO;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author ThangNM
 */
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();
        NotificationDAO notiDAO = new NotificationDAO();
        Organizer organizer = (Organizer) request.getSession().getAttribute("userInfor");
        LocalDate loginDate = LocalDate.now();
        int organizerId = organizer.getId();
        int totalOrganizedEvents = dao.getTotalOrganizedEvents(organizerId);
        int totalClubs = dao.getTotalClub();
        int totalUpcomingEvents = dao.getTotalUpcomingEvents(organizerId);
        ArrayList<Event> organizedList = dao.getOrganizedEvent();
        ArrayList<Event> upcomingList = dao.getUpcomingEvent();
        ArrayList<Event> registrationList = dao.getRegistrationEvent();
        ArrayList<Notification> notiList = notiDAO.getNotificationsForOrganizer(organizerId);

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

        Page<Event> registrationEventWithPaging = dao.getRegistrationEventWithPaging(pagingCriteria);

        request.setAttribute("totalOrganizedEvents", totalOrganizedEvents);
        request.setAttribute("totalClubs", totalClubs);
        request.setAttribute("totalUpcomingEvents", totalUpcomingEvents);
        request.setAttribute("organizedList", organizedList);
        request.setAttribute("upcomingList", upcomingList);
        request.setAttribute("registrationList", registrationList);
        request.setAttribute("registrationListPaging", registrationEventWithPaging);
        request.setAttribute("notiList", notiList);
        request.setAttribute("loginDate", loginDate);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
