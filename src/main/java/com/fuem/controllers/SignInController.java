/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Organizer;
import com.fuem.repositories.UserDAO;
import com.fuem.models.User;
import com.fuem.repositories.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author khim
 */

@WebServlet("/sign-in")
public class SignInController extends HttpServlet {

    private UserDAO userDAO;
    private OrganizerDAO organizerDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO(); // Khởi tạo UserDAO
        organizerDAO= new OrganizerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang đăng nhập
        try {
            request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            Logger.getLogger(SignInController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        if ("organizer".equalsIgnoreCase(role)) {
            if(organizerDAO.isEmailAndPasswordExist(email, password)){
                Organizer organizer = organizerDAO.getOrganizerByEmailAndPassword(email, password);
                HttpSession session = request.getSession();
                session.setAttribute("userInfor", organizer);
                request.getRequestDispatcher("test.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
            }
        } else {
            if (userDAO.isEmailAndPasswordExist(email, password)) {
                // Đăng nhập thành công
                User user = userDAO.getUserByEmailAndPassword(email, password);
                HttpSession session = request.getSession();
                session.setAttribute("userInfor", user);
                response.sendRedirect("index.html"); // Chuyển hướng đến trang chính
            } else {
                // Đăng nhập thất bại
                request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        userDAO.closeConnection(); // Đóng kết nối khi servlet hủy
    }
}

