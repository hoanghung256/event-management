/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 *
 * @author TRINHHUY
 */
@MultipartConfig
@WebServlet(name = "UploadImageController", urlPatterns = {"/upload-image"})
public class UploadImageController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UploadImageController() {
        super();
    }

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("club/upload.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            Part part = request.getPart("photo");
            String realPath = "C:\\Users\\ADMIN\\Downloads\\SWP\\FinnalSWP\\event-management\\target\\event-management-1.0\\assets\\user-event-image";
            System.out.println("Real Path: " + realPath);
            String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
            Path uploadPath = Path.of(realPath);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            part.write(realPath + "\\" + filename); 
            request.setAttribute("id", id);
            request.setAttribute("name", name);
            request.setAttribute("filename", filename);
            RequestDispatcher rd = request.getRequestDispatcher("club/upload.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
