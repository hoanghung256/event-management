/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(EventDAO.class.getName());
    private static final String SELECT_IMG_BY_ID = "SELECT path FROM EventImage WHERE eventId = ?";
    private static final String SELECT_EVENT_DETAILS_BY_ID = "SELECT e.id,"
            + "u.fullname AS hostClub, "
            + "e.fullname AS eventName, "
            + "e.description, "
            + "et.typeName, "
            + "el.locationDescription, "
            + "e.startDate, "
            + "e.endDate, "
            + "e.registerDeadline "
            + "FROM Event e "
            + "JOIN [User] u ON e.hostId = u.id "
            + "JOIN EventType et ON e.typeId = et.id "
            + "JOIN EventLocation el ON e.locationId = el.id "
            + "WHERE e.id = ?;";

    public Event getEventDetails(int eventId) {
        Event event = null;
        ResultSet rs = executeQueryPreparedStatement(SELECT_EVENT_DETAILS_BY_ID, eventId);
        try {
            if (rs != null && rs.next()) {
                event = new Event();
                event.setId(rs.getInt("id"));
                User hostClub = new User();
                hostClub.setFullName(rs.getString("hostClub"));
                event.setHostClub(hostClub); 
                event.setEventName(rs.getString("eventName"));
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

        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return event;
    }

    private List<String> getEventImages(int eventId) {
        List<String> images = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_IMG_BY_ID, eventId);
        try {
            while (rs.next()) {
                String relativePath = rs.getString("path");
                String fullPath = "assets/img/" + relativePath;
                images.add(fullPath);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return images;
    }

}
