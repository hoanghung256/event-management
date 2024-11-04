/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.builders.EventBuilder;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
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
    private static final String SELECT_ATTENDED_EVENTS = "SELECT DISTINCT\n"
            + "    Event.id, \n"
            + "    Event.fullname AS eventName,\n"
            + "    Organizer.acronym AS organizerName,\n"
            + "    Organizer.avatarPath AS organizerAvatarPath,\n"
            + "    Event.dateOfEvent AS eventDate,\n"
            + "    COUNT(*) OVER() AS TotalRow,\n"
            + "    (SELECT COUNT(*) \n"
            + "     FROM [Feedback] \n"
            + "     WHERE Feedback.eventId = Event.id \n"
            + "       AND Feedback.guestId = EventGuest.guestId) AS isFeedback\n"
            + "FROM \n"
            + "    [EventGuest] EventGuest\n"
            + "JOIN \n"
            + "    [Event] Event ON EventGuest.eventId = Event.id\n"
            + "JOIN \n"
            + "    [Organizer] Organizer ON Event.organizerId = Organizer.id\n"
            + "JOIN \n"
            + "    [Student] Student ON EventGuest.guestId = Student.id\n"
            + "WHERE "
            + "    EventGuest.guestId = ? "
            + "AND \n"
            + "    EventGuest.isAttended = 1 \n"
            + "AND \n"
            + "    Event.status='END'\n"
            + "ORDER BY \n"
            + "    Event.dateOfEvent DESC\n"
            + "OFFSET ? ROWS\n"
            + "FETCH NEXT ? ROWS ONLY;";

    public EventAttendedDAO() {
        super();
    }

    /**
     *
     * @author ThangNM
     */
    public Page<Object[]> getAttendedEventsList(PagingCriteria pagingCriteria, int userId) {
        Page<Object[]> page = new Page<>();
        ArrayList<Object[]> eventsAttendedList = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ATTENDED_EVENTS, userId, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }

                Organizer organizer = new Organizer();
                organizer.setAcronym(rs.getNString("organizerName"));
                organizer.setAvatarPath(rs.getNString("organizerAvatarPath"));
                boolean isFeedback = rs.getBoolean("isFeedback");

                Event event = new EventBuilder()
                        .setId(rs.getInt("id"))
                        .setFullname(rs.getString("eventName"))
                        .setOrganizer(organizer)
                        .setDateOfEvent(rs.getDate("eventDate").toLocalDate())
                        .build();
                
                Object[] eventsWithFeedback = new Object[2];
                eventsWithFeedback[0] = event;
                eventsWithFeedback[1] = isFeedback;
                eventsAttendedList.add(eventsWithFeedback);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(eventsAttendedList);

        return page;
    }
}
