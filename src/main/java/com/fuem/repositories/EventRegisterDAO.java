package com.fuem.repositories;

import com.fuem.enums.Gender;
import com.fuem.models.Event;
import com.fuem.models.EventGuest;
import com.fuem.models.Student;
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
            + "ORDER BY "
            + "    e.id, e.fullname, e.dateOfEvent, o.acronym, s.id, s.fullname "
            + "OFFSET ? ROWS "
            + "FETCH NEXT ? ROWS ONLY";

    public EventRegisterDAO() {
        super();
    }

    public Page<EventGuest> getRegisteredGuestsList(PagingCriteria pagingCriteria) {
        Page<EventGuest> page = new Page<>();
        ArrayList<EventGuest> registeredGuestsList = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_REGISTERED_GUESTS, pagingCriteria.getOffset(), pagingCriteria.getFetchNext())) {

            while (rs.next()) {
                String studentId = rs.getString("studentId");
                String guestName = rs.getString("guestName"); // Đổi từ studentFullName thành fullName
                int eventId = rs.getInt("eventId");
                String eventName = rs.getString("eventName");
                LocalDate dateOfEvent = rs.getDate("dateOfEvent").toLocalDate();
//    String organizerAcronym = rs.getString("organizerAcronym");

                // Tạo đối tượng EventGuest
                EventGuest guest = new EventGuest(
                        new Student(
                                studentId, 
                                null, 
                                eventId
                        ),
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
}
