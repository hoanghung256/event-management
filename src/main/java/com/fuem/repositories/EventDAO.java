/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.EventLocation;
import com.fuem.models.EventType;
import com.fuem.models.Organizer;
import com.fuem.repositories.helpers.EventOrderBy;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.repositories.helpers.SearchEventCriteria;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AnhNQ
 */
public class EventDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(EventDAO.class.getName());
    private static final String SELECT_FOR_FILTER = "SELECT e.*, COUNT(*) OVER() AS 'TotalRow', "
            + "t.id as typeId, t.typeName as typeName, "
            + "l.locationDescription AS locationDescription, "
            + "o.fullname AS organizerName "
            + "FROM [Event] e "
            + "JOIN EventType t ON e.typeId = t.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "JOIN Organizer o ON e.organizerId = o.id ";
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
            //            + "e.guestAttendedCount, "
            + "u.avatarPath AS organizerAvatarPath "
            + "FROM Event e "
            + "JOIN [Organizer] u ON e.organizerId = u.id "
            + "JOIN EventType et ON e.typeId = et.id "
            + "JOIN EventLocation el ON e.locationId = el.id "
            + "WHERE e.id = ?;";
    
    public EventDAO() {
        super();
    }

    private static final String SELECT_ALL_EVENT = "SELECT e.*, o.fullname AS organizerName, o.id AS organizerId, "
            + "t.id AS typeId, t.typeName AS typeName, t.description AS typeDescription, "
            + "l.id AS locationId, l.locationDescription AS locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN EventType t ON e.typeId = t.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "WHERE e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_FOLLOWED
            = "SELECT e.*, "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "t.id AS typeId, t.typeName AS typeName, t.description AS typeDescription, "
            + "l.id AS locationId, l.locationDescription AS locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN EventType t ON e.typeId = t.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "JOIN Follow f ON e.organizerId = f.followedId "
            + "WHERE f.followerId = ? "
            + "AND e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_NOT_FOLLOWED
            = "SELECT e.*, "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "t.id AS typeId, t.typeName AS typeName, t.description AS typeDescription, "
            + "l.id AS locationId, l.locationDescription AS locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN EventType t ON e.typeId = t.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "LEFT JOIN Follow f ON e.organizerId = f.followedId AND f.followerId = ? "
            + "WHERE f.followedId IS NULL "
            + "AND e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_FOLLOWED_AND_NOT_FOLLOWED
            = "SELECT e.*, "
            + "COUNT(*) OVER() AS 'TotalRow', "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "t.id AS typeId, t.typeName AS typeName, t.description AS typeDescription, "
            + "l.id AS locationId, l.locationDescription AS locationDescription, "
            + "CASE WHEN f.followedId IS NOT NULL THEN 1 ELSE 0 END AS isFollowed "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN EventType t ON e.typeId = t.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "LEFT JOIN Follow f ON e.organizerId = f.followedId AND f.followerId = ? ";

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_ALL_EVENT);

        try {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
//                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);
                EventType eventType = new EventType();
                eventType.setId(rs.getInt("typeId"));
                eventType.setName(rs.getString("typeName"));
                eventType.setDescription(rs.getString("typeDescription"));
                event.setType(eventType);

                EventLocation eventLocation = new EventLocation();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return events;
    }

    public List<Event> getEventsByFollowingOrganizers(int userId) {
        List<Event> events = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_EVENTS_FOLLOWED, userId);
        try {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
//                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);
                EventType eventType = new EventType();
                eventType.setId(rs.getInt("typeId"));
                eventType.setName(rs.getString("typeName"));
                eventType.setDescription(rs.getString("typeDescription"));
                event.setType(eventType);

                EventLocation eventLocation = new EventLocation();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> getEventsNotFollowing(int userId) {
        List<Event> events = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_EVENTS_NOT_FOLLOWED, userId);
        try {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
//                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);
                EventType eventType = new EventType();
                eventType.setId(rs.getInt("typeId"));
                eventType.setName(rs.getString("typeName"));
                eventType.setDescription(rs.getString("typeDescription"));
                event.setType(eventType);

                EventLocation eventLocation = new EventLocation();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<EventType> getAllEventType() {
        List<EventType> eventTypes = new ArrayList<>();
        String sql = "SELECT * FROM [EventType]";
        ResultSet rs = executeQueryPreparedStatement(sql);

        try {
            while (rs.next()) {

                EventType eventType = new EventType();
                eventType.setId(rs.getInt("id"));
                eventType.setName(rs.getString("typeName"));
                eventType.setDescription(rs.getString("description"));

                eventTypes.add(eventType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return eventTypes;
    }

    public List<Organizer> getAllOrganizer() {
        List<Organizer> organizers = new ArrayList<>();
        String sql = "SELECT * FROM [Organizer]";
        ResultSet rs = executeQueryPreparedStatement(sql);

        try {
            while (rs.next()) {

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("id"));
                organizer.setFullname(rs.getString("fullname"));

                organizers.add(organizer);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return organizers;
    }

    public Page<Event> get(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria, int id) {
        Page<Event> page = new Page<>();
        ArrayList<Event> events = new ArrayList<>();

        try {
            String query = buildSelectQuery(pagingCriteria, searchEventCriteria);

            System.out.println(query + "\n");
            ResultSet rs = executeQueryPreparedStatement(query, id);

            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                events.add(
                        new Event(
                                rs.getInt("id"),
                                organizer,
                                rs.getNString("fullname"),
                                rs.getNString("description"),
                                new EventType(
                                        rs.getInt("typeId"),
                                        rs.getNString("typeName")
                                //                                        rs.getNString("description")
                                ),
                                new EventLocation(
                                        rs.getInt("typeId"),
                                        rs.getNString("locationDescription")
                                ),
                                rs.getDate("dateOfEvent").toLocalDate(),
                                rs.getTimestamp("startTime").toLocalDateTime().toLocalTime(),
                                rs.getTimestamp("endTime").toLocalDateTime().toLocalTime(),
                                rs.getInt("guestRegisterLimit"),
                                rs.getTimestamp("registerDeadline").toLocalDateTime()
                        //                                rs.getInt("guestAttendedCount")
                        )
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        page.setDatas(events);

        return page;
    }

    private String buildSelectQuery(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria) {
        StringBuilder query = new StringBuilder(SELECT_EVENTS_FOLLOWED_AND_NOT_FOLLOWED);

        if (!searchEventCriteria.isEmpty()) {
            query.append("\n WHERE");

            if (searchEventCriteria.getName() != null && !searchEventCriteria.getName().isBlank()) {
                query.append(" LOWER(e.fullname) LIKE LOWER('");
                query.append(searchEventCriteria.getName());
                query.append("%')\n AND");
            }
            if (searchEventCriteria.getTypeId() != null) {
                query.append(" typeId=");
                query.append(searchEventCriteria.getTypeId());
            }
            if (searchEventCriteria.getOrganizerId() != null) {
                query.append("\n AND organizerId=");
                query.append(searchEventCriteria.getOrganizerId());
            }
            if (searchEventCriteria.getFrom() != null && searchEventCriteria.getTo() != null) {
                query.append("\n AND e.dateOfEvent BETWEEN '");
                query.append(searchEventCriteria.getFrom());
                query.append("' AND '");
                query.append(searchEventCriteria.getTo());
                query.append("'");
            }
        }
        query.append("\n AND e.dateOfEvent > GETDATE()");

        query.append("\n ORDER BY isFollowed DESC, ");

        if (EventOrderBy.DATE_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" dateOfEvent ASC");
        } else if (EventOrderBy.FULLNAME_DESC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" e.fullname DESC");
        } else if (EventOrderBy.FULLNAME_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" e.fullname ASC");
        } else {
            query.append(" dateOfEvent DESC");
        }

        if (!pagingCriteria.isEmpty()) {
            query.append(" OFFSET ");
            query.append(pagingCriteria.getOffset());
            query.append(" ROWS\n FETCH NEXT ");
            query.append(pagingCriteria.getFetchNext());
            query.append(" ROWS ONLY");
        }

        return query.toString();
    }

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
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
//                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));
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
