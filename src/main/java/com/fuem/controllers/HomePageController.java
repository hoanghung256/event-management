/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Category;
import com.fuem.models.Notification;
import com.fuem.models.Organizer;
import com.fuem.models.Student;
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

/**
 *
 * @author AnhNQ
 */
@WebServlet(name = "HomePageController", urlPatterns = {"/home"})
public class HomePageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EventDAO eventDAO = new EventDAO();
        NotificationDAO notiDAO = new NotificationDAO();
        Student user = (Student) request.getSession().getAttribute("userInfor");
        
        List<Notification> notiList = notiDAO.getNotificationsForUser(user.getId());
        request.setAttribute("notiList", notiList);

        List<Category> cateList = eventDAO.getAllCategory();
        request.setAttribute("cateList", cateList);

        List<Organizer> organizerList = eventDAO.getAllOrganizer();
        request.setAttribute("organizerList", organizerList);
        
        List<Event> todayEvents = eventDAO.getTodayEvent();
//        System.out.println(todayEvents);
        request.setAttribute("todayEvents", todayEvents);
        String name = request.getParameter("name");
        String categoryId = request.getParameter("categoryId");
        String organizerId = request.getParameter("organizerId");
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String orderBy = request.getParameter("orderBy");
        String pageNumberStr = request.getParameter("page");

        //paging and filter
        SearchEventCriteria searchEventCriteria = new SearchEventCriteria();
        PagingCriteria pagingCriteria = new PagingCriteria();

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

        // Set attribute for SearchEventCriteria
        if (name != null || categoryId != null || organizerId != null || fromDate != null || toDate != null) {
            if (!name.isBlank()) {
                searchEventCriteria.setName(name);
            }
            if (!categoryId.isBlank()) {
                searchEventCriteria.setCategoryId(Integer.valueOf(categoryId));
            }
            if (!organizerId.isBlank()) {
                searchEventCriteria.setOrganizerId(Integer.valueOf(organizerId));
            }
            if (!fromDate.isBlank()) {
                searchEventCriteria.setFrom(LocalDate.parse(fromDate));
            }
            if (!toDate.isBlank()) {
                searchEventCriteria.setTo(LocalDate.parse(toDate));
            }
            if (orderBy != null) {
                searchEventCriteria.setOrderBy(EventOrderBy.valueOf(orderBy));
            }

            request.setAttribute("previousSearchEventCriteria", searchEventCriteria);

        }
        Page<Event> result = eventDAO.get(
                pagingCriteria,
                searchEventCriteria,
                user.getId()
        );
        request.setAttribute("page", result);
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }
}
