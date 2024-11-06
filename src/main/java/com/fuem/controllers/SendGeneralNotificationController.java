/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import static com.fuem.controllers.SendNotificationController.notiDAO;
import com.fuem.models.Organizer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AnhNQ
 */
@WebServlet(name = "SendGeneralNotificationController", urlPatterns = {"/admin/send-general-notification"})
public class SendGeneralNotificationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("send-general-notification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Organizer organizer = (Organizer) request.getSession().getAttribute("userInfor");
        String content = request.getParameter("content");
        String receiver = request.getParameter("receiver");
        
        int newNotiId = notiDAO.insertAndGetIdOfNewNotification(organizer.getId(), content);
        int numberOfReceivers = 0;
        if ("student".equals(receiver)) {
            try {
                numberOfReceivers = notiDAO.insertNotificationReceiverForAllStudent(newNotiId);
            } catch (SQLException ex) {
                Logger.getLogger(SendGeneralNotificationController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("club".equals(receiver)) {
            try {
                numberOfReceivers = notiDAO.insertNotificationReceiverForAllClub(newNotiId);
            } catch (SQLException ex) {
                Logger.getLogger(SendGeneralNotificationController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        request.setAttribute("numberOfReceivers", numberOfReceivers);
        request.getRequestDispatcher("send-general-notification.jsp").forward(request, response);
    }
}
