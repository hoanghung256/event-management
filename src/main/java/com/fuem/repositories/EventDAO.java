/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.EventLocation;
import com.fuem.models.EventType;
import com.fuem.models.Organizer;
import com.fuem.repositories.helper.EventOrderBy;
import com.fuem.repositories.helper.Page;
import com.fuem.repositories.helper.PagingCriteria;
import com.fuem.repositories.helper.SearchEventCriteria;
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
    private static final String SELECT = "SELECT *, COUNT(*) OVER() AS 'TotalRow' FROM [Event]";
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT TOP 10 e.*, o.fullname AS organizerName, o.id AS organizerId, " +
                     "t.id AS typeId, t.typeName AS typeName, t.description AS typeDescription, " +
                     "l.id AS locationId, l.locationDescription AS locationDescription " +
                     "FROM Event e " +
                     "JOIN Organizer o ON e.organizerId = o.id " +
                     "JOIN EventType t ON e.typeId = t.id " +
                     "JOIN EventLocation l ON e.locationId = l.id " +
                     "ORDER BY e.dateOfEvent DESC";
        ResultSet rs = executeQueryPreparedStatement(sql);
        
        try {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent"));
                event.setStartTime(rs.getTimestamp("startTime"));
                event.setEndTime(rs.getTimestamp("endTime"));
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("registerDeadline"));
                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));
                
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizerId(organizer);  

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
    
    public Page<Event> get(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria) {
        Page<Event> page = new Page<>();
        ArrayList<Event> events = new ArrayList<>();
        
        try {
            String query = buildSelectQuery(pagingCriteria, searchEventCriteria);
            
            System.out.println(query + "\n");
            ResultSet rs = executeQueryPreparedStatement(query);
            
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                
                events.add(
                        new Event(
                                rs.getInt("id"),
                                organizer,
                                rs.getNString("fullname"),
                                rs.getNString("description"),
                                new EventType(
                                        rs.getInt("typeId")
//                                        rs.getNString("typeName"),
//                                        rs.getNString("description")
                                ),
                                new EventLocation(
                                        rs.getInt("typeId")
//                                        rs.getNString("description")
                                ),
                                rs.getDate("dateOfEvent"),
                                rs.getTimestamp("startTime"),
                                rs.getTimestamp("endTime"),
                                rs.getInt("guestRegisterLimit"),
                                rs.getTimestamp("registerDeadline"),
                                rs.getInt("guestAttendedCount")
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
        StringBuilder query = new StringBuilder(SELECT);
        
        if (!searchEventCriteria.isEmpty()) {
            query.append("\n WHERE");
            
            if (searchEventCriteria.getName() != null && !searchEventCriteria.getName().isBlank()) {
                query.append(" LOWER(fullname) LIKE LOWER('");
                query.append(searchEventCriteria.getName());
                query.append("%')\n AND");
            }
            if (searchEventCriteria.getTypeId() != null) {
                query.append(" typeId=");
                query.append(searchEventCriteria.getTypeId());
            }
            if (searchEventCriteria.getOrganizerId()!= null) {
                query.append("\n AND organizerId=");
                query.append(searchEventCriteria.getOrganizerId());
            }
            if (searchEventCriteria.getFrom() != null && searchEventCriteria.getTo() != null) {
                query.append("\n AND dateOfEvent BETWEEN '");
                query.append(searchEventCriteria.getFrom());
                query.append("' AND '");
                query.append(searchEventCriteria.getTo());
                query.append("'");
            }
        }
        
        query.append("\n ORDER BY");

        if (EventOrderBy.DATE_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" dateOfEvent ASC");
        } else if (EventOrderBy.FULLNAME_DESC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" fullname DESC");
        } else if (EventOrderBy.FULLNAME_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" fullname ASC");
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
}
