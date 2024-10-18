package com.fuem.controllers;

import com.fuem.enums.Role;
import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.Student;
import com.fuem.models.User;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FollowDAO;
import com.fuem.repositories.OrganizerDAO;
import com.fuem.repositories.StudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/admin/profile", "/club/profile", "/student/profile", "/profile"})
public class ProfileController extends HttpServlet {
    
    /**
     * If requestUrlLength = 3, is accessing other profile
     *      @requestParameter role identity which kind of user profile accessing "student" or "organizer"
     *      @requestParameter id identity userId to find profile information
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
}
