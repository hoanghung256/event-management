/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import com.fuem.enums.FileType;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author HungHV
 */
public class FileHandler {

    /**
     * Process Part objects
     * 
     * @return the path list for insert into database
     * @author HungHV
     */
    public static List<String> processUploadFile(Collection<Part> parts,  FileType fileType) throws IOException {
        List<String> pathList = new ArrayList<>();

        for (Part part : parts) {
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isBlank()) {
                continue;
            }
            String submittedFileName = part.getSubmittedFileName();
            String processedFileName = UUID.randomUUID().toString() + submittedFileName.substring(submittedFileName.lastIndexOf("."));
            pathList.add(fileType.getFileLocation() + "/" + processedFileName);
        }

        return pathList;
    }
    
    /**
     * Save file into project source
     * 
     * @author HungHV
     */
    public static void save(List<String> processedPathList, Collection<Part> parts, ServletContext context, FileType fileType) throws IOException {
        String fileFolderPath = context.getRealPath("");
        Files.createDirectories(Paths.get(fileFolderPath + fileType.getFileLocation()));
        
        int i = 0;
        
        for (Part part : parts) {
            if (part.getSubmittedFileName() == null) {
                continue;
            }
            part.write(fileFolderPath + processedPathList.get(i++));
        }
    }
    
    /**
     * 
     * @author HungHV
     */
    
    public static void deleteFile(ServletContext context, String filepath) {
        String realFilePath = context.getRealPath("") + filepath;
        File file = new File(realFilePath);

        if (file.exists()) {
            boolean isDeleted = file.delete();
        } 
    }

/**
     * Save file into project source
     *
     * @author HungHV
     */
    public static void save(String processedPath, Part part, ServletContext context, FileType fileType) throws IOException {
        String fileFolderPath = context.getRealPath("");
        Files.createDirectories(Paths.get(fileFolderPath + fileType.getFileLocation()));

        if (part.getSubmittedFileName() != null) {
            part.write(fileFolderPath + processedPath);
        }
    }
    
    /**
     * Process Part objects
     *
     * @return the path list for insert into database
     * @author HungHV
     */
    public static String processUploadFile(Part part, FileType fileType) throws IOException {
        String path = null;

        if (part.getSubmittedFileName() != null) {
            String submittedFileName = part.getSubmittedFileName();
            String processedFileName = UUID.randomUUID().toString() + submittedFileName.substring(submittedFileName.lastIndexOf("."));
            path = fileType.getFileLocation() + "/" + processedFileName;
        }

        return path;
    }
}