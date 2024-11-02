/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

import com.fuem.enums.EventStatus;
import com.fuem.models.Category;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Organizer;
import com.fuem.models.builders.EventBuilder;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ThangNM
 */
public class ClubDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(ClubDAO.class.getName());
    private static String SELECT_ALL_EVENT_ORGANIZED = "SELECT\n"
            + "	COUNT(id) AS TotalEvents\n"
            + "FROM \n"
            + "	Event\n"
            + "WHERE \n"
            + " organizerId = ? AND status='END'\n";

    private static String SELECT_ALL_UPCOMING_EVENTS = "SELECT \n"
            + "    COUNT(id) AS UpcomingEvents\n"
            + "FROM \n"
            + "    Event\n"
            + "WHERE dateOfEvent > GETDATE() "
            + "AND status='APPROVED' "
            + "AND organizerId = ?";

    private static String SELECT_ALL_FOLLOWERS = "SELECT \n"
            + "    COUNT(studentId) AS FollowerCount\n"
            + "FROM \n"
            + "    Follow\n"
            + "WHERE \n"
            + "    organizerId = ?";

    private static String SELECT_ORGANIZED_EVENTS = "SELECT \n"
            + "    COUNT(*) OVER() AS 'TotalRow', \n"
            + "    Event.id AS EventId,\n"
            + "    Organizer.id AS OrganizerId,"
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
            + "JOIN \n"
            + "	Organizer ON Organizer.id = Event.organizerId\n"
            + "WHERE\n"
            + "    Event.organizerId = ?\n"
            + "    AND Event.status='END'";

    private static String SELECT_UPCOMING_EVENTS = "SELECT \n"
            + "    Event.id AS EventId,\n"
            + "    Event.fullname AS EventName,\n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Category.categoryName AS CategoryName,\n"
            + "    Event.status AS Status,\n"
            + "    Event.guestRegisterLimit AS RegisterLimit,\n"
            + "    Event.guestRegisterCount AS RegisterCount, \n"
            + "    startTime, endTime \n"
            + "FROM \n"
            + "    Event\n"
            + "JOIN \n"
            + "    Location ON Event.locationId = Location.id\n"
            + "JOIN \n"
            + "    Category ON Event.categoryId = Category.id\n"
            + "WHERE \n"
            + "    Event.organizerId = ?\n"
            + "    AND Event.dateOfEvent >= CAST(GETDATE() AS DATE)\n"
            + "    AND Event.status = 'APPROVED'\n"
            + "ORDER BY Event.dateOfEvent ASC;";

    public int getTotalEventOrganized(int clubId) {
        int totalEvent = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ALL_EVENT_ORGANIZED, clubId);){
            while(rs.next()) {
                totalEvent = rs.getInt("TotalEvents");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalEvent;
    }

    public int getTotalUpcomingEvents(int clubId) {
        int totalUpcomingEvents = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ALL_UPCOMING_EVENTS, clubId);) {
            while (rs.next()) {
                totalUpcomingEvents = rs.getInt("UpcomingEvents");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalUpcomingEvents;
    }

    public int getTotalFollowers(int clubId) {
        int totalFollowers = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ALL_FOLLOWERS, clubId);) {
            while (rs.next()) {
                totalFollowers = rs.getInt("FollowerCount");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalFollowers;
    }

    public ArrayList<Event> getOrganizedEvent(int clubId) {
        ArrayList<Event> organizedEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZED_EVENTS, clubId);) {
            while (rs.next()) {
                Event e = new EventBuilder()
                        .setId(rs.getInt("EventId"))
                        .setOrganizer(new Organizer(rs.getInt("OrganizerId")))
                        .setFullname(rs.getString("EventName"))
                        .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                        .setLocation(new Location(rs.getString("LocationName")))
                        .setCategory(new Category(rs.getString("CategoryName")))
                        .build();
                organizedEvent.add(e);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return organizedEvent;
    }

    public ArrayList<Event> getUpcomingEvent(int clubId) {
        ArrayList<Event> upcomingEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_UPCOMING_EVENTS, clubId);){
            while(rs.next()){
                int id = rs.getInt("EventId");
                String eventName = rs.getString("EventName");
                LocalDate eventDate = rs.getDate("EventDate").toLocalDate();
                String locationName = rs.getString("LocationName");
                String category = rs.getString("CategoryName");
                EventStatus status = EventStatus.valueOf(rs.getString("Status"));
                int registerLimit = rs.getInt("RegisterLimit");
                int registerCount = rs.getInt("RegisterCount");
                LocalTime startTime = rs.getTime("startTime").toLocalTime();
                LocalTime endTime = rs.getTime("endTime").toLocalTime();

                upcomingEvent.add(new Event(id, eventName, eventDate, locationName, category, status, registerLimit, registerCount, startTime, endTime));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return upcomingEvent;
    }
    
    public Page<Event> getOrganizedEventWithPaging(int clubId, PagingCriteria pagingCriteria) {
        Page<Event> page = new Page<>();
        ArrayList<Event> organizedEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZED_EVENTS, clubId);) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                
                Event e = new EventBuilder()
                        .setId(rs.getInt("EventId"))
                        .setOrganizer(new Organizer(rs.getInt("OrganizerId")))
                        .setFullname(rs.getString("EventName"))
                        .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                        .setLocation(new Location(rs.getString("LocationName")))
                        .setCategory(new Category(rs.getString("CategoryName")))
                        .build();
                organizedEvent.add(e);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(organizedEvent);
        return page;
    }
}
