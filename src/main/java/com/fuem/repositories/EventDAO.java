/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;


import com.fuem.models.Event;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventDAO extends SQLDatabase {

     public Event getEventDetails(int eventId) {
        Event event = null;
        String sql = "SELECT e.id, e.fullname AS hostClub, e.description, et.typeName, el.locationDescription, "
                   + "e.startDate, e.endDate, e.registerDeadline "
                   + "FROM Event e "
                   + "JOIN EventType et ON e.typeId = et.id "
                   + "JOIN EventLocation el ON e.locationId = el.id "
                   + "WHERE e.id = ?";

        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            System.out.println("Executing query for eventId: " + eventId);
            preparedStatement.setInt(1, eventId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                System.out.println("Record found for eventId: " + eventId);
                event = new Event();
                event.setId(rs.getInt("id"));
                event.setHostClub(rs.getString("hostClub"));
                event.setEventType(rs.getString("typeName"));
                event.setLocation(rs.getString("locationDescription"));
                event.setStartDate(rs.getTimestamp("startDate").toLocalDateTime()); 
                event.setEndDate(rs.getTimestamp("endDate").toLocalDateTime());
                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
                event.setDescription(rs.getString("description")); 
                event.setImages(getEventImages(eventId)); 
            } else {
                System.out.println("No record found for eventId: " + eventId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return event;
    }

    private List<String> getEventImages(int eventId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT path FROM EventImage WHERE eventId = ?";

        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setInt(1, eventId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String relativePath = rs.getString("path");
                String fullPath = "assets/img/" + relativePath; 
                images.add(fullPath); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return images;
    }
     
}












