package com.fuem.controllers;

import com.fuem.models.User;
import com.fuem.repositories.SQLDatabase;
import com.fuem.repositories.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "SignUpController", urlPatterns = {"/sign-up"})
public class SignUpController extends HttpServlet {

    private UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String password = request.getParameter("password");
        String studentId = request.getParameter("studentId");
        String email = request.getParameter("email");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (fullname == null || password == null || email == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Please ensure all fields are filled correctly.");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
        }
        String[] emailSplit = email.split("@");
        if (!emailSplit[1].equalsIgnoreCase("fpt.edu.vn")) {
            request.setAttribute("error", "Email not allow, must be contain @fpt.edu.vn");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
        }

        User u = new User(fullname, studentId, email, password);
        System.out.println(u);

        boolean isAdded = userDao.addUser(u);
        if (isAdded) {
            request.setAttribute("message", "Sign up successful");
            request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Sign up failed. Try again!");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);

        }

//        // Save user data to the database
//        try (SQLDatabase db = new SQLDatabase()) {
//            db.generateConnection();
//            String insertQuery = "INSERT INTO users (fullname, email, password) VALUES (?, ?, ?)";
//            db.executePreparedStatement(insertQuery, username, email, password);
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("errorMessage", "An error occurred during registration.");
//            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
//            return;
//        }
        // Redirect to sign-in page after successful registration
//        response.sendRedirect("authentication/sign-in.jsp");
//    }
    }
}
