/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.EventType;
import com.fuem.models.Notification;
import com.fuem.models.Organizer;
import com.fuem.models.User;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.NotificationDAO;
import com.fuem.repositories.helpers.EventOrderBy;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.repositories.helpers.SearchEventCriteria;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author AnhNQ
 */
@WebServlet(name="HomePageController", urlPatterns={"/home"})
public class HomePageController extends HttpServlet {
    private EventDAO eventDAO = new EventDAO();
    private NotificationDAO notiDAO = new NotificationDAO();
    private static final Logger logger = Logger.getLogger(HomePageController.class.getName());
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Event> eventList = eventDAO.getAllEvents();
        request.setAttribute("eventList", eventList);
        User user = (User) request.getSession().getAttribute("userInfor");

        List<Notification> notiList = notiDAO.getNotificationsForUser(user.getId());
        System.out.println(notiList.size());
        request.setAttribute("notiList", notiList);
        
        List<EventType> typeList = eventDAO.getAllEventType();
        request.setAttribute("eventTypeList", typeList);
        
        List<Organizer> organizerList = eventDAO.getAllOrganizer();
        request.setAttribute("organizerList", organizerList);
        
        String name = request.getParameter("name");
        String typeId = request.getParameter("typeId");
        String organizerId = request.getParameter("organizerId");
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String orderBy = request.getParameter("orderBy");
        String pageNumberStr = request.getParameter("page");
        
        SearchEventCriteria searchEventCriteria = new SearchEventCriteria();
        PagingCriteria pagingCriteria = new PagingCriteria();
        
        // Set attribute for SearchEventCriteria
        if (name != null || typeId != null || organizerId != null || fromDate != null || toDate != null) {
            if (!name.isBlank()) searchEventCriteria.setName(name);
            if (!typeId.isBlank()) searchEventCriteria.setTypeId(Integer.valueOf(typeId));
            if (!organizerId.isBlank()) searchEventCriteria.setOrganizerId(Integer.valueOf(organizerId));
            if (!fromDate.isBlank()) searchEventCriteria.setFrom(LocalDate.parse(fromDate));
            if (!toDate.isBlank()) searchEventCriteria.setTo(LocalDate.parse(toDate));
            if (orderBy != null) searchEventCriteria.setOrderBy(EventOrderBy.valueOf(orderBy));
            
            request.setAttribute("previousSearchEventCriteria", searchEventCriteria);
        }
        
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
        
        Page<Event> result = eventDAO.get(
                pagingCriteria,
                searchEventCriteria
        );
        
        request.setAttribute("page", result);
        request.getRequestDispatcher("student/homepage.jsp").forward(request, response);
    } 
}
