package com.fuem.controllers;

import com.fuem.enums.FileType;
import com.fuem.enums.Role;
import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.Student;
import com.fuem.models.User;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FollowDAO;
import com.fuem.repositories.OrganizerDAO;
import com.fuem.repositories.StudentDAO;
import com.fuem.utils.FileHandler;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/admin/profile", "/club/profile", "/student/profile", "/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class ProfileController extends HttpServlet {

    /**
     * If requestUrlLength = 3, is accessing other profile
     *
     * @requestParameter role identity which kind of user profile accessing
     * "student" or "organizer"
     * @requestParameter id identity userId to find profile information
     *
     * If requestUrlLength = 4, is accessing self-profile
     *
     * @author HungHV
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestUrlLength = request.getRequestURI().split("/").length;

        switch (requestUrlLength) {
            case 3: // access other profile
                String role = request.getParameter("role");
                int id = Integer.parseInt(request.getParameter("id"));

                if (role.equals("student")) {
                    StudentDAO studentDAO = new StudentDAO();
                    Student student = studentDAO.getStudentById(id);

                    request.setAttribute("student", student);
                    request.getRequestDispatcher("student-profile.jsp").forward(request, response);
                } else {
                    OrganizerDAO organizerDAO = new OrganizerDAO();
                    EventDAO eventDAO = new EventDAO();
                    User user = (User) request.getSession().getAttribute("userInfor");
                    Organizer organizer = organizerDAO.getOrganizerById(id);
                    List<Event> recentEvents = eventDAO.getRecentEvents(id);

                    if (user.getRole().equals(Role.STUDENT)) {
                        FollowDAO followDAO = new FollowDAO();
                        boolean isFollowing = followDAO.isUserFollowing(user.getId(), id);
                        request.setAttribute("isFollowing", isFollowing);
                    }

                    request.setAttribute("organizer", organizer);
                    request.setAttribute("recentEvents", recentEvents);
                    request.getRequestDispatcher("organizer-profile.jsp").forward(request, response);
                }
                break;
            case 4: // access self-profile
                User user = (User) request.getSession().getAttribute("userInfor");

                if (!user.getRole().equals(Role.STUDENT)) {
                    OrganizerDAO organizerDAO = new OrganizerDAO();
                    int organizerId = user.getId();
                    EventDAO eventDAO = new EventDAO();
                    List<Event> recentEvents = eventDAO.getRecentEvents(user.getId());
                    request.setAttribute("recentEvents", recentEvents);
                    Organizer organizer = organizerDAO.getOrganizerById(organizerId);
                    request.setAttribute("userInfor", organizer);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                }
                break;
            default:
                request.getRequestDispatcher("error/500.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userInfor");
        int organizerId = user.getId();
        String fullname = request.getParameter("fullname");
        String acronym = request.getParameter("acronym");
        String description = request.getParameter("description");
        String email = request.getParameter("email");
        Role role = user.getRole();
        OrganizerDAO organizerDAO = new OrganizerDAO();
        Organizer currentOrganizer = organizerDAO.getOrganizerById(organizerId);
        String oldAvatarPath = currentOrganizer.getAvatarPath();
        String oldCoverPath = currentOrganizer.getCoverPath();

        String newAvatarPath = oldAvatarPath;
        String newCoverPath = oldCoverPath;

        // Handle avatar upload
        Part avatarFilePart = request.getPart("avatarFile");
        if (avatarFilePart != null && avatarFilePart.getSize() > 0) {
            newAvatarPath = FileHandler.processUploadFile(avatarFilePart, FileType.IMAGE);
            FileHandler.save(newAvatarPath, avatarFilePart, getServletContext(), FileType.IMAGE);
            if (oldAvatarPath != null) {
                FileHandler.deleteFile(getServletContext(), oldAvatarPath);
            }
        }

        // Handle cover upload
        Part coverFilePart = request.getPart("coverFile");
        if (coverFilePart != null && coverFilePart.getSize() > 0) {
            newCoverPath = FileHandler.processUploadFile(coverFilePart, FileType.IMAGE);
            FileHandler.save(newCoverPath, coverFilePart, getServletContext(), FileType.IMAGE);
            if (oldCoverPath != null) {
                FileHandler.deleteFile(getServletContext(), oldCoverPath);
            }

        }
        Organizer organizer = new Organizer(acronym, description, newCoverPath, organizerId, fullname, email, newAvatarPath);
        boolean isUpdated = organizerDAO.updateOrganizer(organizer);

        if (isUpdated) {
            Organizer org = new Organizer(acronym, description, newCoverPath, organizerId, fullname, email, newAvatarPath, role);
            request.getSession().setAttribute("userInfor", org); // update user session
            request.setAttribute("message", "Update successfully");
            doGet(request, response);
        } else {
            request.setAttribute("error", "Update failed");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
