/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.repositories.UserDAO;
import com.fuem.utils.Hash;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author MinhThang
 */
@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset"})
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDao = new UserDAO();
        HttpSession session = request.getSession();
        String inputOtp = request.getParameter("otp");
        String email = String.valueOf(session.getAttribute("email"));
        String newPassword = request.getParameter("new-password");
        
        if (inputOtp.equalsIgnoreCase(String.valueOf(session.getAttribute("otp")))) {
            userDao.updatePassword(email, Hash.doHash(newPassword));
            request.setAttribute("message", "Change password successfully, please Sign In!");
            request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
            request.getSession().removeAttribute("otp");
        } else {
            request.setAttribute("message", "Wrong OTP!");
            request.getRequestDispatcher("authentication/forget-password.jsp").forward(request, response);
        }
    }
}
