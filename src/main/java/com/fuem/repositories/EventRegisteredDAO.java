/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

import com.fuem.models.Category;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Organizer;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class EventRegisteredDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(EventAttendedDAO.class.getName());
    private static final String SELECT_ATTENDED_EVENTS = "SELECT e.id, \n"
            + "       e.fullname, \n"
            + "       e.dateOfEvent, \n"
            + "       o.fullname AS OrganizerName, \n"
            + "       CASE \n"
            + "           WHEN eg.isRegistered = 1 AND eg.isCancelRegister = 0 THEN 'GUEST'\n"
            + "           WHEN ec.studentId IS NOT NULL AND ec.isCancel = 0 THEN 'COLLABORATOR'\n"
            + "           ELSE NULL\n"
            + "       END AS Role\n"
            + "FROM [Event] e\n"
            + "LEFT JOIN [EventGuest] eg \n"
            + "    ON eg.eventId = e.id \n"
            + "    AND eg.guestId = (SELECT id FROM [Student] WHERE studentId = ?)\n"
            + "    AND eg.isCancelRegister = 0  \n"
            + "LEFT JOIN [EventCollaborator] ec \n"
            + "    ON ec.eventId = e.id \n"
            + "    AND ec.studentId = (SELECT id FROM [Student] WHERE studentId = ?)\n"
            + "    AND ec.isCancel = 0 \n"
            + "LEFT JOIN [Organizer] o \n"
            + "    ON o.id = e.organizerId\n"
            + "WHERE (eg.isRegistered = 1 AND eg.isCancelRegister = 0)  \n"
            + "   OR (ec.studentId IS NOT NULL AND ec.isCancel = 0);    ";

    private static final String REGISTER_COLLABORATOR_EVENT
            = "MERGE INTO [EventCollaborator] AS target\n"
            + "USING (SELECT (SELECT id FROM [Student] WHERE studentId = ?) AS studentId, ? AS eventId) AS source\n"
            + "ON target.studentId = source.studentId AND target.eventId = source.eventId\n"
            + "WHEN MATCHED THEN\n"
            + "    UPDATE SET isCancel = 0\n"
            + "WHEN NOT MATCHED THEN\n"
            + "    INSERT (studentId, eventId, isCancel) \n"
            + "    VALUES (source.studentId, source.eventId, 0);";

    private static final String CANCEL_COLLABORATOR_EVENT
            = "UPDATE[EventCollaborator] SET isCancel = 1 WHERE studentId = (SELECT id FROM [Student] WHERE studentId = ?) AND eventId = ?";

    private static final String REGISTER_GUEST_EVENT
            = "MERGE INTO [EventGuest] AS target\n"
            + "USING (SELECT (SELECT id FROM [Student] WHERE studentId = ?) AS studentId, ? AS eventId) AS source\n"
            + "ON target.guestId = source.studentId AND target.eventId = source.eventId\n"
            + "WHEN MATCHED THEN\n"
            + "    UPDATE SET isCancelRegister = 0\n"
            + "WHEN NOT MATCHED THEN\n"
            + "    INSERT (guestId, eventId, isRegistered, isCancelRegister) \n"
            + "    VALUES (source.studentId, source.eventId, 1, 0);";

    private static final String CANCEL_GUEST_EVENT
            = "UPDATE [EventGuest] SET isCancelRegister = 1 WHERE guestId = (SELECT id FROM [Student] WHERE studentId = ?) AND eventId = ?";

    private static final String CHECK_STUDENT_ROLE_QUERY
            = "SELECT "
            + "    CASE "
            + "        WHEN eg.isRegistered = 1 THEN 'GUEST' "
            + "        WHEN ec.studentId IS NOT NULL THEN 'COLLABORATOR' "
            + "        ELSE NULL "
            + "    END AS Role "
            + "FROM "
            + "    [Student] s "
            + "LEFT JOIN "
            + "    [EventGuest] eg ON eg.guestId = s.id AND eg.eventId = ?"
            + "    AND eg.isCancelRegister = 0 "
            + "LEFT JOIN "
            + "    [EventCollaborator] ec ON ec.studentId = s.id AND ec.eventId = ? "
            + "AND ec.isCancel = 0"
            + "WHERE "
            + "    s.studentId = ?";

    public List<Event> getRegisteredEventListByStudentId(String studentId) {
        List<Event> registeredEvents = new ArrayList<>();

        // First, retrieve the registered events
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ATTENDED_EVENTS, studentId, studentId)) {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                Organizer organizer = new Organizer();
                organizer.setFullname(rs.getString("OrganizerName"));
                event.setOrganizer(organizer);
                String role = rs.getString("Role");
                event.setRole(role); // Assuming you have a method setRole in Event class

                registeredEvents.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return registeredEvents;
    }

    public boolean registerCollaborator(String studentId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, REGISTER_COLLABORATOR_EVENT, studentId, eventId);
            return affectedRows > 0; // Trả về true nếu đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean cancelCollaboratorRegistration(String studentId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, CANCEL_COLLABORATOR_EVENT, studentId, eventId);
            return affectedRows > 0; // Trả về true nếu hủy đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean registerGuest(String studentId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, REGISTER_GUEST_EVENT, studentId, eventId);
            return affectedRows > 0; // Trả về true nếu đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean cancelGuestRegistration(String studentId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, CANCEL_GUEST_EVENT, studentId, eventId);
            return affectedRows > 0; // Trả về true nếu hủy đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public String checkStudentRole(String studentId, int eventId) {
        String role = null;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, CHECK_STUDENT_ROLE_QUERY, eventId, eventId, studentId)) {

            if (rs.next()) {
                role = rs.getString("Role");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return role; // Trả về vai trò, hoặc null nếu không tìm thấy
    }

}
