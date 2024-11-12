/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.enums.EventStatus;
import com.fuem.models.Event;
import com.fuem.daos.AdminDAO;
import com.fuem.daos.EventDAO;
import com.fuem.daos.OrganizerDAO;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.models.Organizer;
import com.fuem.utils.Gmail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ThangNM
 */
@WebServlet(name = "EventApprovalController", urlPatterns = {"/admin/approval-events"})
public class EventApprovalController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "detail":
                EventDAO eventDao = new EventDAO();
                int eventId = Integer.parseInt(request.getParameter("eventId"));
                Event registrationEvent = eventDao.getEventDetails(eventId);
                request.setAttribute("event", registrationEvent);
                request.getRequestDispatcher("pending-event-details.jsp").forward(request, response);
                break;
            case "show":
                AdminDAO dao = new AdminDAO();
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
                request.setAttribute("page", registrationEventWithPaging);
                request.getRequestDispatcher("pending-events.jsp").forward(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        EventDAO dao = new EventDAO();

        switch (action) {
            case "approve":
                dao.changeEventStatus(eventId, EventStatus.APPROVED);
                response.sendRedirect(request.getContextPath() + "/admin/approval-events?action=show");
                break;
            case "rejected":
                dao.changeEventStatus(eventId, EventStatus.REJECTED);
                response.sendRedirect(request.getContextPath() + "/admin/approval-events?action=show");
                break;
        }

        new Thread(
                () -> {
                    try {
                        Event e = dao.getEventById(eventId);
                        Organizer club = new OrganizerDAO().getOrganizerByEventId(eventId);
                        Gmail.eventRegistrationResult(club.getEmail(), club.getFullname(), e, action.equals("approve") ? true : false);
                    } catch (MalformedURLException e) {
                        Logger.getLogger(EventRegistrationController.class.getName()).log(Level.SEVERE, null, e);
                    }
                }
        ).start();
    }

}
