/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

/**
 *
 * @author hoang hung
 */
public class Validator {

    public static boolean isEmailBelongFPT(String email) {
        String[] emailSplits = email.split("@");

        return "fpt.edu.vn".equalsIgnoreCase(emailSplits[1]);
    }

    public static boolean isFullNameValid(String fullName) {

        return fullName.matches("[a-zA-Z\\p{L}\\s]+");
    }
    public static String extractStudentIdFromEmail(String email) {
        // Tách phần trước dấu @
        String[] emailSplits = email.split("@");

        if (!emailSplits[1].equalsIgnoreCase("fpt.edu.vn")) {
            return null; // Trả về null nếu không đúng định dạng email
        }

        String localPart = emailSplits[0]; // Phần trước dấu @

        // MSSV là 8 ký tự cuối của localPart
        if (localPart.length() >= 8) {
            return localPart.substring(localPart.length() - 8).toUpperCase(); // Trả về MSSV
        }

        return null; // Trả về null nếu không đủ độ dài
    }

    // Hàm để so sánh MSSV trong email với studentId người dùng nhập
    public static boolean isStudentIdMatch(String email, String studentIdInput) {
        String studentIdFromEmail = extractStudentIdFromEmail(email);

        if (studentIdFromEmail == null) {
            return false; // Nếu không lấy được MSSV từ email
        }

        // So sánh MSSV lấy được với studentId người dùng nhập
        return studentIdFromEmail.equals(studentIdInput);
    }

}
