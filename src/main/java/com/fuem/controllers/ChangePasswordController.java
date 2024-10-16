package com.fuem.controllers;

import com.fuem.models.Student;
import com.fuem.repositories.StudentDAO;
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

@WebServlet("/student/change-password")
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        String email = ((Student) session.getAttribute("userInfor")).getEmail();

        StudentDAO studentDAO = new StudentDAO();

        if (studentDAO.checkCurrentPassword(email, Hash.doHash(currentPassword))) {
            if (newPassword.equals(confirmPassword)) {

                studentDAO.updatePassword(email, newPassword);
                request.setAttribute("success", "Change password success.");

            } else {
                request.setAttribute("error", "New password do not match.");
            }
        } else {
            request.setAttribute("error", "Current password  incorrect. \n"
                    + "Please try again!");
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);

    }

}
