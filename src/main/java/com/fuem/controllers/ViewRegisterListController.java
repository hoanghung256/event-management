package com.fuem.controllers;

import com.fuem.models.EventGuest;
import com.fuem.daos.EventRegisterDAO;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * 
 * @author KhiemHV 
 */
@WebServlet(name = "ViewRegisterList", urlPatterns = {"/admin/view-register-list"})
public class ViewRegisterListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventRegisterDAO eventRegisterDAO = new EventRegisterDAO();

        // Lấy số trang hiện tại từ request
        String pageNumberStr = request.getParameter("page");
        int pageNumber = (pageNumberStr == null) ? 0 : Integer.parseInt(pageNumberStr);

        // Thiết lập tiêu chí phân trang với offset và số hàng muốn lấy
        PagingCriteria pagingCriteria = new PagingCriteria(pageNumber * 10, 10);

        // Lấy danh sách khách đã đăng ký từ DAO
        Page<EventGuest> registeredGuestsList = eventRegisterDAO.getRegisteredGuestsList(pagingCriteria);

        // Đặt danh sách khách vào request để JSP có thể truy cập
        request.setAttribute("registeredGuestsList", registeredGuestsList);
        request.setAttribute("pageNumber", pageNumber);  // Truyền số trang hiện tại cho JSP

        // Chuyển hướng đến trang JSP để hiển thị danh sách
        request.getRequestDispatcher("view-register-list.jsp").forward(request, response);
    }
}
