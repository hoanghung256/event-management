/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.repositories.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author MinhThang
 */
@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset"})
public class ResetPasswordController extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String inputOtp = request.getParameter("otp");
        String email = String.valueOf(session.getAttribute("email"));
        String newPassword = request.getParameter("new-password");
        
        if (inputOtp.equalsIgnoreCase(String.valueOf(session.getAttribute("otp")))) {
            dao.updatePassword(email, newPassword);
            request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Wrong OTP!");
            request.getRequestDispatcher("authentication/forget-password.jsp").forward(request, response);
        }
    }
}
