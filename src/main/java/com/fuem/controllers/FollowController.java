/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuem.controllers;

import com.fuem.models.Student;
import com.fuem.repositories.FollowDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author HungHV
 */
@WebServlet(name="FollowController", urlPatterns={"/admin/follow", "/club/follow", "/student/follow"})
public class FollowController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Student student = (Student) request.getSession().getAttribute("userInfor");
        int organizerId = Integer.parseInt(request.getParameter("organizerId"));
        String action = request.getParameter("action");
        FollowDAO dao = new FollowDAO();
        
        switch (action) {
            case "follow":
                dao.doFollow(student.getId(), organizerId);
                break;
            case "unfollow":
                dao.doUnfollow(student.getId(), organizerId);
                break;
        }
        
        response.sendRedirect(request.getContextPath() + "/profile?role=organizerId&id=" + organizerId);
    }
}
