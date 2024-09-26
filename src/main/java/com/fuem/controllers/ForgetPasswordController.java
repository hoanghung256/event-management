/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fuem.controllers;

import com.fuem.repositories.UserDAO;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MinhThang
 */
@WebServlet(name = "ForgetPasswordController", urlPatterns = {"/forget"})
public class ForgetPasswordController extends HttpServlet {
    private final UserDAO dao = new UserDAO();
    private static final Logger logger = Logger.getLogger(ResetPasswordController.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgetPasswordServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgetPasswordServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = generateOTP();
        
        
        //send OTP to email
        try {
            if (dao.isEmailInDatabase(email)) {
                sendEmail(email, otp);
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                request.getRequestDispatcher("authentication/reset-password.jsp").forward(request, response);
            }
            else {
                request.setAttribute("message", "Email does not exist");
                request.getRequestDispatcher("authentication/forget-password.jsp").forward(request, response);
            } 
        } catch (MessagingException e) {
           logger.log(Level.SEVERE, email, e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
    //generate OTP
    private String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000);
        return String.valueOf(otp);
    }
    
    //send Email
    private void sendEmail(String toEmail, String otp) throws MessagingException {
        //Get access from gmail (app password)
        String fromEmail = "minhthangqhqn@gmail.com";
        String password = "xgor cvso calo ctvk";
        
        //setting server SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP of Gmail
        props.put("mail.smtp.port", "587");            // Port TLS
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // Activate TLS
        
        //Create a session for sending emails with user authentication
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }   
        });
        try {
            // Create Description For Email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your OTP Code");
            message.setText("Your OTP code is: " + otp);

            // Send Email
            Transport.send(message);
        } catch (MessagingException e) {
            logger.log(Level.SEVERE, toEmail, e);
        }
    }
    
}

