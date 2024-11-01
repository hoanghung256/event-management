/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.enums.Status;
import com.fuem.models.Category;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Organizer;
import com.fuem.models.builders.EventBuilder;
import com.fuem.repositories.helpers.Page;
import com.fuem.repositories.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
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
public class AdminDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(AdminDAO.class.getName());
    private static String SELECT_TOTAL_ORGANIZED_EVENT = "SELECT\n"
            + "	Organizer.fullname AS OrganizerName,\n"
            + "	COUNT(Event.id) AS TotalEvents\n"
            + "FROM \n"
            + "	Organizer\n"
            + "JOIN \n"
            + "	Event ON Organizer.id = Event.organizerId\n"
            + "WHERE \n"
            + "	Organizer.id = ?\n"
            + "GROUP BY \n"
            + "	Organizer.fullname";

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
            + "    Event.id AS EventId, \n"
            + "    Organizer.id AS OrganizerId, \n"
            + "    Organizer.acronym AS ClubName,\n"
            + "    Organizer.avatarPath AS OrganizerAvatarPath,\n"
            + "    Event.fullname AS EventName,\n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Category.categoryName AS CategoryName,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Event.status AS Status,\n"
            + "    COUNT(*) OVER() AS TotalRow \n"
            + "FROM \n"
            + "    Event\n"
            + "JOIN\n"
            + "    Organizer ON Organizer.id = Event.organizerId\n"
            + "JOIN \n"
            + "    Category ON Category.id = Event.categoryId\n"
            + "JOIN \n"
            + "    Location ON Location.id = Event.locationId\n"
            + "WHERE \n"
            + "    Organizer.isAdmin = '0'\n"
            + "    AND Event.status = 'PENDING'\n";

    private static String SELECT_ORGANIZED_EVENTS = "SELECT\n"
            + "    Event.id AS EventId,\n"
            + "    Organizer.id AS OrganizerId, \n"
            + "    Event.fullname AS EventName,\n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Organizer.acronym AS ClubName,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Category.categoryName AS CategoryName\n"
            + "FROM\n"
            + "    Event\n"
            + "JOIN\n"
            + "    Location ON Event.locationId = Location.id\n"
            + "JOIN\n"
            + "    Category ON Event.categoryId = Category.id\n"
            + "JOIN\n"
            + "    Organizer ON Organizer.id = Event.organizerId\n"
            + "WHERE\n"
            + "    MONTH(Event.dateOfEvent) = MONTH(GETDATE())\n"
            + "    AND YEAR(Event.dateOfEvent) = YEAR(GETDATE())\n"
            + "ORDER BY\n"
            + "    Event.dateOfEvent DESC;";

    private static String SELECT_ORGANIZED_EVENTS_EXCEPT_CHOOSEN = "SELECT TOP 3\n"
            + "    Event.id AS EventId,\n"
            + "    Organizer.id AS OrganizerId,\n"
            + "    Event.fullname AS EventName,\n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Organizer.acronym AS ClubName,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Category.categoryName AS CategoryName\n"
            + "FROM\n"
            + "    Event\n"
            + "JOIN\n"
            + "    Location ON Event.locationId = Location.id\n"
            + "JOIN\n"
            + "    Category ON Event.categoryId = Category.id\n"
            + "JOIN\n"
            + "    Organizer ON Organizer.id = Event.organizerId\n"
            + "WHERE\n"
            + "    Event.organizerId = ?\n"
            + "    AND Event.dateOfEvent < GETDATE()\n"
            + "    AND Event.id <> ?\n"
            + "ORDER BY\n"
            + "	Event.dateOfEvent DESC\n";

    private static String SELECT_ORGANIZED_EVENTS_WITH_PAGING = "SELECT\n"
            + "    Event.id AS EventId, \n"
            + "    Organizer.id AS OrganizerId, \n"
            + "    Organizer.acronym AS ClubName,\n"
            + "    Organizer.avatarPath AS OrganizerAvatarPath,\n"
            + "    Event.fullname AS EventName,\n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Category.categoryName AS CategoryName,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Event.status AS Status,\n"
            + "    COUNT(*) OVER() AS TotalRow \n"
            + "FROM \n"
            + "    Event\n"
            + "JOIN\n"
            + "    Organizer ON Organizer.id = Event.organizerId\n"
            + "JOIN \n"
            + "    Category ON Category.id = Event.categoryId\n"
            + "JOIN \n"
            + "    Location ON Location.id = Event.locationId\n"
            + "WHERE\n"
            + "     Event.dateOfEvent < GETDATE()"
            + "ORDER BY\n"
            + "     Event.dateOfEvent DESC\n"
            + "OFFSET ? ROWS\n"
            + "FETCH NEXT ? ROWS ONLY";

    private static String SELECT_UPCOMING_EVENTS = "SELECT \n"
            + "    Event.id AS EventId, \n"
            + "    Event.organizerId AS OrganizerId, \n"
            + "    Event.fullname AS EventName,\n"
            + "    Organizer.acronym AS OrganizerAcronym,\n"
            + "    Organizer.avatarPath AS OrganizerAvatarPath, \n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Category.categoryName AS CategoryName,\n"
            + "    Event.status AS Status,\n"
            + "    Event.guestRegisterLimit AS RegisterLimit,\n"
            + "    Event.guestRegisterCount AS RegisterCount, \n"
            + "    startTime, endTime \n"
            + "FROM \n"
            + "    Event\n"
            + "JOIN\n"
            + "    Organizer ON Organizer.id = Event.organizerId\n"
            + "JOIN \n"
            + "    Location ON Event.locationId = Location.id\n"
            + "JOIN \n"
            + "    Category ON Event.categoryId = Category.id\n"
            + "WHERE \n"
            + "    Event.dateOfEvent >= CAST(GETDATE() AS DATE)\n"
            + "    AND Event.status = 'APPROVED'"
            + "ORDER BY Event.dateOfEvent ASC;";

    private static String SELECT_REGISTRATION_EVENTS_WITH_PAGING = "SELECT\n"
            + "    Event.id AS EventId, \n"
            + "    Organizer.id AS OrganizerId, \n"
            + "    Organizer.acronym AS ClubName,\n"
            + "    Organizer.avatarPath AS OrganizerAvatarPath,\n"
            + "    Event.fullname AS EventName,\n"
            + "    Event.dateOfEvent AS EventDate,\n"
            + "    Category.categoryName AS CategoryName,\n"
            + "    Location.locationName AS LocationName,\n"
            + "    Event.status AS Status,\n"
            + "    COUNT(*) OVER() AS TotalRow \n"
            + "FROM \n"
            + "    Event\n"
            + "JOIN\n"
            + "    Organizer ON Organizer.id = Event.organizerId\n"
            + "JOIN \n"
            + "    Category ON Category.id = Event.categoryId\n"
            + "JOIN \n"
            + "    Location ON Location.id = Event.locationId\n"
            + "WHERE \n"
            + "    Organizer.isAdmin = '0'\n"
            + "    AND Event.status = 'PENDING'\n"
            + "ORDER BY\n"
            + "	Event.dateOfEvent DESC\n"
            + "OFFSET ? ROWS\n"
            + "FETCH NEXT ? ROWS ONLY";

    public int getTotalOrganizedEvents(int adminId) {
        int totalEvent = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_TOTAL_ORGANIZED_EVENT, adminId);) {
            while (rs.next()) {
                totalEvent = rs.getInt("TotalEvents");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalEvent;
    }

    public int getTotalClub() {
        int totalClub = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_TOTAL_CLUBS);) {
            while (rs.next()) {
                totalClub = rs.getInt("TotalClubs");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalClub;
    }

    public int getTotalUpcomingEvents(int adminId) {
        int totalUpcomingEvent = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_TOTAL_UPCOMING_EVENT, adminId);) {
            while (rs.next()) {
                totalUpcomingEvent = rs.getInt("UpcomingEvents");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return totalUpcomingEvent;
    }

    public ArrayList<Event> getRegistrationEvent() {
        ArrayList<Event> registrationEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_REGISTRATION_EVENTS)) {
            while (rs.next()) {
                Event e = new EventBuilder()
                        .setId(rs.getInt("EventID"))
                        .setFullname(rs.getString("EventName"))
                        .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                        .setCategory(new Category(rs.getString("CategoryName")))
                        .setLocation(new Location(rs.getString("LocationName")))
                        .setStatus(Status.valueOf(rs.getString("Status")))
                        .setOrganizer(
                                new Organizer(
                                        rs.getInt("OrganizerId"),
                                        rs.getString("ClubName"),
                                        rs.getNString("OrganizerAvatarPath")
                                )
                        )
                        .setStatus(Status.valueOf(rs.getString("Status")))
                        .build();

                registrationEvent.add(e);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return registrationEvent;
    }

    public ArrayList<Event> getOrganizedEvent() {
        ArrayList<Event> organizedEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZED_EVENTS);) {
            while (rs.next()) {
                organizedEvent.add(
                        new EventBuilder()
                                .setId(rs.getInt("EventId"))
                                .setFullname(rs.getString("EventName"))
                                .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                                .setLocation(
                                        new Location(
                                                rs.getString("LocationName")
                                        )
                                )
                                .setCategory(
                                        new Category(
                                                rs.getString("CategoryName")
                                        )
                                )
                                .setOrganizer(new Organizer(rs.getInt("OrganizerId"), rs.getString("ClubName")))
                                .build()
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return organizedEvent;
    }

    public ArrayList<Event> getOrganizedEventExceptTheChoosen(int organizerId, int id) {
        ArrayList<Event> organizedEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZED_EVENTS_EXCEPT_CHOOSEN, organizerId, id);) {
            while (rs.next()) {
                int eventId = rs.getInt("EventId");
                String eventName = rs.getString("EventName");
                LocalDate eventDate = rs.getDate("EventDate").toLocalDate();
                String acronym = rs.getString("ClubName");
                String locationName = rs.getString("LocationName");
                String category = rs.getString("CategoryName");

                organizedEvent.add(new Event(eventId, eventName, eventDate, acronym, locationName, category));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return organizedEvent;
    }

    public Page<Event> getOrganizedEventWithPaging(PagingCriteria pagingCriteria) {
        Page<Event> page = new Page<>();
        ArrayList<Event> organizedEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ORGANIZED_EVENTS_WITH_PAGING, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }

                organizedEvent.add(
                        new EventBuilder()
                                .setId(rs.getInt("EventId"))
                                .setFullname(rs.getString("EventName"))
                                .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                                .setLocation(
                                        new Location(
                                                rs.getString("LocationName")
                                        )
                                )
                                .setCategory(
                                        new Category(
                                                rs.getString("CategoryName")
                                        )
                                )
                                .setOrganizer(new Organizer(rs.getInt("OrganizerId"), rs.getString("ClubName")))
                                .build()
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(organizedEvent);

        return page;
    }

    public ArrayList<Event> getUpcomingEvent() {
        ArrayList<Event> upcomingEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_UPCOMING_EVENTS);) {
            while (rs.next()) {
                upcomingEvent.add(
                        new EventBuilder()
                                .setId(rs.getInt("EventId"))
                                .setFullname(rs.getNString("EventName"))
                                .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                                .setCategory(
                                        new Category(
                                                rs.getString("CategoryName")
                                        )
                                )
                                .setLocation(
                                        new Location(
                                                rs.getString("LocationName")
                                        )
                                )
                                .setOrganizer(
                                        new Organizer(
                                                rs.getInt("OrganizerId"),
                                                rs.getString("OrganizerAcronym"),
                                                rs.getNString("OrganizerAvatarPath")
                                        )
                                )
                                .setStatus(Status.valueOf(rs.getString("Status")))
                                .setGuestRegisterLimit(rs.getInt("RegisterLimit"))
                                .setGuestRegisterCount(rs.getInt("RegisterCount"))
                                .setStartTime(rs.getTime("startTime").toLocalTime())
                                .setEndTime(rs.getTime("endTime").toLocalTime())
                                .build()
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return upcomingEvent;
    }

    public Page<Event> getRegistrationEventWithPaging(PagingCriteria pagingCriteria) {
        Page<Event> page = new Page<>();
        ArrayList<Event> registrationEvent = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_REGISTRATION_EVENTS_WITH_PAGING, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }

                Event e = new EventBuilder()
                        .setId(rs.getInt("EventID"))
                        .setFullname(rs.getString("EventName"))
                        .setDateOfEvent(rs.getDate("EventDate").toLocalDate())
                        .setCategory(new Category(rs.getString("CategoryName")))
                        .setLocation(new Location(rs.getString("LocationName")))
                        .setStatus(Status.valueOf(rs.getString("Status")))
                        .setOrganizer(
                                new Organizer(
                                        rs.getInt("OrganizerId"),
                                        rs.getString("ClubName"),
                                        rs.getNString("OrganizerAvatarPath")
                                )
                        )
                        .setStatus(Status.valueOf(rs.getString("Status")))
                        .build();

                registrationEvent.add(e);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(registrationEvent);
        return page;
    }
}
