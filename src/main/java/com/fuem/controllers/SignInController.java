
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.enums.Role;
import com.fuem.models.Organizer;
import com.fuem.repositories.StudentDAO;
import com.fuem.models.Student;
import com.fuem.repositories.OrganizerDAO;
import com.fuem.utils.Hash;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String chooseRole = request.getParameter("role");
        String hashPassword = Hash.doHash(password);

        try {
            if ("organizer".equalsIgnoreCase(chooseRole)) {
                OrganizerDAO organizerDAO = new OrganizerDAO();
                Organizer organizer = organizerDAO.getOrganizerByEmailAndPassword(email, hashPassword);

                if (organizer != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userInfor", organizer);
                    if (organizer.getRole() == Role.ADMIN) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/club/dashboard");
                    }
                } else {
                    request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                    request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
                }
            } else {
                StudentDAO userDAO = new StudentDAO();
                Student user = userDAO.getStudentByEmailAndPassword(email, hashPassword);

                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userInfor", user);
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                    request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
                }
                return;
            }
        } catch (IOException | ServletException e) {
            Logger.getLogger(SignInController.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}