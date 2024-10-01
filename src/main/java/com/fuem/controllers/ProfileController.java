package com.fuem.controllers;

import com.fuem.models.User;
import com.fuem.repositories.UserDAO; // Import UserDAO
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProfileController", urlPatterns = "/profile")
public class ProfileController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User u = (User) req.getSession().getAttribute("userInfor");
        String em = u.getEmail();
        if (em != null) {

            User user = userDAO.getUserByEmail(em);

            if (user != null) {

                req.setAttribute("userInfor", user);
            } else {

                req.setAttribute("errorMessage", "User not found.");
            }
        } else {

            req.setAttribute("errorMessage", "You must be logged in to view this page.");
            resp.sendRedirect("login.jsp");
            return;
        }

        req.getRequestDispatcher("student/student-profile.jsp").forward(req, resp);
    }
}