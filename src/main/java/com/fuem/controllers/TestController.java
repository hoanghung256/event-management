
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

//package com.fuem.controllers;

import com.fuem.repositories.EventDAO;
import com.fuem.repositories.helpers.SearchEventCriteria;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.models.Event;
import com.fuem.repositories.helpers.EventOrderBy;
import com.fuem.repositories.helpers.Page;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
//
///**
// *
// * @author hoang hung
// */
@WebServlet(name = "TestController", urlPatterns = "/test")
@MultipartConfig
public class TestController extends HttpServlet {
    
    private static final EventDAO dbContext = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String name = req.getParameter("name");
//        String typeId = req.getParameter("typeId");
//        String organizerId = req.getParameter("organizerId");
//        String fromDate = req.getParameter("from");
//        String toDate = req.getParameter("to");
//        String orderBy = req.getParameter("orderBy");
//        String pageNumberStr = req.getParameter("page");
//        
//        SearchEventCriteria searchEventCriteria = new SearchEventCriteria();
//        PagingCriteria pagingCriteria = new PagingCriteria();
//        
//        // Set attribute for SearchEventCriteria
//        if (name != null || typeId != null || organizerId != null || fromDate != null || toDate != null) {
//            if (!name.isBlank()) searchEventCriteria.setName(name);
//            if (!typeId.isBlank()) searchEventCriteria.setTypeId(Integer.valueOf(typeId));
//            if (!organizerId.isBlank()) searchEventCriteria.setOrganizerId(Integer.valueOf(organizerId));
//            if (!fromDate.isBlank()) searchEventCriteria.setFrom(LocalDate.parse(fromDate));
//            if (!toDate.isBlank()) searchEventCriteria.setTo(LocalDate.parse(toDate));
//            if (orderBy != null) searchEventCriteria.setOrderBy(EventOrderBy.valueOf(orderBy));
//            
//            req.setAttribute("previousSearchEventCriteria", searchEventCriteria);
//        }
//        
//        Integer pageNumber = null;
//        
//        if (pageNumberStr == null) {
//            pageNumber = 0;
//        } else {
//            pageNumber = Integer.valueOf(pageNumberStr);
//        }
//        
//        pagingCriteria = new PagingCriteria(
//                pageNumber, 
//                10
//        );
//        
//        Page<Event> result = dbContext.get(
//                pagingCriteria,
//                searchEventCriteria
//        );
        
//        req.setAttribute("page", result);
        req.getRequestDispatcher("club/send-notification.jsp").forward(req, resp);
    }
}