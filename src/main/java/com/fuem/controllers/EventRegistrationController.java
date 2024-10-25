/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.enums.FileType;
import com.fuem.models.Category;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Organizer;
import com.fuem.models.builders.EventBuilder;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FileDAO;
import com.fuem.utils.FileHandler;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "EventRegistrationController", urlPatterns = {"/club/register-event", "/admin/register-event"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class EventRegistrationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EventDAO dao = new EventDAO();
        List<Category> cates = dao.getAllCategory();
        List<Location> locations = dao.getAllLocations();

        request.setAttribute("categories", cates);
        request.setAttribute("locations", locations);
        request.getRequestDispatcher("event-registration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Organizer registerOrganizer = (Organizer) request.getSession().getAttribute("userInfor");
        EventBuilder eventBuilder = new EventBuilder()
                .setFullname(request.getParameter("fullname"))
                .setOrganizer(registerOrganizer)
                .setDescription(request.getParameter("description"))
                .setCategory(new Category(Integer.parseInt(request.getParameter("categoryId"))))
                .setLocation(new Location(Integer.parseInt(request.getParameter("locationId"))))
                .setDateOfEvent(LocalDate.parse(request.getParameter("dateOfEvent")))
                .setStartTime(LocalTime.parse(request.getParameter("startTime")))
                .setEndTime(LocalTime.parse(request.getParameter("endTime")));

        String guestRegisterLimit = request.getParameter("guestRegisterLimit");
        String guestRegisterDeadline = request.getParameter("guestRegisterDeadline");
        String collaboratorRegisterLimit = request.getParameter("collaboratorRegisterLimit");
        String collaboratorRegisterDeadline = request.getParameter("collaboratorRegisterDeadline");

        if ((!guestRegisterDeadline.isBlank() && guestRegisterLimit.equals("0"))
                || (guestRegisterDeadline.isBlank() && !guestRegisterLimit.equals("0"))) {
            request.setAttribute("error", "Must input Guest limit when select Guest register deadline or conversely!");
            request.getRequestDispatcher("event-registration.jsp").forward(request, response);
            return;
        } else if (!guestRegisterDeadline.isBlank()) {
            eventBuilder.setGuestRegisterDeadline(LocalDate.parse(guestRegisterDeadline));
            if (eventBuilder.getGuestRegisterDeadline().isAfter(eventBuilder.getDateOfEvent())) {
                request.setAttribute("error", "register deadline must before or equal Date of event!");
                request.getRequestDispatcher("event-registration.jsp").forward(request, response);
            }
            eventBuilder.setGuestRegisterLimit(Integer.parseInt(guestRegisterLimit));
        }

        if ((!collaboratorRegisterDeadline.isBlank() && collaboratorRegisterLimit.equals("0"))
                || (collaboratorRegisterDeadline.isBlank() && !collaboratorRegisterLimit.equals("0"))) {
            request.setAttribute("error", "Require Collaborators limit when select Collaborator register deadline or conversely!");
            request.getRequestDispatcher("event-registration.jsp").forward(request, response);
            return;
        } else if (!collaboratorRegisterDeadline.isBlank()) {
            eventBuilder.setCollaboratorRegisterDeadline(LocalDate.parse(collaboratorRegisterDeadline));
            if (eventBuilder.getCollaboratorRegisterDeadline().isAfter(eventBuilder.getDateOfEvent())) {
                request.setAttribute("error", "Register deadline must before or equal Date of event!");
                request.getRequestDispatcher("event-registration.jsp").forward(request, response);
            }
        }
        eventBuilder.setCollaboratorRegisterLimit(Integer.parseInt(collaboratorRegisterLimit));

        Collection<Part> parts = request.getParts();
        try {
            List<String> imagePaths = FileHandler.processUploadFile(parts, FileType.IMAGE);
            eventBuilder.setImages(imagePaths);
        } catch (IOException e) {
            request.setAttribute("error", "Provide at least one image!");
            request.getRequestDispatcher("event-registration.jsp").forward(request, response);
            return;
        }
        
        Event registerEvent = eventBuilder.build();
        EventDAO eventDao = new EventDAO();
        FileDAO fileDao = new FileDAO();
        
        int eventId = eventDao.insertAndGetGenerateKeyOfNewEvent(registerEvent);
        try {
            if (fileDao.insertEventImages(eventId, registerEvent.getImages()) == (registerEvent.getImages().size() - 1)) {
                request.setAttribute("message", "Register successfully");
                FileHandler.save(registerEvent.getImages(), parts, request.getServletContext(), FileType.IMAGE);
            } else {
                request.setAttribute("error", "Register failed");
            }
        } catch (IOException e) {
            Logger.getLogger(EventRegistrationController.class.getName()).log(Level.SEVERE, null, e);
        }

        request.getRequestDispatcher("event-registration.jsp").forward(request, response);
    }
}
