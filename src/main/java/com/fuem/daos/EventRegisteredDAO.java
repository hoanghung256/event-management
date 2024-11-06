/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.models.Event;
import com.fuem.models.Organizer;
import com.fuem.models.Student;
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
            + "    AND eg.guestId = ? \n"
            + "    AND eg.isCancelRegister = 0  \n"
            + "LEFT JOIN [EventCollaborator] ec \n"
            + "    ON ec.eventId = e.id \n"
            + "    AND ec.studentId = ? \n"
            + "    AND ec.isCancel = 0 \n"
            + "LEFT JOIN [Organizer] o \n"
            + "    ON o.id = e.organizerId\n"
            + "WHERE ((eg.isRegistered = 1 AND eg.isCancelRegister = 0)  \n"
            + "   OR (ec.studentId IS NOT NULL AND ec.isCancel = 0)) \n"
            + "AND e.status='APPROVED';";

    private static final String REGISTER_COLLABORATOR_EVENT
            = "INSERT INTO [EventCollaborator](studentId, eventId) VALUES(?, ?)";

    private static final String CANCEL_COLLABORATOR_EVENT
            = "DELETE FROM [EventCollaborator] WHERE studentId = ? AND eventId = ?";

    private static final String REGISTER_GUEST_EVENT
            = "INSERT INTO [EventGuest](guestId, eventId, isRegistered) VALUES(?, ?, '1')";

    private static final String CANCEL_GUEST_EVENT
            = "UPDATE [EventGuest] SET isCancelRegister = '1', isRegistered = '0' WHERE guestId = ? AND eventId = ?";

    private static final String IS_STUDENT_REGIS_AS_GUEST = "SELECT \n"
            + "COUNT (1) AS 'isGuestRegis' \n"
            + "FROM [EventGuest] "
            + "WHERE isRegistered = 1 AND isCancelRegister = 0 AND guestId = ? AND eventId = ?;";
    private static final String IS_STUDENT_REGIS_AS_COLLAB = "SELECT "
            + "COUNT (1) AS 'isCollabRegis' "
            + "FROM [EventCollaborator] "
            + "WHERE studentId = ? AND eventId = ?;";
    private static final String SELECT_GUEST_BY_ID = "SELECT Student.studentId, Student.fullname, Student.email, COUNT(*) OVER() AS TotalRow "
            + "FROM EventGuest "
            + "JOIN Student ON EventGuest.guestId = Student.id "
            + "WHERE EventGuest.eventId = ? AND EventGuest.isRegistered='1' AND isCancelRegister='0' "
            + "ORDER BY Student.fullname "
            + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    private static final String UPDATE_REGISTER_STATUS_FROM_CANCEL = "UPDATE [EventGuest] SET isRegistered='1', isCancelRegister='0' WHERE guestId=? AND eventId=?";
    private static final String SELECT_IF_GUEST_CANCELED = "SELECT COUNT(1) FROM [EventGuest] WHERE guestId=? AND eventId=? AND isCancelRegister='1'";

    public List<Event> getRegisteredEventListByStudentId(int studentId) {
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
        int affectedRows = 0;
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection()) {
            if (isGuestCanceled(guestId, eventId)) {
                affectedRows = executeUpdatePreparedStatement(conn, UPDATE_REGISTER_STATUS_FROM_CANCEL, guestId, eventId);
            } else {
                affectedRows = executeUpdatePreparedStatement(conn, REGISTER_GUEST_EVENT, guestId, eventId);
            }
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

    /**
     *
     * @author Trinhhuy
     */
    public Page<Student> getEventGuestsByEventId(PagingCriteria pagingCriteria, String eventId) {
        Page<Student> page = new Page<>();
        ArrayList<Student> guestList = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_GUEST_BY_ID, eventId, pagingCriteria.getOffset(), pagingCriteria.getFetchNext());) {
            while (rs.next()) {
                // Lấy tổng số hàng cho phân trang
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }

                // Tạo đối tượng Student và thiết lập thông tin
                Student student = new Student();
                student.setStudentId(rs.getString("studentId"));
                student.setFullname(rs.getString("fullname"));
                student.setEmail(rs.getString("email"));

                guestList.add(student);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        page.setDatas(guestList);
        return page;
    }

    public boolean isGuestCanceled(int guestId, int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_IF_GUEST_CANCELED, guestId, eventId)) {
            if (rs.next()) {
                return rs.getBoolean(1);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
            return false; // Trả về false nếu có lỗi
        }
        
        return false;
    }
}
