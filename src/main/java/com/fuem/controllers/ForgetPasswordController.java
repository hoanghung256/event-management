/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.repositories.UserDAO;
import com.fuem.utils.Gmail;
import com.fuem.utils.RandomGenerator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MinhThang
 */
@WebServlet(name = "ForgetPasswordController", urlPatterns = {"/forget"})
public class ForgetPasswordController extends HttpServlet {
    private final UserDAO dao = new UserDAO();
    private static final Logger logger = Logger.getLogger(ResetPasswordController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("authentication/forget-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = RandomGenerator.generate(RandomGenerator.NUMERIC, 6);
        
        try {
            if (dao.isEmailInDatabase(email)) {
                Gmail.sendWithOTP(email, otp);
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                request.getRequestDispatcher("authentication/reset-password.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Email does not exist");
                request.getRequestDispatcher("authentication/forget-password.jsp").forward(request, response);
            } 
        } catch (MalformedURLException e) {
           logger.log(Level.SEVERE, email, e);
        }
    }
}

