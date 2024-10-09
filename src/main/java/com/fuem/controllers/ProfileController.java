package com.fuem.controllers;

import com.fuem.models.Student;
import com.fuem.repositories.StudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author trinh huy
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/student/profile"})
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StudentDAO userDAO = new StudentDAO();
        Student u = (Student) req.getSession().getAttribute("userInfor");
        String email = u.getEmail();
        
        if (email != null) {
            Student user = userDAO.getUserByEmail(email);
            if (user != null) {
                req.setAttribute("userInfor", user);
            } else {
                req.setAttribute("errorMessage", "User not found.");
            }
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        } else {
            req.setAttribute("errorMessage", "You must be logged in to view this page.");
            req.getRequestDispatcher("authentication/sign-in.jsp").forward(req, resp);
        }
    }
}
