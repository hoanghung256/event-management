/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.enums.FileStatus;
import com.fuem.enums.FileType;
import com.fuem.enums.Role;
import com.fuem.models.Document;
import com.fuem.models.Organizer;
import com.fuem.daos.FileDAO;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.utils.FileHandler;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author HungHV
 */
@WebServlet(name = "FileController", urlPatterns = {"/admin/file", "/club/file"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 5,
        maxFileSize = 1024 * 1024 * 2,
        maxRequestSize = 1024 * 1024 * 3
)
public class FileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Organizer organizer = (Organizer) request.getSession().getAttribute("userInfor");
        FileDAO dao = new FileDAO();
        String pageNumStr = request.getParameter("page");
        int pageNum = 0;

        if (pageNumStr != null) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        PagingCriteria pagingCriteria = new PagingCriteria(pageNum, 10);
        Page<Document> docsPage;

        if (organizer.getRole().equals(Role.ADMIN)) {
            docsPage = dao.getFiles(pagingCriteria);
        } else {
            docsPage = dao.getFilesBySubmitterId(pagingCriteria, organizer.getId());
        }

        request.setAttribute("page", docsPage);
        request.getRequestDispatcher("manage-files.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Organizer organizer = (Organizer) request.getSession().getAttribute("userInfor");
            FileDAO dao = new FileDAO();

            if (organizer.getRole().equals(Role.CLUB)) {    // Club send application
                String type = request.getParameter("type");
                Part filePart = request.getPart("file");

                String processedPath = FileHandler.processUploadFile(filePart, FileType.DOCUMENT);

                Document doc = new Document(
                        organizer,
                        filePart.getSubmittedFileName(),
                        type,
                        processedPath,
                        FileStatus.PENDING
                );

                if (!dao.insertFile(doc)) {
                    request.setAttribute("error", "Submit failed!");
                } else {
                    try {
                        FileHandler.save(processedPath, filePart, request.getServletContext(), FileType.DOCUMENT);
                        request.setAttribute("message", "Submit successfully!");
                    } catch (IOException e) {
                        request.setAttribute("error", "Submit failed!");
                    }
                }
            } else if (organizer.getRole().equals(Role.ADMIN)) {    // Admin perform review application
                String reviewAction = request.getParameter("action");
                int fileId = Integer.parseInt(request.getParameter("id"));
                String processNote = request.getParameter("processNote");
                boolean isReviewSuccess = false;

                switch (reviewAction) {
                    case "Request change":
                        isReviewSuccess = dao.updateFileStatus(fileId, "REQUEST_CHANGE", processNote);
                        break;
                    default:
                        isReviewSuccess = dao.updateFileStatus(fileId, reviewAction.toUpperCase(), processNote);
                }

                if (isReviewSuccess) {
                    request.setAttribute("message", "Review successfully!");
                } else {
                    request.setAttribute("error", "Review failed!");
                }
            }
        } catch (IllegalStateException e) {
            request.setAttribute("error", "File exceeds the maximum allowed size (2MB).");
        }

        request.getRequestDispatcher("file").forward(request, response);
    }
}
