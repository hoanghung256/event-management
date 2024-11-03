package com.fuem.daos;

import com.fuem.models.EventGuest;
import com.fuem.models.Student;
import com.fuem.models.builders.EventBuilder;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventRegisterDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(EventRegisterDAO.class.getName());

    private static final String SELECT_REGISTERED_GUESTS
            = "SELECT "
            + "    s.studentId AS studentId, "
            + "    s.fullname AS guestName, "
            + "    e.id AS eventId, "
            + "    e.fullname AS eventName, "
            + "    e.dateOfEvent, "
            + "    o.acronym AS organizerAcronym "
            + "FROM "
            + "    EventGuest eg "
            + "JOIN "
            + "    Student s ON eg.guestId = s.id "
            + "JOIN "
            + "    Event e ON eg.eventId = e.id "
            + "JOIN "
            + "    Organizer o ON e.organizerId = o.id "
            + "WHERE "
            + "    eg.isRegistered = 1 "
            + "    AND e.id = 2 "
            + "OFFSET ? ROWS "
            + "FETCH NEXT ? ROWS ONLY";
    private static String SELECT_GUEST_ATTENDANCE_STATUS = "SELECT isRegistered, isAttended, isCancelRegister FROM [EventGuest] WHERE eventId=? AND guestId=?";
    private static String UPDATE_ATTENDANCE_STATUS = "UPDATE [EventGuest] SET isAttended=1 WHERE eventId=? AND guestId=?";
    private static String INSERT_ATTENDANCE_STATUS = "INSERT INTO [EventGuest](eventId, guestId, isAttended, isRegistered) VALUES(?, ?, 1, 0)";

    public EventRegisterDAO() {
        super();
    }

    public Page<EventGuest> getRegisteredGuestsList(PagingCriteria pagingCriteria) {
        Page<EventGuest> page = new Page<>();
        ArrayList<EventGuest> registeredGuestsList = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_REGISTERED_GUESTS, pagingCriteria.getOffset(), pagingCriteria.getFetchNext())) {

            while (rs.next()) {
                String studentId = rs.getString("studentId");
                String guestName = rs.getString("guestName");
                int eventId = rs.getInt("eventId");
                String eventName = rs.getString("eventName");
                LocalDate dateOfEvent = rs.getDate("dateOfEvent").toLocalDate();
//    String organizerAcronym = rs.getString("organizerAcronym");

                Student student = new Student();
                student.setStudentId(studentId);
                student.setFullname(guestName);
                // Tạo đối tượng EventGuest
                EventGuest guest = new EventGuest(
                        student,
                        new EventBuilder()
                                .setId(eventId)
                                .setFullname(eventName)
                                .setDateOfEvent(dateOfEvent)
                                .build()
                );

                registeredGuestsList.add(guest);
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e); // Ghi lại lỗi nếu có
        }
        page.setDatas(registeredGuestsList); // Cập nhật danh sách khách vào trang
        return page;
    }
    
    
    /**
     * 
     * @param eventId
     * @param guestId
     * @return status[2], a boolean array
     *      status[0] mean isRegistered
     *      status[1] mean isAttended
     * @author HungHV
     */
    public boolean[] getGuestAttendanceStatus(int eventId, int guestId) {
        boolean[] status = new boolean[] {false, false, false};

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_GUEST_ATTENDANCE_STATUS, eventId, guestId);) {
            if (rs.next()) {
                status[0] = rs.getBoolean("isRegistered");
                status[1] = rs.getBoolean("isAttended");
                status[2] = rs.getBoolean("isCancelRegister");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return status;
    }

    /**
     * When guest already registered into an event, only need to update EventGuest.isAttended=1
     * 
     * @author HungHV 
     */
    public boolean updateAttendanceStatus(int eventId, int guestId) {
        int rowChange = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, UPDATE_ATTENDANCE_STATUS, eventId, guestId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return (rowChange > 0);
    }

    /**
     * When guest have not registered into an event, need to insert a new record with EventGuest.isAttended = 1
     * 
     * @author HungHV 
     */
    public boolean insertAttendaceStatus(int eventId, int guestId) {
        int rowChange = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            rowChange = executeUpdatePreparedStatement(conn, INSERT_ATTENDANCE_STATUS, eventId, guestId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return (rowChange > 0);
    }
}
