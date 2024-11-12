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
import com.fuem.daos.EventDAO;
import com.fuem.daos.NotificationDAO;
import com.fuem.daos.helpers.EventOrderBy;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.daos.helpers.SearchEventCriteria;
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
        List<Category> cateList = eventDAO.getAllCategory();
        request.setAttribute("cateList", cateList);
        List<Organizer> organizerList = eventDAO.getAllOrganizer();
        request.setAttribute("organizerList", organizerList);

        List<Event> todayEvents = eventDAO.getTodayEvent();
        request.setAttribute("todayEvents", todayEvents);

        String pageNumberStr = request.getParameter("page");
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
        String isFind = (String) request.getParameter("isFind");
        if ("true".equals(isFind)) {
            handleSearch(request, response, pagingCriteria);
            return;
        }

        Student user = (Student) request.getSession().getAttribute("userInfor");
        Page<Object[]> result = null;
        if (user == null) {
            result = eventDAO.getForGuest(pagingCriteria, searchEventCriteria);
        } else {
            List<Notification> notiList = notiDAO.getNotificationsForUser(user.getId());
            request.setAttribute("notiList", notiList);
            result = eventDAO.get(pagingCriteria, user.getId());
        }
        request.setAttribute("page", result);
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response, PagingCriteria pagingCriteria) throws ServletException, IOException {
        String name = request.getParameter("name");
        String categoryId = request.getParameter("categoryId");
        String organizerId = request.getParameter("organizerId");
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String orderBy = request.getParameter("orderBy");

        EventDAO eventDAO = new EventDAO();

        SearchEventCriteria searchEventCriteria = new SearchEventCriteria();

        boolean isFind = false;
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
            isFind = true;
            request.setAttribute("previousSearchEventCriteria", searchEventCriteria);
        }
        if (isFind) {
            Page<Object[]> result = eventDAO.getSearchEvent(pagingCriteria, searchEventCriteria);
            request.setAttribute("page", result);
            request.setAttribute("isSearch", true);
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        }
    }
}
