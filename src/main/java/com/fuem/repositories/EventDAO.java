/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Category;
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
            + "c.id as categoryId, t.categoryName, "
            + "l.locationDescription, "
            + "o.fullname AS organizerName "
            + "FROM [Event] e "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "JOIN Organizer o ON e.organizerId = o.id ";
    private static final String SELECT_IMG_BY_ID = "SELECT path FROM EventImage WHERE eventId = ?";
    private static final String SELECT_EVENT_DETAILS_BY_ID = "SELECT e.id, "
            + "o.fullname AS organizerName, "
            + "o.id as orgId,"
            + "e.fullname AS eventName, "
            + "e.description, "
            + "c.categoryName, "
            + "l.locationName, "
            + "e.dateOfEvent, "
            + "e.startTime, "
            + "e.endTime, "
            + "e.guestRegisterLimit, "
            + "e.guestRegisterDeadline, "
            + "e.guestRegisterCount, "
            + "e.collaboratorRegisterLimit, "
            + "e.collaboratorRegisterDeadline, "
            + "e.collaboratorRegisterCount, "
            + "u.avatarPath AS organizerAvatarPath "
            + "FROM Event e "
            + "JOIN [Organizer] u ON e.organizerId = u.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "WHERE e.id = ?;";

    private static final String SELECT_ALL_EVENT = "SELECT e.*, o.fullname AS organizerName, o.id AS organizerId, "
            + "c.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "WHERE e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_FOLLOWED = "SELECT e.*, "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "c.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "JOIN Follow f ON e.organizerId = f.followedId "
            + "WHERE f.followerId = ? "
            + "AND e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_NOT_FOLLOWED = "SELECT e.*, "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "t.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "LEFT JOIN Follow f ON e.organizerId = f.followedId AND f.followerId = ? "
            + "WHERE f.followedId IS NULL "
            + "AND e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_FOLLOWED_AND_NOT_FOLLOWED = "SELECT e.*, "
            + "COUNT(*) OVER() AS 'TotalRow', "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "c.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationName, "
            + "CASE WHEN f.organizerId IS NOT NULL THEN 1 ELSE 0 END AS organizerId "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "LEFT JOIN Follow f ON e.organizerId = f.organizerId AND f.studentId = ? ";
    private static final String SELECT_ALL_CATEGORY = "SELECT * FROM [Category]";

    public EventDAO() {
        super();
    }

   
    
    private static final String SELECT_RECENTELY_EVENT_BY_ID ="SELECT TOP 10 e.id, "
            + "       e.fullname, "
            + "       e.description, "
            + "       e.dateOfEvent, "
            + "       e.startTime, "
            + "       e.endTime, "
            + "       e.guestRegisterLimit, "
            + "       e.registerDeadline, "
            + "       o.fullname AS organizerName, "
            + "       o.id AS organizerId, "
            + "       t.id AS typeId, "
            + "       t.typeName AS typeName, "
            + "       t.description AS typeDescription, "
            + "       l.id AS locationId, "
            + "       l.locationDescription AS locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN EventType t ON e.typeId = t.id "
            + "JOIN EventLocation l ON e.locationId = l.id "
            + "WHERE e.organizerId = ? "
            + "ORDER BY e.dateOfEvent DESC;"; 
    
    
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, o.fullname AS organizerName, o.id AS organizerId, "
                + "t.id AS typeId, t.typeName AS typeName, t.description AS typeDescription, "
                + "l.id AS locationId, l.locationDescription AS locationDescription "
                + "FROM Event e "
                + "JOIN Organizer o ON e.organizerId = o.id "
                + "JOIN EventType t ON e.typeId = t.id "
                + "JOIN EventLocation l ON e.locationId = l.id "
                + "ORDER BY e.dateOfEvent DESC";
        ResultSet rs = executeQueryPreparedStatement(sql);

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
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                // event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime());
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);
                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);
                Location eventLocation = new Location();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
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
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                // event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);
                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);

                Location eventLocation = new Location();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
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
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                // event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);
                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);

                Location eventLocation = new Location();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return events;
    }

    public List<Category> getAllCategory() {
        List<Category> categories = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_ALL_CATEGORY);
        try {
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                categories.add(category);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return categories;

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
            logger.log(Level.SEVERE, null, e);
        }

        return organizers;
    }

    public Page<Event> get(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria, int id) {
        Page<Event> page = new Page<>();
        ArrayList<Event> events = new ArrayList<>();

        try {
            String query = buildSelectQuery(pagingCriteria, searchEventCriteria);
            ResultSet rs = executeQueryPreparedStatement(query, id);

            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                events.add(new Event(
                        rs.getInt("id"),
                        organizer,
                        rs.getNString("fullname"),
                        rs.getNString("description"),
                        new Category(
                                rs.getInt("id"),
                                rs.getNString("categoryName")
                        // rs.getNString("description")
                        ),
                        new Location(
                                rs.getInt("id"),
                                rs.getNString("locationName")),
                        rs.getDate("dateOfEvent").toLocalDate(),
                        rs.getTimestamp("startTime").toLocalDateTime().toLocalTime(),
                        rs.getTimestamp("endTime").toLocalDateTime().toLocalTime(),
                        rs.getInt("guestRegisterLimit"),
                        rs.getDate("guestRegisterDeadline").toLocalDate()
                // rs.getInt("guestAttendedCount")
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
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
            if (searchEventCriteria.getCategoryId() != null) {
                query.append(" e.categoryId=");
                query.append(searchEventCriteria.getCategoryId());
            }
            if (searchEventCriteria.getOrganizerId() != null) {
                query.append("\n AND e.organizerId=");
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

        query.append("\n ORDER BY f.organizerId DESC, ");

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
                Organizer organizer = new Organizer(
                        rs.getInt("organizerId"),
                        rs.getString("organizerName"),
                        rs.getString("organizerAvatarPath"));
                event.setOrganizer(organizer);
                event.setFullname(rs.getString("eventName"));
                event.setDescription(rs.getString("description"));
                Category category = new Category(
                        rs.getString("categoryName"));
                event.setCategory(category);
                Location location = new Location(
                        rs.getString("locationName"));
                event.setLocation(location);
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                event.setGuestRegisterCount(rs.getInt("guestRegisterCount"));
                event.setCollaboratorRegisterLimit(rs.getInt("collaboratorRegisterLimit"));
                event.setCollaboratorRegisterDeadline(rs.getDate("collaboratorRegisterDeadline").toLocalDate());
                event.setCollaboratorRegisterCount(rs.getInt("collaboratorRegisterCount"));
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

    public List<Event> getRecentEvents(int organizerId) {
        List<Event> events = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_RECENTELY_EVENT_BY_ID, organizerId);
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
            event.setRegisterDeadline(rs.getTimestamp("registerDeadline").toLocalDateTime().toLocalTime());
            Organizer organizer = new Organizer();
            organizer.setId(rs.getInt("organizerId"));
            organizer.setFullname(rs.getString("organizerName"));
            event.setOrganizer(organizer);

            Category category = new Category();
            category.setId(rs.getInt("typeId"));
            category.setName(rs.getString("typeName"));
            category.setDescription(rs.getString("typeDescription"));
            event.setCategory(category);

            Location location = new Location();
            location.setId(rs.getInt("locationId"));
            location.setDescription(rs.getString("locationDescription"));
            event.setLocation(location);

            events.add(event);
        }
    } catch (SQLException e) {
        logger.log(Level.SEVERE, null, e);
    }

    return events;
    }

}
