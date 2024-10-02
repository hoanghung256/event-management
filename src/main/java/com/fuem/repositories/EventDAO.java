/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.EventLocation;
import com.fuem.models.EventType;
import com.fuem.models.Organizer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO extends SQLDatabase {

     private static final Logger logger = Logger.getLogger(EventDAO.class.getName());
    private static final String SELECT_IMG_BY_ID = "SELECT path FROM EventImage WHERE eventId = ?";
    private static final String SELECT_EVENT_DETAILS_BY_ID = "SELECT e.id, "
            + "u.fullname AS organizerName, "
            + "e.fullname AS eventName, "
            + "e.description, "
            + "et.typeName AS eventTypeName, "
            + "el.locationDescription AS locationDescription, "
            + "e.dateOfEvent, "
            + "e.startTime, "
            + "e.endTime, "
            + "e.guestRegisterLimit, "
            + "e.registerDeadline, "
            + "e.guestAttendedCount, "
            + "u.avatarPath AS organizerAvatarPath "
            + "FROM Event e "
            + "JOIN [Organizer] u ON e.organizerId = u.id "
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
                Organizer organizer = new Organizer();
                organizer.setFullname(rs.getString("organizerName"));
                organizer.setAvatarPath(rs.getString("organizerAvatarPath"));
                event.setOrganizer(organizer); 
                event.setFullname(rs.getString("eventName"));
                event.setDescription(rs.getString("description"));
                EventType eventType = new EventType();
                eventType.setName(rs.getString("eventTypeName"));
                event.setType(eventType);
                EventLocation location = new EventLocation();
                location.setDescription(rs.getString("locationDescription"));
                event.setLocation(location);
                event.setDateOfEvent(rs.getDate("dateOfEvent"));
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));
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
