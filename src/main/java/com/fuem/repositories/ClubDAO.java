/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.enums.Status;
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
public class ClubDAO extends SQLDatabase{
    private static final Logger logger = Logger.getLogger(ClubDAO.class.getName());
    private static String SELECT_ALL_EVENT_ORGANIZED =  "SELECT\n"
                                                        + "	Organizer.fullname AS OrganizerName,\n"
                                                        + "	COUNT(Event.id) AS TotalEvents\n"
                                                        + "FROM \n"
                                                        + "	Organizer\n"
                                                        + "JOIN \n"
                                                        + "	Event ON Organizer.id = Event.organizerId\n"
                                                        + "WHERE \n"
                                                        + "     Organizer.isAdmin = '0'\n"        
                                                        + "	AND Organizer.id = ?\n"
                                                        + "GROUP BY \n"
                                                        + "	Organizer.fullname";
    
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
   
    private static String SELECT_ORGANIZED_EVENTS =      "SELECT\n" 
                                                        + "    Event.fullname AS EventName,\n"
                                                        + "    Event.dateOfEvent AS EventDate,\n"
                                                        + "    Location.locationName AS LocationName,\n"
                                                        + "    Category.categoryName AS CategoryName\n"
                                                        + "FROM\n"
                                                        + "    Event\n"
                                                        + "JOIN\n"
                                                        + "    Location ON Event.locationId = Location.id\n"
                                                        + "JOIN\n"
                                                        + "    Category ON Event.categoryId = Category.id\n"
                                                        + "WHERE\n"
                                                        + "    Event.organizerId = ?\n"
                                                        + "    AND Event.dateOfEvent < GETDATE();";
   
   private static String SELECT_UPCOMING_EVENTS =       "SELECT \n" +
                                                        "    Event.id AS EventId,\n" +
                                                        "    Event.fullname AS EventName,\n" +
                                                        "    Event.dateOfEvent AS EventDate,\n" +
                                                        "    Location.locationName AS LocationName,\n" +
                                                        "    Category.categoryName AS CategoryName,\n" +
                                                        "    Event.status AS Status,\n" +
                                                        "    Event.guestRegisterLimit AS RegisterLimit,\n" +
                                                        "    Event.guestRegisterCount AS RegisterCount\n" +
                                                        "FROM \n" +
                                                        "    Event\n" +
                                                        "JOIN \n" +
                                                        "    Location ON Event.locationId = Location.id\n" +
                                                        "JOIN \n" +
                                                        "    Category ON Event.categoryId = Category.id\n" +
                                                        "WHERE \n" +
                                                        "    Event.organizerId = ?\n" +
                                                        "    AND Event.dateOfEvent > GETDATE();";
    
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
                Status status = Status.valueOf(rs.getString("Status"));
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
