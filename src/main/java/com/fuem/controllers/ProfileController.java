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

                    request.getSession().setAttribute("userInfor", student);

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
                    EventDAO eventDAO = new EventDAO();

                    List<Event> recentEvents = eventDAO.getRecentEvents(user.getId());
                    request.setAttribute("recentEvents", recentEvents);
                }

                request.getRequestDispatcher("profile.jsp").forward(request, response);
                break;
            default:
                request.getRequestDispatcher("error/500.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra xem có phải multipart form không
        if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
            Collection<Part> parts = request.getParts(); // Lấy tất cả các Part

            // Giới hạn kích thước file
            long maxFileSize = 1024 * 1024; // 1 MB
            boolean isFileTooLarge = false;

            if (parts != null && !parts.isEmpty()) {
                for (Part part : parts) {
                    // Kiểm tra kích thước file
                    if (part.getSize() > maxFileSize) {
                        isFileTooLarge = true;
                        break;
                    }
                }

                // Kiểm tra xem có file nào vượt quá kích thước cho phép không
                if (isFileTooLarge) {
                    request.setAttribute("error", "The image file is too large. Please choose a different image.");
                } else {
                    List<String> avatarPaths = FileHandler.processUploadFile(parts, FileType.IMAGE);

                    // Kiểm tra xem có avatar được upload không
                    if (!avatarPaths.isEmpty()) {
                        String newAvatarPath = avatarPaths.get(0);

                        // Lấy thông tin sinh viên từ session
                        Student student = (Student) request.getSession().getAttribute("userInfor");
                        if (student != null) {
                            String studentId = student.getStudentId();
                            String oldAvatarPath = student.getAvatarPath(); 
                            
                            StudentDAO studentDao = new StudentDAO();
                            boolean isUpdated = studentDao.updateStudentAvatar(studentId, newAvatarPath);

                            if (isUpdated) {
                                // Xoá avatar cũ nếu tồn tại
                                if (oldAvatarPath != null && !oldAvatarPath.isEmpty()) {
                                    FileHandler.deleteFile(getServletContext(), oldAvatarPath);
                                }

                                // Cập nhật lại thông tin sinh viên trong session sau khi thay đổi avatar
                                student.setAvatarPath(newAvatarPath);
                                request.getSession().setAttribute("userInfor", student);

                                // Lưu avatar mới
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

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

}
