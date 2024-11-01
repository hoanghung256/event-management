package com.fuem.controllers;

import com.fuem.enums.Role;
import com.fuem.models.Organizer;
import com.fuem.models.Student;
import com.fuem.models.User;
import com.fuem.repositories.OrganizerDAO;
import com.fuem.repositories.StudentDAO;
import com.fuem.utils.Hash;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ChangePasswordController", urlPatterns = {"/admin/change-password", "/club/change-password", "/student/change-password"})
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
        User user = (User) request.getSession().getAttribute("userInfor");
        Role userRole = user.getRole();

        if (userRole.equals(Role.STUDENT)) {
            HttpSession session = request.getSession();
            String email = ((Student) session.getAttribute("userInfor")).getEmail();

            StudentDAO studentDAO = new StudentDAO();

            if (studentDAO.checkCurrentPassword(email, Hash.doHash(currentPassword))) {
                if (newPassword.equals(confirmPassword)) {

                    studentDAO.updatePassword(email, Hash.doHash(newPassword));
                    request.setAttribute("success", "Change password success.");

                } else {
                    request.setAttribute("error", "New password do not match.");
                }
            } else {
                request.setAttribute("error", "Current password  incorrect. \n"
                        + "Please try again!");
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } else if (userRole.equals(Role.CLUB) || userRole.equals(Role.ADMIN)) {
            HttpSession session = request.getSession();
            String email = ((Organizer) session.getAttribute("userInfor")).getEmail();
            
            OrganizerDAO organizerDAO = new OrganizerDAO();
            if (organizerDAO.checkCurrentPassword(email, Hash.doHash(currentPassword))) {
                if (newPassword.equals(confirmPassword)) {

                    organizerDAO.updatePassword(email, Hash.doHash(newPassword));
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

}
