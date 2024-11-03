/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

import com.fuem.models.Event;
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
            = "INSERT INTO [EventCollaborator](studentId, eventId) VALUES(?, ?)";

    private static final String CANCEL_COLLABORATOR_EVENT
            = "DELETE FROM [EventCollaborator] WHERE studentId = ? AND eventId = ?";

    private static final String REGISTER_GUEST_EVENT
            = "MERGE INTO [EventGuest] AS target\n"
            + "USING (SELECT ? AS guestId, ? AS eventId) AS source\n"
            + "ON target.guestId = source.guestId AND target.eventId = source.eventId\n"
            + "WHEN MATCHED THEN\n"
            + "    UPDATE SET isRegistered = 1\n"
            + "WHEN NOT MATCHED THEN\n"
            + "    INSERT (guestId, eventId, isRegistered)\n"
            + "    VALUES (source.guestId, source.eventId, 1);";

    private static final String CANCEL_GUEST_EVENT
            = "UPDATE [EventGuest] SET isRegistered = 0, isCancelRegister = 1 WHERE guestId = ? AND eventId = ?";

    private static final String IS_STUDENT_REGIS_AS_GUEST = "SELECT \n"
            + "COUNT (1) AS 'isGuestRegis' \n"
            + "FROM [EventGuest] "
            + "WHERE isRegistered = 1 AND guestId = ? AND eventId = ?;";
    private static final String IS_STUDENT_REGIS_AS_COLLAB = "SELECT "
            + "COUNT (1) AS 'isCollabRegis' "
            + "FROM [EventCollaborator] "
            + "WHERE studentId = ? AND eventId = ?;";

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

    public boolean registerCollaborator(int collabId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, REGISTER_COLLABORATOR_EVENT, collabId, eventId);
            return affectedRows > 0; // Trả về true nếu đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean cancelCollaboratorRegistration(int collabId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, CANCEL_COLLABORATOR_EVENT, collabId, eventId);
            return affectedRows > 0; // Trả về true nếu hủy đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean registerGuest(int guestId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, REGISTER_GUEST_EVENT, guestId, eventId);
            return affectedRows > 0; // Trả về true nếu đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean cancelGuestRegistration(int guestId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            int affectedRows = executeUpdatePreparedStatement(conn, CANCEL_GUEST_EVENT, guestId, eventId);
            return affectedRows > 0; // Trả về true nếu hủy đăng ký thành công
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
    }

    /**
     * @return a 2 length boolean array with index 0 present isGuestRegis, index
     * 1 present isCollabRegis
     * @author HungHV
     */
    public boolean[] isStudentRegistered(int userId, int eventId) {
        boolean isGuestRegis = false;
        boolean isCollabRegis = false;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            try (ResultSet rs = executeQueryPreparedStatement(conn, IS_STUDENT_REGIS_AS_GUEST, userId, eventId);) {
                if (rs.next()) {
                    isGuestRegis = rs.getBoolean("isGuestRegis");
                }
            }

            try (ResultSet rs = executeQueryPreparedStatement(conn, IS_STUDENT_REGIS_AS_COLLAB, userId, eventId);) {
                if (rs.next()) {
                    isCollabRegis = rs.getBoolean("isCollabRegis");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return new boolean[]{isGuestRegis, isCollabRegis};
    }
}
