package com.fuem.controllers;

import com.fuem.enums.FileType;
import com.fuem.enums.Role;
import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.Student;
import com.fuem.models.User;
import com.fuem.daos.EventDAO;
import com.fuem.daos.FollowDAO;
import com.fuem.daos.OrganizerDAO;
import com.fuem.daos.StudentDAO;
import com.fuem.utils.FileHandler;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Collection;
import java.util.List;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/admin/profile", "/club/profile", "/student/profile", "/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 1,
        maxRequestSize = 1024 * 1024 * 2
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
                    if (student == null) {
                        response.sendRedirect("sign-in");
                    } else {
                        request.getSession().setAttribute("userInfor", student);
                        request.setAttribute("student", student);
                        request.getRequestDispatcher("student-profile.jsp").forward(request, response);
                    }
                } else {
                    OrganizerDAO organizerDAO = new OrganizerDAO();
                    EventDAO eventDAO = new EventDAO();
                    User user = (User) request.getSession().getAttribute("userInfor");
                    Organizer organizer = organizerDAO.getOrganizerById(id);
                    List<Event> recentEvents = eventDAO.getRecentEvents(id);
                    System.out.println(organizer);
                    if (user == null) {
                        request.setAttribute("organizer", organizer);
                        request.setAttribute("recentEvents", recentEvents);
                    } else if (user.getRole().equals(Role.STUDENT)) {
                        FollowDAO followDAO = new FollowDAO();
                        boolean isFollowing = followDAO.isUserFollowing(user.getId(), id);
                        request.setAttribute("isFollowing", isFollowing);
                        request.setAttribute("organizer", organizer);
                        request.setAttribute("recentEvents", recentEvents);
                    }
                    request.getRequestDispatcher("organizer-profile.jsp").forward(request, response);
                }
                break;

            case 4: // access self-profile
                User user = (User) request.getSession().getAttribute("userInfor");
                if (user == null) {
                    response.sendRedirect("sign-in");
                } else {
                    if (!user.getRole().equals(Role.STUDENT)) {
                        EventDAO eventDAO = new EventDAO();
                        List<Event> recentEvents = eventDAO.getRecentEvents(user.getId());
                        request.setAttribute("recentEvents", recentEvents);
                    }

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
        Role userRole = user.getRole();

        if (userRole.equals(Role.STUDENT)) {
            if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
                Collection<Part> parts = request.getParts(); // Lấy tất cả các Part

                long maxFileSize = 1024 * 1024; // 1 MB
                boolean isFileTooLarge = false;

                if (parts != null && !parts.isEmpty()) {
                    for (Part part : parts) {
                        if (part.getSize() > maxFileSize) {
                            isFileTooLarge = true;
                            break;
                        }

                        if (isFileTooLarge) {
                            request.setAttribute("error", "The image file is too large. Please choose a different image.");
                        } else {
                            List<String> avatarPaths = FileHandler.processUploadFile(parts, FileType.IMAGE);

                            if (!avatarPaths.isEmpty()) {
                                String newAvatarPath = avatarPaths.get(0);

                                Student student = (Student) request.getSession().getAttribute("userInfor");
                                if (student != null) {
                                    String studentId = student.getStudentId();
                                    String oldAvatarPath = student.getAvatarPath();

                                    StudentDAO studentDao = new StudentDAO();
                                    boolean isUpdated = studentDao.updateStudentAvatar(studentId, newAvatarPath);

                                    if (isUpdated) {
                                        if (oldAvatarPath != null && !oldAvatarPath.isEmpty()) {
                                            FileHandler.deleteFile(getServletContext(), oldAvatarPath);
                                        }

                                        student.setAvatarPath(newAvatarPath);
                                        request.getSession().setAttribute("userInfor", student);

                                        FileHandler.save(avatarPaths, parts, getServletContext(), FileType.IMAGE);

                                        request.setAttribute("success", "Avatar updated successfully!");
                                    } else {
                                        request.setAttribute("error", "Failed to update avatar.");
                                    }
                                }
                            }
                        }
                    }
                }
            }

            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if (userRole.equals(Role.CLUB) || userRole.equals(Role.ADMIN)) {
            int organizerId = user.getId();
            String fullname = request.getParameter("fullname");
            String acronym = request.getParameter("acronym");
            String description = request.getParameter("description");
            String email = request.getParameter("email");
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
            organizer.setRole(userRole);

            if (isUpdated) {
                request.getSession().setAttribute("userInfor", organizer);
                request.setAttribute("message", "Update successfully");
            } else {
                request.setAttribute("error", "Update failed");
            }

            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
