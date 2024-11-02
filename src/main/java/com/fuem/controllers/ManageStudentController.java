package com.fuem.controllers;

import com.fuem.enums.Gender;
import com.fuem.models.Student;
import com.fuem.daos.StudentDAO;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.utils.Validator;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author TRINHHUY
 */
@WebServlet(name = "ManageStudentController", urlPatterns = {"/admin/manage-student"})
public class ManageStudentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StudentDAO dao = new StudentDAO();

        String searchValue = request.getParameter("searchValue");

        String pageNumberStr = request.getParameter("page");
        Integer pageNumber = (pageNumberStr == null) ? 0 : Integer.valueOf(pageNumberStr);
        PagingCriteria pagingCriteria = new PagingCriteria(pageNumber, 10);

        Page<Student> pageStudents = dao.getStudents(pagingCriteria, searchValue);

        request.setAttribute("previousSearchValue", searchValue);
        request.setAttribute("page", pageStudents);

        request.getRequestDispatcher("manage-student.jsp").forward(request, response); // Chuyển hướng đến trang JSP
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StudentDAO dao = new StudentDAO();
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            String studentId = request.getParameter("studentId");
            boolean isDeleted = dao.deleteStudentById(studentId);

            if (isDeleted) {
                request.setAttribute("deleteSuccess", "Student deleted successfully!"); // Thiết lập thông báo thành công
                doGet(request, response); // Chuyển tiếp lại để hiển thị thông báo
            } else {
                request.setAttribute("deleteError", "Unable to delete student with ID: " + studentId);
                doGet(request, response);
            }
        } else if ("add".equalsIgnoreCase(action)) {
            // Lấy dữ liệu từ form thêm sinh viên
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String studentId = request.getParameter("studentId");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");
            String genderStr = request.getParameter("gender");

            // Kiểm tra mật khẩu và xác nhận mật khẩu
            if (!password.equals(confirmPassword)) {
                request.setAttribute("addError", "Passwords do not match.");
                doGet(request, response);
                return; // Thoát khỏi phương thức nếu mật khẩu không khớp
            } else if (!Validator.isEmailBelongFPT(email)) {
                request.setAttribute("addError", "Email not allow, must be FPT Education email");
                doGet(request, response);
                return;
            }
            else if (!Validator.isFullNameValid(fullname)) {
                request.setAttribute("addError", "Special characters are not allowed ");
                doGet(request, response);
                return;
            } else if (!Validator.isStudentIdMatch(email, studentId)) {
                request.setAttribute("addError", "Email invalid with StudentID ");
                doGet(request, response);
                return;
            }

            Gender gender = Gender.valueOf(genderStr.toUpperCase());

            // Tạo đối tượng Student mới
            Student newStudent = new Student();
            newStudent.setFullname(fullname);
            newStudent.setEmail(email);
            newStudent.setStudentId(studentId);
            newStudent.setPassword(password); // Đặt mật khẩu
            newStudent.setGender(gender); // Đặt giới tính

            // Thêm sinh viên vào cơ sở dữ liệu
            boolean isAdded = dao.addStudent(newStudent);

            if (isAdded) {
                request.setAttribute("addSuccess", "Student added successfully!"); // Thiết lập thông báo thành công
                doGet(request, response); // Chuyển tiếp lại để hiển thị thông báo
            } else {
                request.setAttribute("addError", "Email or Student ID already exists.");
                doGet(request, response);
            }
        } else if ("edit".equalsIgnoreCase(action)) {
            // Lấy dữ liệu từ form chỉnh sửa sinh viên
            int id = Integer.parseInt(request.getParameter("id"));
            String studentId = request.getParameter("studentId");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String genderStr = request.getParameter("gender");
            
            
             if (!Validator.isEmailBelongFPT(email)) {
                request.setAttribute("editError", "Email not allow, must be FPT Education email");
                doGet(request, response);
                return;
            }
            else if (!Validator.isFullNameValid(fullname)) {
                request.setAttribute("editError", "Special characters are not allowed ");
                doGet(request, response);
                return;
            } else if (!Validator.isStudentIdMatch(email, studentId)) {
                request.setAttribute("editError", "Email invalid with StudentID.");
                doGet(request, response);
                return;
            }

            // Kiểm tra giới tính
            Gender gender;
            try {
                gender = Gender.valueOf(genderStr.toUpperCase());
            } catch (IllegalArgumentException e) {
                request.setAttribute("editError", "Invalid gender specified.");
                doGet(request, response);
                return;
            }

            // Tạo đối tượng Student với dữ liệu đã chỉnh sửa
            Student updatedStudent = new Student();
            updatedStudent.setId(id);
            updatedStudent.setStudentId(studentId);
            updatedStudent.setFullname(fullname);
            updatedStudent.setEmail(email);
            updatedStudent.setGender(gender);

            // Cập nhật sinh viên trong cơ sở dữ liệu
            boolean isUpdated = dao.updateStudent(updatedStudent);

            if (isUpdated) {
                request.setAttribute("editSuccess", "Student updated successfully!"); // Thiết lập thông báo thành công
                doGet(request, response); // Chuyển tiếp lại để hiển thị thông báo
            } else {
                request.setAttribute("editError", "Failed to update student information.");
                doGet(request, response);
            }
        } else {
            doGet(request, response);
        }
    }

}
