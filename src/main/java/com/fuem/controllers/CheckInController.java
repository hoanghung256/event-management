/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.User;
import com.fuem.models.builders.EventBuilder;
import com.fuem.daos.EventRegisterDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalTime;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "CheckInController", urlPatterns = {"/admin/check-in", "/club/check-in", "/student/check-in"})
public class CheckInController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userInfor");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        switch (user.getRole().toString()) {
            case "STUDENT": // Perform check-in for student
                EventRegisterDAO dao = new EventRegisterDAO();
                boolean[] attendanceStatus = dao.getGuestAttendanceStatus(eventId, user.getId());
                boolean isRegistered = attendanceStatus[0];
                boolean isAttended = attendanceStatus[1];
                boolean isCancel = attendanceStatus[2];
                boolean isActionSuccess = false;

                if (isAttended) {
                    request.setAttribute("error", "You have checked-in!");
                } else if (isRegistered || isCancel) {
                    isActionSuccess = dao.updateAttendanceStatus(eventId, user.getId());
                    if (isActionSuccess) {
                        request.setAttribute("message", "Checked-in successfully!");
                    } else {
                        request.setAttribute("error", "Checked-in failed!");
                    }
                } else {
                    isActionSuccess = dao.insertAttendaceStatus(eventId, user.getId());
                    if (isActionSuccess) {
                        request.setAttribute("message", "Checked-in successfully!");
                    } else {
                        request.setAttribute("error", "Checked-in failed!");
                    }
                }

                request.getRequestDispatcher("check-in-result.jsp").forward(request, response);
                break;
            default:    // Return check-in QR code for organizer
                Event e = new EventBuilder()
                        .setId(eventId)
                        .setFullname(request.getParameter("name"))
                        .setLocation(
                                new Location(request.getParameter("location"))
                        )
                        .setStartTime(LocalTime.parse(request.getParameter("start")))
                        .setEndTime(LocalTime.parse(request.getParameter("end")))
                        .setDateOfEvent(LocalDate.parse(request.getParameter("date")))
                        .build();
                
                request.setAttribute("event", e);
                request.getRequestDispatcher("check-in.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request, response);
    }
}