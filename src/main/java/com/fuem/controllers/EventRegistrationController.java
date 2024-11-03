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
import com.fuem.daos.EventDAO;
import com.fuem.daos.FileDAO;
import com.fuem.daos.OrganizerDAO;
import com.fuem.utils.FileHandler;
import com.fuem.utils.Gmail;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.net.MalformedURLException;
import java.sql.SQLException;
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
        fileSizeThreshold = 1024 * 1024 * 5,
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
        if (processRequest(request, response)) {
            return;
        }
        Organizer registerOrganizer = (Organizer) request.getSession().getAttribute("userInfor");
        EventBuilder eventBuilder = new EventBuilder()
                .setFullname(request.getParameter("fullname"))
                .setOrganizer(registerOrganizer)
                .setDescription(request.getParameter("description"))
                .setCategory(new Category(Integer.parseInt(request.getParameter("categoryId"))))
                .setLocation(new Location(Integer.parseInt(request.getParameter("locationId"))));

        LocalDate dateOfEvent = LocalDate.parse(request.getParameter("dateOfEvent"));

        if (dateOfEvent.isBefore(LocalDate.now()) || dateOfEvent.isEqual(LocalDate.now())) {
            request.setAttribute("error", "Date of event must after today!");
            request.getRequestDispatcher("register-event?method=get").forward(request, response);
            return;
        }
        eventBuilder.setDateOfEvent(dateOfEvent);

        LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
        LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));

        if (startTime.isAfter(endTime) || startTime.compareTo(endTime) == 0) {
            request.setAttribute("error", "Start time must before End time!");
            request.getRequestDispatcher("register-event?method=get").forward(request, response);
            return;
        }
        eventBuilder.setStartTime(startTime)
                .setEndTime(endTime);

        String guestRegisterLimit = request.getParameter("guestRegisterLimit");
        String guestRegisterDeadline = request.getParameter("guestRegisterDeadline");
        String collaboratorRegisterLimit = request.getParameter("collaboratorRegisterLimit");
        String collaboratorRegisterDeadline = request.getParameter("collaboratorRegisterDeadline");

        if (!guestRegisterLimit.equals("0") && guestRegisterDeadline.isBlank()) {
            request.setAttribute("error", "Require input Guest register deadline when Guest register limit more than 0!");
            request.getRequestDispatcher("register-event?method=get").forward(request, response);
            return;
        } else if (!guestRegisterDeadline.isBlank()) {
            eventBuilder.setGuestRegisterDeadline(LocalDate.parse(guestRegisterDeadline))
                    .setGuestRegisterLimit(Integer.parseInt(guestRegisterLimit));
            if (eventBuilder.getGuestRegisterDeadline().isAfter(eventBuilder.getDateOfEvent())) {
                request.setAttribute("error", "Register deadline must before or equal Date of event!");
                request.getRequestDispatcher("register-event?method=get").forward(request, response);
                return;
            } else if (eventBuilder.getGuestRegisterDeadline().isEqual(LocalDate.now())) {
                request.setAttribute("error", "Register deadline must after today");
                request.getRequestDispatcher("register-event?method=get").forward(request, response);
                return;
            }
        } else if (guestRegisterDeadline.isBlank()) {
            eventBuilder.setGuestRegisterDeadline(LocalDate.EPOCH);
        }

        if (!collaboratorRegisterLimit.equals("0") && collaboratorRegisterDeadline.isBlank()) {
            request.setAttribute("error", "Require input Collaborator register deadline when Collaborator register limit more than 0");
            request.getRequestDispatcher("register-event?method=get").forward(request, response);
            return;
        } else if (!collaboratorRegisterDeadline.isBlank()) {
            eventBuilder.setCollaboratorRegisterDeadline(LocalDate.parse(collaboratorRegisterDeadline))
                    .setCollaboratorRegisterLimit(Integer.parseInt(collaboratorRegisterLimit));
            if (eventBuilder.getCollaboratorRegisterDeadline().isAfter(eventBuilder.getDateOfEvent())) {
                request.setAttribute("error", "Register deadline must before or equal Date of event!");
                request.getRequestDispatcher("register-event?method=get").forward(request, response);
                return;
            } else if (eventBuilder.getCollaboratorRegisterDeadline().isEqual(LocalDate.now())) {
                request.setAttribute("error", "Register deadline must after today");
                request.getRequestDispatcher("register-event?method=get").forward(request, response);
                return;
            }
        } else if (collaboratorRegisterDeadline.isBlank()) {
            eventBuilder.setCollaboratorRegisterDeadline(LocalDate.EPOCH);
        }

        Collection<Part> parts = request.getParts();
        if (parts.size() < 2) {
            request.setAttribute("error", "Require upload 2 or more image!");
            request.getRequestDispatcher("register-event?method=get").forward(request, response);
            return;
        }
        try {
            List<String> imagePaths = FileHandler.processUploadFile(parts, FileType.IMAGE);
            eventBuilder.setImages(imagePaths);
        } catch (IOException e) {
            request.setAttribute("error", "Provide at least one image!");
            request.getRequestDispatcher("register-event?method=get").forward(request, response);
            return;
        }

        Event registerEvent = eventBuilder.build();
        EventDAO eventDao = new EventDAO();
        FileDAO fileDao = new FileDAO();

        try {
            int eventId = eventDao.insertAndGetGenerateKeyOfNewEvent(registerEvent);
            if (fileDao.insertEventImages(eventId, registerEvent.getImages()) == (registerEvent.getImages().size() - 1)) {
                request.setAttribute("message", "Register succeessfully");
                FileHandler.save(registerEvent.getImages(), parts, request.getServletContext(), FileType.IMAGE);
                
                new Thread(
                        () -> {
                            try {
                                Organizer admin = new OrganizerDAO().getAdmin();
                                Gmail.newPendingEvent(admin.getEmail(), admin.getAcronym(), registerOrganizer.getFullname(), registerEvent, request);
                            } catch (MalformedURLException e) {
                                Logger.getLogger(EventRegistrationController.class.getName()).log(Level.SEVERE, null, e);
                            }
                        }
                ).start();
            } else {
                request.setAttribute("error", "Register failed");
            }
        } catch (IOException | SQLException e) {
            request.setAttribute("error", "Register failed");
            Logger.getLogger(EventRegistrationController.class.getName()).log(Level.SEVERE, null, e);
        }

        request.getRequestDispatcher("register-event?method=get").forward(request, response);
    }

    private boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");

        if (method == null) {
            return false;
        }

        switch (method) {
            case "get":
                doGet(request, response);
                break;
            case "post":
                doPost(request, response);
                break;
            default:
                return false;
        }

        return true;
    }
}
