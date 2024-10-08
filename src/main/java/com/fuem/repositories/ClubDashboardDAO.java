/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Event;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ThangNM
 */
public class ClubDashboardDAO extends SQLDatabase{
    private static final Logger logger = Logger.getLogger(ClubDashboardDAO.class.getName());
    private static String SELECT_ALL_EVENT_ORGANIZED =  "SELECT \n" +
                                                        "    o.fullname AS OrganizerName,\n" +
                                                        "    COUNT(e.id) AS TotalEvents\n" +
                                                        "FROM \n" +
                                                        "    Organizer o\n" +
                                                        "JOIN \n" +
                                                        "    Event e ON o.id = e.organizerId\n" +
                                                        "WHERE \n" +
                                                        "    o.isAdmin = 0 \n" +
                                                        "    AND o.id = ? \n" +
                                                        "GROUP BY \n" +
                                                        "    o.fullname;";
    
    private static String SELECT_ALL_UPCOMING_EVENTS =  "SELECT \n" +
                                                        "    COUNT(Event.id) AS UpcomingEvents\n" +
                                                        "FROM \n" +
                                                        "    Event\n" +
                                                        "JOIN \n" +
                                                        "	Organizer ON Organizer.id = Event.organizerId\n" +
                                                        "WHERE \n" +
                                                        "    dateOfEvent > GETDATE()\n" +
                                                        "	AND Organizer.id = ?";
    
    private static String SELECT_ALL_FOLLOWERS =    "SELECT \n" +
                                                        "    COUNT(studentId) AS FollowerCount\n" +
                                                        "FROM \n" +
                                                        "    Follow\n" +
                                                        "WHERE \n" +
                                                        "    organizerId = ?";
   
    private static String SELECT_ORGANIZED_EVENTS =      "SELECT \n" +
                                                        "    E.fullname as EventName,\n" +
                                                        "    E.dateOfEvent AS EventDate,\n" +
                                                        "    L.locationName AS LocationName,\n" +
                                                        "    C.categoryName AS CategoryName\n" +
                                                        "FROM \n" +
                                                        "    Event E\n" +
                                                        "JOIN \n" +
                                                        "    Location L ON E.locationId = L.id\n" +
                                                        "JOIN \n" +
                                                        "    Category C ON E.typeId = C.id\n" +
                                                        "WHERE \n" +
                                                        "    E.organizerId = ?  \n" +
                                                        "    AND E.dateOfEvent < GETDATE();";
   
   private static String SELECT_UPCOMING_EVENTS =       "SELECT \n" +
                                                        "       E.id AS EventId,\n" +
                                                        "       E.fullname as EventName,\n" +
                                                        "       E.dateOfEvent AS EventDate,\n" +
                                                        "       L.locationName AS LocationName,\n" +
                                                        "       C.categoryName AS CategoryName,\n" +
                                                        "	E.status AS Status,\n" +
                                                        "	E.guestRegisterLimit as RegisterLimit,\n" +
                                                        "	E.guestRegisterCount as RegisterCount\n" +
                                                        "FROM \n" +
                                                        "    Event E\n" +
                                                        "JOIN \n" +
                                                        "    Location L ON E.locationId = L.id\n" +
                                                        "JOIN \n" +
                                                        "    Category C ON E.typeId = C.id\n" +
                                                        "WHERE \n" +
                                                        "    E.organizerId = ?\n" +
                                                        "    AND E.dateOfEvent > GETDATE();";
    
    public int getTotalEventOrganized(int clubId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ALL_EVENT_ORGANIZED, clubId);
        int totalEvent = 0;
        
        try {
            while(rs.next()) {
               totalEvent = rs.getInt("TotalEvents");
            }
        } catch(SQLException e){
             logger.log(Level.SEVERE, null, e);
        }
        return totalEvent;
    }
    
    
    public int getTotalUpcomingEvents(int clubId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ALL_UPCOMING_EVENTS, clubId);
        int totalUpcomingEvents = 0;
        
        try {
            while(rs.next()) {
                totalUpcomingEvents = rs.getInt("UpcomingEvents");
            }
        } catch(SQLException e){
            logger.log(Level.SEVERE, null, e);
        }
        return totalUpcomingEvents;
    }
    
    public int getTotalFollowers(int clubId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ALL_FOLLOWERS, clubId);
        int totalFollowers = 0;
        
        try {
             while(rs.next()) {
                totalFollowers = rs.getInt("FollowerCount");
            }
        }catch (SQLException e){
            logger.log(Level.SEVERE, null, e);
        }
        return totalFollowers;
    }
    
    public ArrayList<Event> getOrganizedEvent(int clubId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ORGANIZED_EVENTS, clubId);
        ArrayList<Event> organizedEvent = new ArrayList<>();
        
        try {
            while(rs.next()){
                String eventName = rs.getString("EventName");
                LocalDate eventDate = rs.getDate("EventDate").toLocalDate();
                String locationName = rs.getString("LocationName");
                String category = rs.getString("CategoryName");
                
                organizedEvent.add(new Event(eventName, eventDate, locationName, category));
            }
        } catch (SQLException e){
            logger.log(Level.SEVERE, null, e);
        }
        return organizedEvent;
    }
    
    public ArrayList<Event> getUpcomingEvent(int clubId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_UPCOMING_EVENTS, clubId);
        ArrayList<Event> upcomingEvent = new ArrayList<>();
        
        try {
            while(rs.next()){
                int id = rs.getInt("EventId");
                String eventName = rs.getString("EventName");
                LocalDate eventDate = rs.getDate("EventDate").toLocalDate();
                String locationName = rs.getString("LocationName");
                String category = rs.getString("CategoryName");
                String status = rs.getString("Status");
                int registerLimit = rs.getInt("RegisterLimit");
                int registerCount = rs.getInt("RegisterCount");

                upcomingEvent.add(new Event(id, eventName, eventDate, locationName, category, status, registerLimit, registerCount));
            }
        } catch (SQLException e){
            logger.log(Level.SEVERE, null, e);
        }
        return upcomingEvent;
    }
}
