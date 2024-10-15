/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.builders.EventBuilder;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ThangNM
 */
public class EventAttendedDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(EventAttendedDAO.class.getName());
    private static final String SELECT_ATTENDED_EVENTS = "SELECT \n"
            + "    E.id, "
            + "    E.fullname AS eventName,\n"
            + "    O.acronym AS organizerName,\n"
            + "    O.avatarPath AS organizerAvatarPath,\n"
            + "    E.dateOfEvent AS eventDate,\n"
            + "    COUNT (*) OVER() AS 'TotalRow'\n"
            + "FROM \n"
            + "    [EventGuest] EG\n"
            + "JOIN \n"
            + "    [Event] E ON EG.eventId = E.id\n"
            + "JOIN \n"
            + "    [Organizer] O ON E.organizerId = O.id\n"
            + "JOIN \n"
            + "    [Student] S ON EG.guestId = S.id\n"
            + "WHERE \n"
            + "    EG.guestId = ? \n"
            + "AND E.dateOfEvent < '2025-10-31'\n"
            + "ORDER BY \n"
            + "    E.dateOfEvent DESC\n"
            + "OFFSET ? ROWS\n"
            + "FETCH NEXT ? ROWS ONLY";

    public EventAttendedDAO() {
        super();
    }

    /**
     * 
     * @author ThangNM 
     */
    public Page<Event> getAttendedEventsList(PagingCriteria pagingCriteria, int userId) {
        Page<Event> page = new Page<>();
        ArrayList<Event> eventsAttendedList = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); 
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ATTENDED_EVENTS, userId, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                
                Organizer organizer = new Organizer();
                organizer.setAcronym(rs.getNString("organizerName"));
                organizer.setAvatarPath(rs.getNString("organizerAvatarPath"));
                
                Event event = new EventBuilder()
                        .setId(rs.getInt("id"))
                        .setFullname(rs.getString("eventName"))
                        .setOrganizer(organizer)
                        .setDateOfEvent(rs.getDate("eventDate").toLocalDate())
                        .build();
                
                eventsAttendedList.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(eventsAttendedList);

        return page;
    }

    /**
     * 
     * @author ??? have no author, never used
     */
//    public List<EventGuest> getStudentAndEventIds() {
//        List<EventGuest> eventGuests = new ArrayList<>();
//
//        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); 
//                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STUDENT_AND_EVENT_ID)) {
//            while (rs.next()) {
//                int studentId = rs.getInt("studentId");
//                int eventId = rs.getInt("eventId");
//
//                EventGuest eventGuest = new EventGuest(studentId, eventId);
//                eventGuests.add(eventGuest);
//            }
//        } catch (SQLException e) {
//            logger.log(Level.SEVERE, null, e);
//        }
//
//        return eventGuests;
//    }
}
