package com.fuem.controllers;

import com.fuem.enums.FileType;
import com.fuem.models.Category;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.repositories.EventDAO;
import com.fuem.repositories.FileDAO;
import com.fuem.utils.FileHandler;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditEventController", urlPatterns = {"/club/edit-event"})
@MultipartConfig // Cho phép servlet xử lý file upload
public class EditEventController extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();
    private FileDAO fileDAO = new FileDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventId = request.getParameter("eventId");

        if (eventId != null) {
            Event event = eventDAO.getEventDetails(Integer.parseInt(eventId));

            // Kiểm tra trạng thái của sự kiện
            String eventStatus = eventDAO.getEventStatus(event.getId());
            if (!"pending".equalsIgnoreCase(eventStatus)) {
                request.setAttribute("error", "You can only edit events with 'pending' status.");
                request.getRequestDispatcher("error-page.jsp").forward(request, response);
                return; // Dừng xử lý nếu không được phép
            }

            List<Category> cates = eventDAO.getAllCategory();
            List<Location> locations = eventDAO.getAllLocations();
            List<String> eventImageList = eventDAO.getEventImages(Integer.parseInt(eventId));

            request.setAttribute("categories", cates);
            request.setAttribute("locations", locations);
            request.setAttribute("event", event);
            request.setAttribute("eventImageList", eventImageList);
            request.getRequestDispatcher("edit-event.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Kiểm tra trạng thái của sự kiện
        String eventStatus = eventDAO.getEventStatus(eventId);
        if (!"pending".equalsIgnoreCase(eventStatus)) {
    request.setAttribute("error", "You can only edit events with 'pending' status.");
    request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    return; // Dừng xử lý nếu không được phép  
        }

        try {
            // Lấy danh sách hình ảnh hiện tại từ cơ sở dữ liệu
            List<String> eventImageList = eventDAO.getEventImages(eventId);

            // Khởi tạo đối tượng Event
            Event event = new Event();
            event.setId(eventId);

            // Lấy các thông tin khác từ request
            event.setFullname(request.getParameter("fullname"));
            event.setDescription(request.getParameter("description"));
            event.setCategory(new Category(Integer.parseInt(request.getParameter("categoryId"))));
            event.setLocation(new Location(Integer.parseInt(request.getParameter("locationId"))));
            event.setDateOfEvent(LocalDate.parse(request.getParameter("dateOfEvent")));
            event.setStartTime(LocalTime.parse(request.getParameter("startTime")));
            event.setEndTime(LocalTime.parse(request.getParameter("endTime")));
            event.setGuestRegisterLimit(Integer.parseInt(request.getParameter("guestRegisterLimit")));
            event.setGuestRegisterDeadline(LocalDate.parse(request.getParameter("guestRegisterDeadline")));
            event.setCollaboratorRegisterLimit(Integer.parseInt(request.getParameter("collaboratorRegisterLimit")));
            event.setCollaboratorRegisterDeadline(LocalDate.parse(request.getParameter("collaboratorRegisterDeadline")));

            // Xử lý ảnh đã tải lên
            List<String> newImagePaths = FileHandler.processUploadFile(request.getParts(), FileType.IMAGE);
            if (newImagePaths.isEmpty()) {
                event.setImages(eventImageList); // Giữ nguyên danh sách ảnh cũ
            } else {
                // Xóa ảnh cũ nếu có ảnh mới
                eventDAO.deleteEventImages(eventId);
                FileHandler.deleteFile(request.getServletContext(), eventImageList);
                event.setImages(newImagePaths); // Cập nhật danh sách hình ảnh mới
                FileHandler.save(newImagePaths, request.getParts(), request.getServletContext(), FileType.IMAGE);
            }

            // Gọi phương thức cập nhật sự kiện
            eventDAO.updateEventDetails(event);
            response.sendRedirect("event-details.jsp?eventId=" + eventId); // Chuyển đến trang chi tiết sự kiện sau khi cập nhật thành công
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("edit-event.jsp?eventId=" + eventId).forward(request, response);
        }
    }
}
