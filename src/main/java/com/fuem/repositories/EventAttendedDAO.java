/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
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
public class EventAttendedDAO extends SQLDatabase{
    private static final Logger logger = Logger.getLogger(EventAttendedDAO.class.getName());
    private static final String SELECT_ATTENDED_EVENTS =    "SELECT \n" +
                                                            "    E.fullname AS eventName,\n" +
                                                            "    O.acronym AS organizerName,\n" +
                                                            "	 O.avatarPath AS avatarPath,\n" +
                                                            "    E.dateOfEvent AS eventDate\n" +
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
                                                            "    E.dateOfEvent DESC;";
    
    public ArrayList<Event> getAttendedEventsList(int userId){
        ResultSet rs = executeQueryPreparedStatement(SELECT_ATTENDED_EVENTS, userId);
        ArrayList<Event> eventsAttendedList = new ArrayList<>();
        
        try{
            while(rs.next()){
                String eventName = rs.getString("eventName");
                String organizerAcronym = rs.getNString("organizerName");
                String avatarPath = rs.getNString("avatarPath");
                Date dateOfEvent  = rs.getDate("eventDate");
                System.out.println("date: "+dateOfEvent);
                
                Event event = new Event(eventName, organizerAcronym, avatarPath, dateOfEvent);
                event.print();
                eventsAttendedList.add(event);
            }
        }catch(SQLException e){
                logger.log(Level.SEVERE, null, e);
            }
        return eventsAttendedList;
    }
}

