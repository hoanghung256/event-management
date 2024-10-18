/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.models.Organizer;
import com.fuem.repositories.OrganizerDAO;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.utils.Validator;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author TRINHHUY
 */
@WebServlet(name = "ManageClubsController", urlPatterns = {"/admin/manage-clubs"})
public class ManageClubsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrganizerDAO dao = new OrganizerDAO();

        String searchValue = request.getParameter("searchValue");

        String pageNumberStr = request.getParameter("page");
        Integer pageNumber = (pageNumberStr == null) ? 0 : Integer.valueOf(pageNumberStr);
        PagingCriteria pagingCriteria = new PagingCriteria(pageNumber, 10);

        Page<Organizer> pageOrganizer = dao.getOrganizer(pagingCriteria, searchValue);

        request.setAttribute("previousSearchValue", searchValue);
        request.setAttribute("page", pageOrganizer);

        request.getRequestDispatcher("manage-clubs.jsp").forward(request, response); // Chuyển hướng đến trang JSP

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrganizerDAO dao = new OrganizerDAO();
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("organizerId");

            try {
                // Chuyển đổi từ String sang int
                int id = Integer.parseInt(idStr);
                boolean isDeleted = dao.deleteOrganizerById(id);

                if (isDeleted) {
                    request.setAttribute("deleteSuccess", "Club deleted successfully!");
                    doGet(request, response);
                } else {
                    request.setAttribute("deleteError", "Unable to delete Club. ");
                    doGet(request, response);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("deleteError", "Invalid club.");
                doGet(request, response);
            }

        } else if ("add".equalsIgnoreCase(action)) {

            String fullname = request.getParameter("fullname");
            String acronym = request.getParameter("acronym");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");

            // Kiểm tra mật khẩu và xác nhận mật khẩu
            if (!password.equals(confirmPassword)) {
                request.setAttribute("addError", "Passwords do not match.");
                doGet(request, response);
                return;
            } else if (!Validator.isFullNameValid(fullname)) {
                request.setAttribute("addError", "Special characters are not allowed ");
                doGet(request, response);
                return;
            }

            Organizer newOrganizer = new Organizer();
            newOrganizer.setFullname(fullname);
            newOrganizer.setEmail(email);
            newOrganizer.setAcronym(acronym);
            newOrganizer.setPassword(password);

            boolean isAdded = dao.addOrganizer(newOrganizer);

            if (isAdded) {
                request.setAttribute("addSuccess", "Club added successfully!");
                doGet(request, response);
            } else {
                request.setAttribute("addError", "Email or Acronym  already exists.");
                doGet(request, response);
            }
        } else if ("edit".equalsIgnoreCase(action)) {
            
            int id = Integer.parseInt(request.getParameter("id"));
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String acronym = request.getParameter("acronym");

            if (!Validator.isFullNameValid(fullname)) {
                request.setAttribute("editError", "Special characters are not allowed ");
                doGet(request, response);
                return;
            }

            Organizer updateOrganizer = new Organizer();
            updateOrganizer.setId(id);
            updateOrganizer.setFullname(fullname);
            updateOrganizer.setAcronym(acronym);
            updateOrganizer.setEmail(email);

            boolean isUpdated = dao.updateOrganizerById(updateOrganizer);

            if (isUpdated) {
                request.setAttribute("editSuccess", "Club updated successfully!"); // Thiết lập thông báo thành công
                doGet(request, response); // Chuyển tiếp lại để hiển thị thông báo
            } else {
                request.setAttribute("editError", "Failed to update Club information.");
                doGet(request, response);
            }
        } else {
            doGet(request, response);
        }
    }
}
