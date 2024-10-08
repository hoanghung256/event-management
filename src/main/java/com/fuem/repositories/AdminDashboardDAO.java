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
public class AdminDashboardDAO extends SQLDatabase {
    private static final Logger logger = Logger.getLogger(ClubDashboardDAO.class.getName());
    private static String SELECT_TOTAL_ORGANIZED_EVENT = "SELECT \n"
                                                        + "    Organizer.fullname AS OrganizerName,\n"
                                                        + "    COUNT(Event.id) AS TotalEvents\n"
                                                        + "FROM \n"
                                                        + "    Organizer \n"
                                                        + "JOIN \n"
                                                        + "    Event ON Organizer.id = Event.organizerId\n"
                                                        + "WHERE \n"
                                                        + "    Organizer.id = ?\n"
                                                        + "GROUP BY \n"
                                                        + "    Organizer.fullname;";

    private static String SELECT_TOTAL_CLUBS = "SELECT \n"
                                                        + "    COUNT(Organizer.id) AS TotalClubs\n"
                                                        + "FROM \n"
                                                        + "    Organizer \n"
                                                        + "WHERE \n"
                                                        + "    Organizer.isAdmin = '0'";

    private static String SELECT_TOTAL_UPCOMING_EVENT = "SELECT \n"
                                                        + "   COUNT(Event.id) AS UpcomingEvents\n"
                                                        + "FROM \n"
                                                        + "   Event\n"
                                                        + "JOIN \n"
                                                        + "   Organizer ON Organizer.id = Event.organizerId\n"
                                                        + "WHERE \n"
                                                        + "    dateOfEvent > GETDATE()\n"
                                                        + "	AND Organizer.id = ?";

    private static String SELECT_REGISTRATION_EVENTS = "SELECT\n"
                                                        + "   Event.id AS EventId,\n"
                                                        + "   Organizer.acronym AS ClubName,\n"
                                                        + "   Organizer.avatarPath AS AvatarPath,\n"
                                                        + "   Event.fullname AS EventName,\n"
                                                        + "   Event.dateOfEvent AS EventDate,\n"
                                                        + "   Category.categoryName AS CategoryName,\n"
                                                        + "   Location.locationName AS LocationName,\n"
                                                        + "   Event.status AS Status\n"
                                                        + "\n"
                                                        + "FROM \n"
                                                        + "   EVENT\n"
                                                        + "JOIN\n"
                                                        + "   Organizer ON Organizer.id = Event.organizerId\n"
                                                        + "JOIN \n"
                                                        + "   Category ON Category.id = Event.typeId\n"
                                                        + "JOIN \n"
                                                        + "   Location ON Location.id = Event.locationId\n"
                                                        + "WHERE \n"
                                                        + "   Organizer.isAdmin = '0'\n"
                                                        + "   AND Event.status = 'PENDING'";

    private static String SELECT_ORGANIZED_EVENTS =     "SELECT \n"
                                                        + "    E.fullname as EventName,\n"
                                                        + "    E.dateOfEvent AS EventDate,\n"
                                                        + "    L.locationName AS LocationName,\n"
                                                        + "    C.categoryName AS CategoryName\n"
                                                        + "FROM \n"
                                                        + "    Event E\n"
                                                        + "JOIN \n"
                                                        + "    Location L ON E.locationId = L.id\n"
                                                        + "JOIN \n"
                                                        + "    Category C ON E.typeId = C.id\n"
                                                        + "WHERE \n"
                                                        + "    E.organizerId = ?  \n"
                                                        + "    AND E.dateOfEvent < GETDATE();";

    private static String SELECT_UPCOMING_EVENTS = "SELECT \n"
                                                        + "	Event.fullname AS EventName,\n"
                                                        + "	Organizer.acronym AS ClubName,\n"
                                                        + "     Event.dateOfEvent AS EventDate,\n"
                                                        + "     Location.locationName AS LocationName,\n"
                                                        + "     Category.categoryName AS CategoryName \n"
                                                        + "FROM \n"
                                                        + "    Event\n"
                                                        + "JOIN\n"
                                                        + "	Organizer ON Organizer.id = Event.organizerId\n"
                                                        + "JOIN \n"
                                                        + "    Location ON Event.locationId = Location.id\n"
                                                        + "JOIN \n"
                                                        + "    Category ON Event.typeId = Category.id\n"
                                                        + "WHERE \n"
                                                        + "	Event.dateOfEvent > GETDATE()\n"
                                                        + "	AND Event.status = 'APPROVE'";

    public int getTotalOrganizedEvents(int adminId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_TOTAL_ORGANIZED_EVENT, adminId);
        int totalEvent = 0;

        try {
            while (rs.next()) {
                totalEvent = rs.getInt("TotalEvents");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalEvent;
    }

    public int getTotalClub() {
        ResultSet rs = executeQueryPreparedStatement(SELECT_TOTAL_CLUBS);
        int totalClub = 0;

        try {
            while (rs.next()) {
                totalClub = rs.getInt("TotalClubs");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalClub;
    }

    public int getTotalUpcomingEvents(int adminId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_TOTAL_UPCOMING_EVENT, adminId);
        int totalUpcomingEvent = 0;

        try {
            while (rs.next()) {
                totalUpcomingEvent = rs.getInt("UpcomingEvents");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalUpcomingEvent;
    }

    public ArrayList<Event> getRegistrationEvent() {
        ResultSet rs = executeQueryPreparedStatement(SELECT_REGISTRATION_EVENTS);
        ArrayList<Event> registrationEvent = new ArrayList<>();

        try {
            while (rs.next()) {
                int eventId = rs.getInt("EventID");
                String clubName = rs.getString("ClubName");
                String avatarPath = rs.getString("AvatarPath");
                String eventName = rs.getString("EventName");
                LocalDate dateOfEvent = rs.getDate("EventDate").toLocalDate();
                String category = rs.getString("CategoryName");
                String location = rs.getString("LocationName");
                String status = rs.getString("Status");

                registrationEvent.add(new Event(eventId, clubName, avatarPath, eventName, dateOfEvent, category, location, status));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return registrationEvent;
    }

    public ArrayList<Event> getOrganizedEvent(int adminId) {
        ResultSet rs = executeQueryPreparedStatement(SELECT_ORGANIZED_EVENTS, adminId);
        ArrayList<Event> organizedEvent = new ArrayList<>();

        try {
            while (rs.next()) {
                String eventName = rs.getString("EventName");
                LocalDate eventDate = rs.getDate("EventDate").toLocalDate();
                String locationName = rs.getString("LocationName");
                String category = rs.getString("CategoryName");

                organizedEvent.add(new Event(eventName, eventDate, locationName, category));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return organizedEvent;
    }
    
    public ArrayList<Event> getUpcomingEvent(){
        ResultSet rs = executeQueryPreparedStatement(SELECT_UPCOMING_EVENTS);
        ArrayList<Event> upcomingEvent = new ArrayList<>();
        
        try {
            while (rs.next()) {
                String eventName = rs.getString("EventName");
                String clubName = rs.getString("ClubName");
                LocalDate dateOfEvent = rs.getDate("EventDate").toLocalDate();
                String location = rs.getString("LocationName");
                String category = rs.getString("CategoryName");
                
                upcomingEvent.add(new Event(eventName, clubName, dateOfEvent, location, category));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return upcomingEvent;
    }
}
