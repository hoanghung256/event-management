/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.controllers;

import java.io.IOException;

import com.fuem.models.User;
import com.fuem.repositories.TestRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hoang hung
 */
@WebServlet(name = "TestController", urlPatterns = "/test")
public class TestController extends HttpServlet {

    private TestRepository testRepository = new TestRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ArrayList<String> result = testRepository.get();

        // System.out.println(result.size());

        // req.setAttribute("names", result);
        // req.getRequestDispatcher("test.jsp").forward(req, resp);
        User user = new User();
        user.setAvatarPath("assets/img/user/1/01.png");
        user.setFullName("Trịnh Bá Hoàng Huy");
        user.setStudentId("De180057");
        user.setEmail("Huytbhde180057@fpt.edu.vn");

        // Store only fullName, studentId, and email in session scope as 'userInfor'
        req.getSession().setAttribute("userInfor", user);

        // Forward to the test-profile.jsp page
        req.getRequestDispatcher("student/student-profile.jsp").forward(req, resp);
        
    }
}
