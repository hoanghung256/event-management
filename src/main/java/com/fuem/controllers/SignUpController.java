package com.fuem.controllers;

import com.fuem.enums.Gender;
import com.fuem.models.Student;
import com.fuem.daos.StudentDAO;
import com.fuem.utils.Gmail;
import com.fuem.utils.Hash;
import com.fuem.utils.RandomGenerator;
import com.fuem.utils.Validator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 *
 * @author khim
 */
@WebServlet(name = "SignUpController", urlPatterns = {"/sign-up"})
public class SignUpController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StudentDAO userDao = new StudentDAO();
        String fullname = request.getParameter("fullname");
        String password = request.getParameter("password");
        String studentId = request.getParameter("studentId").toUpperCase();
        String email = request.getParameter("email");
        String confirmPassword = request.getParameter("confirmPassword");
        String inputOTP = request.getParameter("inputOTP");
        Gender gender = Gender.valueOf(request.getParameter("gender"));

        // Verify email case
        if (inputOTP != null) {
            String otp = (String) request.getSession().getAttribute("OTP");

            if (!otp.equals(inputOTP)) {
                request.setAttribute("error", "Wrong OTP!");
                request.getRequestDispatcher("authentication/verify-email.jsp").forward(request, response);
                return;
            }
            Student u = new Student(
                    fullname,
                    studentId,
                    email,
                    Hash.doHash(password)
            );
            u.setGender(gender);
            u.setAvatarPath("/assets/img/user/default-avatar.jpg");

            boolean isAdded = userDao.addUser(u);
            if (isAdded) {
                request.setAttribute("message", "Sign up successful, please sign in to access!");
                request.getRequestDispatcher("authentication/sign-in.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Sign up failed. Try again!");
                request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            }
            request.getSession().removeAttribute("otp");
            request.getSession().removeAttribute("registerInfor");
            return;
        }

        // Submit data first time
        if (fullname == null || password == null || email == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Please ensure all fields are filled correctly.");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        }
        if ((fullname == null || fullname.isEmpty())
                && (password == null || password.isEmpty())
                && (email == null || email.isEmpty())
                && (studentId == null || studentId.isEmpty())
                && (confirmPassword == null || confirmPassword.isEmpty())) {
            request.setAttribute("error", "Please fill all blanks needed.");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        }
        if (!Validator.isFullNameValid(fullname)) {
            request.setAttribute("error", "Full name can not contains special characters.");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        }
        if ((!Validator.isStudentIdMatch(email, studentId))) {
            request.setAttribute("error", "Student ID is not valid or not match with your email.");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        }
        if (!Validator.isEmailBelongFPT(email)) {
            request.setAttribute("error", "Email not allow, must be FPT Education email");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        } else if (userDao.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email have been registered! Want to sign in?");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        } else if (userDao.isStudentIdExist(studentId)) {
            request.setAttribute("error", "Student ID have been registered! Want to sign in?");
            request.getRequestDispatcher("authentication/sign-up.jsp").forward(request, response);
            return;
        } else {
            Student u = new Student(fullname, studentId, email, password);
            u.setGender(gender);
            String otp = RandomGenerator.generate(RandomGenerator.NUMERIC, 6);
            Gmail.sendWithOTP(email, otp);
            request.getSession().setAttribute("OTP", otp);
            request.setAttribute("registerInfor", u);
            request.getRequestDispatcher("authentication/verify-email.jsp").forward(request, response);
            return;
        }
    }
}
