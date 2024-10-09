package com.fuem.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
*
* @author hoang hung
*/
@WebServlet(name = "TestController", urlPatterns = "/test")
@MultipartConfig
public class TestController extends HttpServlet {
   
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         System.out.println("hello");    
         req.getRequestDispatcher("test.jsp").forward(req, resp);
   }
}