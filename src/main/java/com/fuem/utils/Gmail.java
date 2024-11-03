/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import com.fuem.models.Event;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang hung
 */
public class Gmail {

    private final String smtpHost = "smtp.gmail.com";
    private final String smtpPort = "587";
    private final String password = "cwca unvn nsub lujp";

    private final String fromEmail = "fpteventmanagementsystem@gmail.com";
    private String toEmail;
    private String contentType;
    private String subject;
    private String content;

    private Map<String, String> macrosMap;

    public Gmail(String... toEmail) {
        this.toEmail = "";
        for (int i = toEmail.length - 1; i >= 0; i--) {
            this.toEmail += toEmail[i];
            if (i != 0) {
                this.toEmail += ", ";
            }
        }
    }

    public Gmail setContentType(String contentType) {
        this.contentType = contentType;
        return this;
    }

    public Gmail setSubject(String subject) {
        this.subject = subject;
        return this;
    }

    public Gmail initContent(String content) {
        this.content = content;
        return this;
    }

    public Gmail appendContent(String content) {
        this.content += content;
        return this;
    }

    public Gmail initMacro() {
        macrosMap = new HashMap<>();
        return this;
    }

    public Gmail appendMacro(String macro, String value) {
        macrosMap.put(macro, value);
        return this;
    }

    public void send() {
        if (contentType == null) {
            contentType = "text/plain";
        }
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            message.setSubject(subject);
            message.setContent(content, contentType);

            Transport.send(message);
        } catch (MessagingException ex) {
            Logger.getLogger(Gmail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String insertMarco(String str) {
        for (String macro : macrosMap.keySet()) {
            str = str.replaceAll("\\[" + macro + "\\]", macrosMap.get(macro));
        }
        return str;
    }

    public void sendTemplate(String filePath) {
        if (content != null || macrosMap == null) {
            return;
        }
        // filePath = Configuration.templatePath.concat(filePath);
        filePath = "";

        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath)));
            String line;
            Gmail g = this.initContent("");

            while ((line = br.readLine()) != null) {
                g = g.appendContent(insertMarco(line)).appendContent("\n");
            }
            br.close();
            g.send();
        } catch (IOException e) {
            Logger.getLogger(Gmail.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void sendTemplate(URL filePath) {
        if (content != null || macrosMap == null) {
            return;
        }

        try {
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(filePath.openStream(), StandardCharsets.UTF_8));
            String line;
            Gmail g = this.initContent("");

            while ((line = br.readLine()) != null) {
                g = g.appendContent(insertMarco(line)).appendContent("\n");
            }
            g.send();
        } catch (IOException e) {
            Logger.getLogger(Gmail.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public static void sendWithOTP(String email, String otp) throws MalformedURLException {
        Gmail g = new Gmail(email)
                .setContentType("text/html; charset=UTF-8")
                .setSubject("Verify account")
                .initMacro()
                .appendMacro("OTP", otp);

        g.sendTemplate(new URL("http://localhost:8080/event-management/gmail-template/send-otp.jsp"));
    }
    
    public static void registerEventSuccess(String email, String guestName, Event e) throws MalformedURLException {
        Gmail g = new Gmail(email)
                .setContentType("text/html; charset=UTF-8")
                .setSubject("Guest Register Successfully!")
                .initMacro()
                .appendMacro("GuestName", guestName)
                .appendMacro("EventName", e.getFullname())
                .appendMacro("Date", DateTimeConvertter.dateToString(e.getDateOfEvent()))
                .appendMacro("StartTime", DateTimeConvertter.timeToString(e.getStartTime()))
                .appendMacro("EndTime", DateTimeConvertter.timeToString(e.getEndTime()))
                .appendMacro("Location", e.getLocation().getName());

        g.sendTemplate(new URL("http://localhost:8080/event-management/gmail-template/guest-register-success.jsp"));
    }
    
    public static void newPendingEvent(String email, String adminName, String clubName, Event e) throws MalformedURLException {
        Gmail g = new Gmail(email)
                .setContentType("text/html; charset=UTF-8")
                .setSubject("New Event Registration!")
                .initMacro()
                .appendMacro("AdminName", adminName)
                .appendMacro("ClubName", clubName)
                .appendMacro("EventName", e.getFullname())
                .appendMacro("Date", DateTimeConvertter.dateToString(e.getDateOfEvent()))
                .appendMacro("StartTime", DateTimeConvertter.timeToString(e.getStartTime()))
                .appendMacro("EndTime", DateTimeConvertter.timeToString(e.getEndTime()))
                .appendMacro("Location", e.getLocation().getName());

        g.sendTemplate(new URL("http://localhost:8080/event-management/gmail-template/new-pending-event.jsp"));
    }
    
    public static void eventRegistrationSuccess(String email, String clubName, Event e) throws MalformedURLException {
        Gmail g = new Gmail(email)
                .setContentType("text/html; charset=UTF-8")
                .setSubject("New Event Registration!")
                .initMacro()
                .appendMacro("ClubName", clubName)
                .appendMacro("EventName", e.getFullname())
                .appendMacro("Date", DateTimeConvertter.dateToString(e.getDateOfEvent()))
                .appendMacro("StartTime", DateTimeConvertter.timeToString(e.getStartTime()))
                .appendMacro("EndTime", DateTimeConvertter.timeToString(e.getEndTime()))
                .appendMacro("Location", e.getLocation().getName());

        g.sendTemplate(new URL("http://localhost:8080/event-management/gmail-template/new-pending-event.jsp"));
    }
}
