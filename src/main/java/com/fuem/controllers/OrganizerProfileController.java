package com.fuem.controllers;

import com.fuem.enums.Role;
import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.User;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FollowDAO;
import com.fuem.repositories.OrganizerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author TuDK
 */
@WebServlet(name = "OrganizerProfileController", urlPatterns = {"/club/OrganizerProfileController"})
public class OrganizerProfileController extends HttpServlet {

    private OrganizerDAO organizerDAO;
    private EventDAO eventDAO;
    private FollowDAO followDAO;

    @Override
    public void init() {
        organizerDAO = new OrganizerDAO();
        eventDAO = new EventDAO();
        followDAO = new FollowDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object sessionUser = (session != null) ? session.getAttribute("userInfor") : null;
        String organizerIdParam = request.getParameter("organizerId");
        Organizer organizer = null;
        boolean canEdit = false;
        boolean canFollow = false;
        boolean hasFollowed = false;
        System.out.println("aaaaaaaaaaa");
        // Logic cho Guest
        if (sessionUser == null) { // Nếu không có session user, tức là Guest
            if (organizerIdParam != null) {
                int organizerId = Integer.parseInt(organizerIdParam);
                System.out.println("bbbbbbbbbb");
                organizer = organizerDAO.getOrganizerById(organizerId);
                canEdit = false; // Guest không có quyền chỉnh sửa
            }
        } // Logic cho User
        else if (sessionUser instanceof User) { // Nếu sessionUser là User
            if (organizerIdParam != null) {
                int organizerId = Integer.parseInt(organizerIdParam);
                organizer = organizerDAO.getOrganizerById(organizerId);
                System.out.println("ccccccccccc");
                User user = (User) sessionUser;
                canEdit = false; // User cũng không có quyền chỉnh sửa
                canFollow = true;
                hasFollowed = checkUserFollowStatus(user, organizerId);
            }
        } else if (sessionUser instanceof Organizer) {
            Organizer sessionOrganizer = (Organizer) sessionUser;
            System.out.println("dddddddddd");
            if (organizerIdParam == null) {
                organizer = organizerDAO.getOrganizerById(sessionOrganizer.getId());
                canEdit = true;
            } else {
                int organizerId = Integer.parseInt(organizerIdParam);
                organizer = organizerDAO.getOrganizerById(organizerId);

                if (sessionOrganizer.getRole() == Role.CLUB) {
                    canEdit = (organizerId == sessionOrganizer.getId());
                } else if (sessionOrganizer.getRole() == Role.ADMIN) {
                    canEdit = (organizerId == sessionOrganizer.getId());
                }
            }
        }
        if (organizer == null) {
            request.setAttribute("errorMessage", "Tổ chức không tồn tại.");
            System.out.println("eeeeeeeeeeee");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
            return;
        }
        request.setAttribute("org", organizer);
        request.setAttribute("canFollow", canFollow);
        request.setAttribute("canEdit", canEdit);
        getRecentEvents(request, (organizerIdParam != null) ? Integer.parseInt(organizerIdParam) : organizer.getId());
        request.getRequestDispatcher("club/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");  
        HttpSession session = request.getSession(false);
        Object sessionUser = (session != null) ? session.getAttribute("userInfor") : null;
        String organizerIdParam = request.getParameter("organizerId");
        Organizer organizer = null;
        String action = request.getParameter("action");

        // Đảm bảo organizerIdParam là số hợp lệ
        int organizerId;
        try {
            organizerId = Integer.parseInt(organizerIdParam);
        } catch (NumberFormatException e) {
            System.out.println("invalid id");
            request.setAttribute("error", "Invalid organizer ID.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        if (sessionUser instanceof User) {
            User user = (User) sessionUser;  // Lấy thông tin người dùng từ session
            if (user != null) {
                if ("follow".equals(action)) {
                    if (!checkUserFollowStatus(user, organizerId)) {
                        followOrganizer(user, organizerId);  
                        request.setAttribute("message", "Bạn đã theo dõi tổ chức này.");
                        response.sendRedirect(request.getContextPath() + "/OrganizerProfileController?organizerId=" + organizerId);
                    } else {
                        request.setAttribute("message", "Bạn đã theo dõi tổ chức này trước đó.");
                    }
                } else if ("unfollow".equals(action)) {
                    if (checkUserFollowStatus(user, organizerId)) {
                        unfollowOrganizer(user, organizerId);  // Bỏ theo dõi tổ chức
                        response.sendRedirect(request.getContextPath() + "/OrganizerProfileController?organizerId=" + organizerId);
                        request.setAttribute("message", "Bạn đã bỏ theo dõi tổ chức này.");
                    } else {
                        request.setAttribute("message", "Bạn chưa theo dõi tổ chức này.");
                    }
                }
            }
        } else if (sessionUser instanceof Organizer ){
            organizer = organizerDAO.getOrganizerById(organizerId);
            Organizer org = (Organizer) sessionUser;
            if (org != null && org.getId() == organizer.getId()) {
                updateOrganizerProfile(request, session, org);
                response.sendRedirect(request.getContextPath() + "/OrganizerProfileController?organizerId=" + organizer.getId());
            } else {
                request.setAttribute("error", "Bạn không có quyền chỉnh sửa hồ sơ này.");
                System.out.println("session = null");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }

    

    private void getRecentEvents(HttpServletRequest request, int organizerId) {
        List<Event> recentEvents = eventDAO.getRecentEvents(organizerId);
        request.setAttribute("recentEvents", recentEvents);
    }

    private boolean checkUserFollowStatus(User user, int organizerId) {
        return followDAO.isUserFollowing(user.getId(), organizerId);
    }

    private void followOrganizer(User user, int organizerId) {
        followDAO.addFollow(user.getId(), organizerId);
    }

    private void unfollowOrganizer(User user, int organizerId) {
        followDAO.removeFollow(user.getId(), organizerId);
    }

    private void updateOrganizerProfile(HttpServletRequest request, HttpSession session, Organizer organizer) {
        String fullname = request.getParameter("fullname");
        String acronym = request.getParameter("acronym");
        String email = request.getParameter("email");
        String description = request.getParameter("description");
        organizer.setFullname(fullname);
        organizer.setAcronym(acronym);
        organizer.setEmail(email);
        organizer.setDescription(description);

        organizerDAO.updateOrganizer(organizer);
        session.setAttribute("userInfor", organizer);
    }

    @Override
    public String getServletInfo() {
        return "OrganizerProfileController Servlet";
    }
}
