/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import com.fuem.models.EventGuest;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ThangNM
 */
public class EventAttendedDAO extends SQLDatabase{
    private static final Logger logger = Logger.getLogger(EventAttendedDAO.class.getName());
    private static final String SELECT_ATTENDED_EVENTS =    "SELECT \n" +
                                                            "    E.fullname AS eventName,\n" +
                                                            "    O.acronym AS organizerName,\n" +
                                                            "	 O.avatarPath AS avatarPath,\n" +
                                                            "    E.dateOfEvent AS eventDate,\n" +
                                                            "    COUNT (*) OVER() AS 'TotalRow'\n" +
                                                            "FROM \n" +
                                                            "    [EventGuest] EG\n" +
                                                            "JOIN \n" +
                                                            "    [Event] E ON EG.eventId = E.id\n" +
                                                            "JOIN \n" +
                                                            "    [Organizer] O ON E.organizerId = O.id\n" +
                                                            "JOIN \n" +
                                                            "    [User] U ON EG.studentId = U.id\n" +
                                                            "WHERE \n" +
                                                            "    EG.studentId = ? \n" +
                                                            "    AND E.dateOfEvent < '2025-10-31'\n" +
                                                            "ORDER BY \n" +
                                                            "    E.dateOfEvent DESC\n"+ 
                                                            "OFFSET ? ROWS\n" +
                                                            "FETCH NEXT ? ROWS ONLY";
     private static final String SELECT_STUDENT_AND_EVENT_ID = 
            "SELECT U.studentId, E.id AS eventId " +
            "FROM [User] U " +
            "JOIN [Event] E ON U.studentId = E.studentId";
    public Page<Event> getAttendedEventsList(PagingCriteria pagingCriteria, int userId){
        ResultSet rs = executeQueryPreparedStatement(SELECT_ATTENDED_EVENTS, userId, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());
        Page<Event> page = new Page<>();
        ArrayList<Event> eventsAttendedList = new ArrayList<>();
        
        try{
            while(rs.next()){
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                
                String eventName = rs.getString("eventName");
                String organizerAcronym = rs.getNString("organizerName");
                String avatarPath = rs.getNString("avatarPath");
                Date dateOfEvent  = rs.getDate("eventDate");
                
                Event event = new Event(eventName, organizerAcronym, avatarPath, dateOfEvent.toLocalDate());
                eventsAttendedList.add(event);
            }
        }catch(SQLException e){
                logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(eventsAttendedList);
        
        return page;
    }
      public List<EventGuest> getStudentAndEventIds() {
        List<EventGuest> eventGuests = new ArrayList<>();
        ResultSet rs = executeQueryPreparedStatement(SELECT_STUDENT_AND_EVENT_ID);

        try {
            while (rs.next()) {
                int studentId = rs.getInt("studentId");
                int eventId = rs.getInt("eventId");

                EventGuest eventGuest = new EventGuest(studentId, eventId);
                eventGuests.add(eventGuest);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return eventGuests;
    }
}

