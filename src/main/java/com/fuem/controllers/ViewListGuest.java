package com.fuem.controllers;

import com.fuem.daos.EventRegisteredDAO;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.models.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "viewguest", urlPatterns = {"/club/view-list-guest"})
public class ViewListGuest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EventRegisteredDAO dao = new EventRegisteredDAO();

        // Nhận eventId từ request
        String eventId = request.getParameter("eventId");
        request.setAttribute("eventId", eventId);
        String pageNumberStr = request.getParameter("page");
        Integer pageNumber = (pageNumberStr == null) ? 0 : Integer.valueOf(pageNumberStr);
        System.out.println("pagenum " + pageNumber);
        PagingCriteria pagingCriteria = new PagingCriteria(pageNumber, 10);
        
        Page<Student> pageGuest = dao.getEventGuestsByEventId(pagingCriteria, eventId);
        
        request.setAttribute("page", pageGuest);
        // Chuyển tiếp request và response đến view JSP
        request.getRequestDispatcher("view-list-guest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý POST nếu cần thiết
    }
}
