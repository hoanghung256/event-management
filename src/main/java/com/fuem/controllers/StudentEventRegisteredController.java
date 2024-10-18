/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Student;
import com.fuem.repositories.EventRegisteredDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "StudentEventRegisteredController", urlPatterns = {"/student/registered-event"})
public class StudentEventRegisteredController extends HttpServlet {

    private final EventRegisteredDAO eventRegisteredDAO = new EventRegisteredDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StudentEventRegisteredController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StudentEventRegisteredController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EventRegisteredDAO eventRegisteredDAO = new EventRegisteredDAO();
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("userInfor");
        if (student != null) {
            String studentId = student.getStudentId();
            System.out.println(studentId);
            List<Event> registeredEvents = eventRegisteredDAO.getRegisteredEventListByStudentId(studentId);
            System.out.println(registeredEvents);

            request.setAttribute("registeredEvents", registeredEvents);
            request.getRequestDispatcher("registered-event.jsp").forward(request, response);
        } else {
            response.sendRedirect("error/500.jsp");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("userInfor");
        String action = request.getParameter("action");
        String studentId = student.getStudentId();

        if ("cancel".equals(action)) {
            String eventIdStr = request.getParameter("eventId");
            String role = request.getParameter("role");
            int eventId = Integer.parseInt(eventIdStr);
            // Giả sử bạn đã có một DAO để xử lý việc hủy đăng ký
            EventRegisteredDAO eventRegistrationDAO = new EventRegisteredDAO();

            boolean isCancelled;

            // Kiểm tra vai trò và thực hiện hủy đăng ký
            if ("GUEST".equals(role)) {
                isCancelled = eventRegistrationDAO.cancelGuestRegistration(studentId, eventId);
                System.out.println("cancel guesst");// Gọi hàm hủy đăng ký khách
            } else if ("COLLABORATOR".equals(role)) {
                isCancelled = eventRegistrationDAO.cancelCollaboratorRegistration(studentId, eventId);
                System.out.println("cancel collab");// Gọi hàm hủy đăng ký cộng tác viên
            } else {
                // Xử lý khi không có vai trò phù hợp
                request.setAttribute("error", "Invalid role for cancellation.");
                request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                return;
            }

            // Kiểm tra kết quả hủy đăng ký
            if (isCancelled) {
                request.setAttribute("message", "Successfully cancelled registration.");
            } else {
                request.setAttribute("error", "Failed to cancel registration.");
            }
            System.out.println("eeeeeeeeeeeeeeeeeee");
            response.sendRedirect(request.getContextPath() + "/student/registered-event");
            // Chuyển hướng hoặc trả về trang cần thiết
//        request.getRequestDispatcher("student/registered-event").forward(request, response);
        }
        System.out.println("aaaaaaaaaaaaaaaa");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
