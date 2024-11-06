/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

import com.fuem.enums.Role;
import com.fuem.enums.EventStatus;
import com.fuem.models.Event;
import com.fuem.models.Location;
import com.fuem.models.Category;
import com.fuem.models.Organizer;
import com.fuem.daos.helpers.EventOrderBy;
import com.fuem.daos.helpers.Page;
import com.fuem.daos.helpers.PagingCriteria;
import com.fuem.daos.helpers.SearchEventCriteria;
import com.fuem.utils.DataSourceWrapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AnhNQ
 */
public class EventDAO extends SQLDatabase {

    private static final Logger logger = Logger.getLogger(EventDAO.class.getName());

    private static final String SELECT_IMG_BY_ID = "SELECT path FROM EventImage WHERE eventId = ?";
    private static final String SELECT_EVENT_DETAILS_BY_ID = "SELECT e.id, "
            + "o.fullname AS organizerName, "
            + "o.id AS organizerId, "
            + "e.fullname AS eventName, "
            + "e.description, "
            + "c.categoryName, "
            + "l.locationName, "
            + "e.dateOfEvent, "
            + "e.startTime, "
            + "e.endTime, "
            + "e.guestRegisterLimit, "
            + "e.guestRegisterDeadline, "
            + "e.guestRegisterCount, "
            + "e.guestAttendedCount, "
            + "e.collaboratorRegisterLimit, "
            + "e.collaboratorRegisterDeadline, "
            + "e.collaboratorRegisterCount, "
            + "o.avatarPath AS organizerAvatarPath "
            + "FROM [Event] e "
            + "JOIN [Organizer] o ON e.organizerId = o.id "
            + "JOIN [Category] c ON e.categoryId = c.id "
            + "JOIN [Location] l ON e.locationId = l.id "
            + "WHERE e.id = ?;";

    private static final String SELECT_RECENTLY_EVENT_BY_ID = "SELECT TOP 10 e.id, "
            + "       e.fullname, "
            + "       e.description, "
            + "       e.dateOfEvent, "
            + "       e.startTime, "
            + "       e.endTime, "
            + "       e.guestRegisterLimit, "
            + "       e.guestRegisterDeadline, "
            + "       e.avatarPath, "
            + "       o.fullname AS organizerName, "
            + "       o.id AS organizerId, "
            + "       c.id AS categoryId, "
            + "       c.categoryName, "
            + "       c.categoryDescription, "
            + "       l.id AS locationId, "
            + "       l.locationName "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "WHERE e.organizerId = ? "
            + "ORDER BY e.dateOfEvent DESC;";
    private static final String SELECT_EVENTS_FOLLOWED = "SELECT e.*, "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "c.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "JOIN Follow f ON e.organizerId = f.followedId "
            + "WHERE f.followerId = ? "
            + "AND e.dateOfEvent > GETDATE() "
            + "ORDER BY e.dateOfEvent DESC";
    private static final String SELECT_EVENTS_FOLLOWED_AND_NOT_FOLLOWED = "SELECT e.*, "
            + "COUNT(*) OVER() AS 'TotalRow', "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "c.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationName, "
            + "CASE WHEN f.organizerId IS NOT NULL THEN 1 ELSE 0 END AS isFollowing, "
            + "o.id AS organizerId "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "LEFT JOIN Follow f ON e.organizerId = f.organizerId AND f.studentId = ? ";
    private static final String SELECT_ALL_CATEGORY = "SELECT * FROM [Category]";
    private static final String SELECT_STATISTIC_NUMBER_OF_EVENT = "SELECT	"
            + " guestRegisterCount AS TotalRegister,\n"
            + "	guestAttendedCount AS TotalAttended,\n"
            + "	collaboratorRegisterCount AS TotalCollaborator,\n"
            + "	guestRegisterCancelCount AS TotalCancel\n"
            + "FROM Event\n"
            + "WHERE id = ?\n";
    private static final String SELECT_ALL_LOCATIONS = "SELECT id, locationName FROM [Location]";
    private static final String INSERT_NEW_EVENT = "INSERT INTO [Event] ("
            + "organizerId, "
            + "fullname, "
            + "avatarPath, "
            + "description, "
            + "categoryId, "
            + "locationId, "
            + "dateOfEvent, "
            + "startTime, "
            + "endTime, "
            + "guestRegisterLimit, "
            + "collaboratorRegisterLimit, "
            + "guestRegisterDeadline, "
            + "collaboratorRegisterDeadline, "
            + "status)"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

    private static final String SELECT_INCOMING_EVENT_BY_ORGANIZER_ID = "SELECT TOP 10 e.*, "
            + "       o.fullname AS organizerName, "
            + "       o.id AS organizerId, "
            + "       cate.id AS CategoryId, "
            + "       cate.categoryName, "
            + "       cate.categoryDescription, "
            + "       l.id AS locationId, "
            + "       l.locationDescription AS locationDescription "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category cate ON e.categoryId = cate.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "WHERE e.organizerId = ? "
            + "AND e.guestRegisterCount > 0 "
            + "AND e.status = 'APPROVED' "
            + "AND e.dateOfEvent > GETDATE()"
            + "ORDER BY e.dateOfEvent DESC;";
    private static final String UPDATE_EVENT_BY_ID
            = "UPDATE event SET fullname = ?, description = ?, categoryId = ?, locationId = ?, "
            + "dateOfEvent = ?, startTime = ?, endTime = ?, "
            + "guestRegisterLimit = ?, guestRegisterDeadline = ?, "
            + "collaboratorRegisterLimit = ?, collaboratorRegisterDeadline = ?, "
            + "avatarPath = ? "
            + "WHERE id = ?";

    private static final String SELECT_TODAY_EVENT = "SELECT e.*, "
            + "COUNT(*) OVER() AS 'TotalRow', "
            + "o.fullname AS organizerName, o.id AS organizerId, "
            + "c.id AS categoryId, c.categoryName, c.categoryDescription, "
            + "l.id AS locationId, l.locationName "
            + "FROM Event e "
            + "JOIN Organizer o ON e.organizerId = o.id "
            + "JOIN Category c ON e.categoryId = c.id "
            + "JOIN Location l ON e.locationId = l.id "
            + "WHERE e.status = 'APPROVED' "
            + "AND e.dateOfEvent = CAST(GETDATE() AS DATE)";
    private static final String SELECT_EVENTS_FOR_GUEST = "SELECT \n"
            + "    e.*, \n"
            + "    COUNT(*) OVER() AS TotalRow, \n"
            + "    o.fullname AS organizerName, \n"
            + "    o.id AS organizerId, \n"
            + "    c.id AS categoryId, \n"
            + "    c.categoryName, \n"
            + "    c.categoryDescription, \n"
            + "    l.id AS locationId, \n"
            + "    l.locationName\n"
            + "FROM \n"
            + "    Event e \n"
            + "JOIN \n"
            + "    Organizer o ON e.organizerId = o.id \n"
            + "JOIN \n"
            + "    Category c ON e.categoryId = c.id \n"
            + "JOIN \n"
            + "    Location l ON e.locationId = l.id";
    private static final String GET_ATTENDED_COUNT_BY_EVENT_ID = "SELECT guestAttendedCount FROM [Event] WHERE id=?";
    private static final String UPDATE_STATUS_BY_EVENT_ID = "UPDATE [Event] SET status=? WHERE id=?";
    private static final String SELECT_EVENT_NAME_BY_EVENT_ID = "SELECT fullname FROM [Event] WHERE id=?;";

    public EventDAO() {
        super();
    }

    /**
     *
     * @author AnhNQ
     */
    public List<Event> getEventsByFollowingOrganizers(int userId) {
        List<Event> events = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_EVENTS_FOLLOWED, userId)) {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);

                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);

                Location location = new Location();
                location.setId(rs.getInt("locationId"));
                location.setDescription(rs.getString("locationDescription"));
                event.setLocation(location);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return events;
    }

    /**
     *
     * @author AnhNQ
     */
    public List<Event> getTodayEvent() {
        List<Event> events = new ArrayList<>();
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_TODAY_EVENT)) {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                List<String> imgUrls = new ArrayList<>();
                imgUrls.add(rs.getNString("avatarPath"));
                event.setImages(imgUrls);

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);

                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);

                Location location = new Location();
                location.setId(rs.getInt("locationId"));
                location.setName(rs.getString("locationName"));
                event.setLocation(location);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return events;
    }

    /**
     *
     * @author AnhNQ
     */
    public List<Event> getIncomingEventByOrganizerId(int userId) {
        List<Event> events = new ArrayList<>();
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_INCOMING_EVENT_BY_ORGANIZER_ID, userId);) {
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                // event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));

                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);

                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);

                Location eventLocation = new Location();
                eventLocation.setId(rs.getInt("locationId"));
                eventLocation.setDescription(rs.getString("locationDescription"));
                event.setLocation(eventLocation);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return events;
    }

    /**
     *
     * @author AnhNQ
     */
    public List<Category> getAllCategory() {
        List<Category> categories = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ALL_CATEGORY)) {
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                categories.add(category);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return categories;
    }

    /**
     *
     * @author AnhNQ
     */
    public List<Organizer> getAllOrganizer() {
        List<Organizer> organizers = new ArrayList<>();
        String sql = "SELECT * FROM [Organizer]";

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, sql)) {
            while (rs.next()) {
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("id"));
                organizer.setFullname(rs.getString("fullname"));
                organizers.add(organizer);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return organizers;
    }

    public Page<Object[]> get(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria, int id) {
        Page<Object[]> page = new Page<>();
        ArrayList<Object[]> datas = new ArrayList<>();
        String query = buildSelectQuery(pagingCriteria, searchEventCriteria);

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, query, id);) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));

                List<String> images = new ArrayList<>();
                images.add(rs.getNString("avatarPath"));

                Event event = new Event(
                        rs.getInt("id"),
                        organizer,
                        rs.getNString("fullname"),
                        rs.getNString("description"),
                        new Category(
                                rs.getInt("id"),
                                rs.getNString("categoryName")
                        // rs.getNString("description")
                        ),
                        new Location(
                                rs.getInt("id"),
                                rs.getNString("locationName")),
                        rs.getDate("dateOfEvent").toLocalDate(),
                        rs.getTimestamp("startTime").toLocalDateTime().toLocalTime(),
                        rs.getTimestamp("endTime").toLocalDateTime().toLocalTime(),
                        rs.getInt("guestRegisterLimit"),
                        rs.getDate("guestRegisterDeadline").toLocalDate()
                // rs.getInt("guestAttendedCount")
                );
                event.setImages(images);
                int registeredCount = rs.getInt("guestRegisterCount");
                event.setGuestRegisterCount(registeredCount);
                boolean isFollowing = rs.getBoolean("isFollowing");

                Object[] data = new Object[]{isFollowing, event};

                datas.add(data);
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        page.setDatas(datas);

        return page;
    }

    private String buildSelectQuery(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria) {
        StringBuilder query = new StringBuilder(SELECT_EVENTS_FOLLOWED_AND_NOT_FOLLOWED);
        boolean isWhereInserted = false;
        
        if (!searchEventCriteria.isEmpty()) {
            if (searchEventCriteria.getName() != null && !searchEventCriteria.getName().isBlank()) {
                query.append("\nWHERE LOWER(e.fullname) LIKE LOWER('%");
                query.append(searchEventCriteria.getName());
                query.append("%')\n ");
                isWhereInserted = true;
            }
            
            if (searchEventCriteria.getCategoryId() != null) {
                if(isWhereInserted){
                    query.append(" AND ");
                }else{
                    query.append("\nWHERE ");
                    isWhereInserted = true;
                }
                query.append("e.categoryId=");
                query.append(searchEventCriteria.getCategoryId());
            }
            
            if (searchEventCriteria.getOrganizerId() != null) {
                if(isWhereInserted){
                    query.append("\nAND ");
                }else{
                    query.append("\nWHERE ");
                    isWhereInserted = true;
                }
                query.append("e.organizerId=");
                query.append(searchEventCriteria.getOrganizerId());
            }
            if (searchEventCriteria.getFrom() != null && searchEventCriteria.getTo() != null) {
                if(isWhereInserted){
                    query.append("\nAND ");
                }else{
                    query.append("\nWHERE ");
                    isWhereInserted = true;
                }
                query.append("e.dateOfEvent BETWEEN '");
                query.append(searchEventCriteria.getFrom());
                query.append("' AND '");
                query.append(searchEventCriteria.getTo());
                query.append("'");
            }
        }
        if (isWhereInserted) {
            query.append(" AND ");
        } else {
            query.append(" WHERE ");
        }
        query.append("\n e.dateOfEvent > CAST(GETDATE() AS DATE) AND e.status='APPROVED'");

        query.append("\n ORDER BY f.organizerId DESC, ");

        if (EventOrderBy.DATE_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" dateOfEvent ASC");
        } else if (EventOrderBy.FULLNAME_DESC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" e.fullname DESC");
        } else if (EventOrderBy.FULLNAME_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" e.fullname ASC");
        } else {
            query.append(" dateOfEvent DESC");
        }

        if (!pagingCriteria.isEmpty()) {
            query.append(" OFFSET ");
            query.append(pagingCriteria.getOffset());
            query.append(" ROWS\n FETCH NEXT ");
            query.append(pagingCriteria.getFetchNext());
            query.append(" ROWS ONLY");
        }

        return query.toString();
    }

    public Event getEventDetails(int eventId) {
        Event event = null;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_EVENT_DETAILS_BY_ID, eventId)) {
            if (rs != null && rs.next()) {
                event = new Event();
                event.setId(rs.getInt("id"));
                Organizer organizer = new Organizer(
                        rs.getInt("organizerId"),
                        rs.getString("organizerName"),
                        rs.getString("organizerAvatarPath"));
                event.setOrganizer(organizer);
                event.setFullname(rs.getString("eventName"));
                event.setDescription(rs.getString("description"));
                Category category = new Category(rs.getString("categoryName"));
                event.setGuestAttendedCount(rs.getInt("guestAttendedCount"));
                event.setCategory(category);
                Location location = new Location(rs.getString("locationName"));

                event.setLocation(location);
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                event.setGuestRegisterCount(rs.getInt("guestRegisterCount"));
                event.setCollaboratorRegisterLimit(rs.getInt("collaboratorRegisterLimit"));
                event.setCollaboratorRegisterDeadline(rs.getDate("collaboratorRegisterDeadline").toLocalDate());
                event.setCollaboratorRegisterCount(rs.getInt("collaboratorRegisterCount"));
                event.setImages(getEventImages(eventId));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return event;
    }

    public List<String> getEventImages(int eventId) {
        List<String> images = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_IMG_BY_ID, eventId);) {
            while (rs.next()) {
                images.add(rs.getString("path"));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return images;
    }

    /**
     *
     * @author TuDK
     */
    public List<Event> getRecentEvents(int organizerId) {
        List<Event> events = new ArrayList<>();
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            ResultSet rs = executeQueryPreparedStatement(conn, SELECT_RECENTLY_EVENT_BY_ID, organizerId);

            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTimestamp("startTime").toLocalDateTime().toLocalTime());
                event.setEndTime(rs.getTimestamp("endTime").toLocalDateTime().toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getTimestamp("guestRegisterDeadline").toLocalDateTime().toLocalDate());
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));
                event.setOrganizer(organizer);

                Category category = new Category();
                category.setId(rs.getInt("categoryId"));
                category.setName(rs.getString("categoryName"));
                category.setDescription(rs.getString("categoryDescription"));
                event.setCategory(category);

                Location location = new Location();
                location.setId(rs.getInt("locationId"));
                location.setName(rs.getString("locationName"));
                event.setLocation(location);
                List<String> images = new ArrayList<>();
                images.add(rs.getNString("avatarPath"));
                event.setImages(images);

                events.add(event);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return events;
    }

    /**
     *
     * @author HungHV
     */
    public List<Location> getAllLocations() {
        List<Location> locations = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_ALL_LOCATIONS);) {
            while (rs.next()) {
                locations.add(
                        new Location(
                                rs.getInt("id"),
                                rs.getNString("locationName")
                        )
                );
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }

        return locations;
    }

    /**
     * When club use this for registration, init event status is Status.PENDING
     * Admin event status is Status.APPROVED by default
     *
     * @author HungHV
     */
    public int insertAndGetGenerateKeyOfNewEvent(Event registerEvent) throws SQLException {
        int generatedId = 0;

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            PreparedStatement pstmt = getPreparedStatement(conn.prepareStatement(INSERT_NEW_EVENT, Statement.RETURN_GENERATED_KEYS), conn, INSERT_NEW_EVENT, 
                registerEvent.getOrganizer().getId(),
                registerEvent.getFullname(),
                registerEvent.getImages().get(0),
                registerEvent.getDescription(),
                registerEvent.getCategory().getId(),
                registerEvent.getLocation().getId(),
                registerEvent.getDateOfEvent(),
                registerEvent.getStartTime(),
                registerEvent.getEndTime(),
                registerEvent.getGuestRegisterLimit(),
                registerEvent.getCollaboratorRegisterLimit(),
                registerEvent.getGuestRegisterDeadline(),
                registerEvent.getCollaboratorRegisterDeadline(),
                (registerEvent.getOrganizer().getRole() == Role.ADMIN ? EventStatus.APPROVED : EventStatus.PENDING).toString());
            int rowChange = pstmt.executeUpdate();

            if (rowChange > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            throw e;
        }

        return generatedId;
    }

    public int[] getTotalStatisticNumberOfEvent(int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, SELECT_STATISTIC_NUMBER_OF_EVENT, eventId)) {
            while (rs.next()) {
                int totalRegister = rs.getInt("TotalRegister");
                int totalAttended = rs.getInt("TotalAttended");
                int totalCollaborator = rs.getInt("TotalCollaborator");
                int totalCancel = rs.getInt("TotalCancel");

                int[] statisticNumber = {totalRegister, totalAttended, totalCollaborator, totalCancel};
                return statisticNumber;
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateEventDetails(Event event) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            // Cập nhật thông tin sự kiện
            executeUpdatePreparedStatement(conn, UPDATE_EVENT_BY_ID,
                    event.getFullname(),
                    event.getDescription(),
                    event.getCategory().getId(),
                    event.getLocation().getId(),
                    event.getDateOfEvent(),
                    event.getStartTime(),
                    event.getEndTime(),
                    event.getGuestRegisterLimit(),
                    event.getGuestRegisterDeadline(),
                    event.getCollaboratorRegisterLimit(),
                    event.getCollaboratorRegisterDeadline(),
                    (event.getImages().isEmpty() ? null : event.getImages().get(0)), // Cập nhật avatarPath
                    event.getId());

            // Cập nhật ảnh cho sự kiện
            updateEventImages(event.getId(), event.getImages());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating event details", e);
        }
    }

    public String getEventStatus(int eventId) {
        String status = null;
        String query = "SELECT status FROM event WHERE id = ?";

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                status = rs.getString("status");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving event status", e);
        }

        return status;
    }

    public void updateEventImages(int eventId, List<String> imagePaths) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            String sql = "INSERT INTO EventImage (eventId, path) VALUES (?, ?)";

            for (int i = 1; i < imagePaths.size(); i++) {
                executeUpdatePreparedStatement(conn, sql, eventId, imagePaths.get(i));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating event images", e);
        }
    }

    public void deleteEventImages(int eventId) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            String sql = "DELETE FROM EventImage WHERE eventId = ?";
            executeUpdatePreparedStatement(conn, sql, eventId); // Xóa tất cả ảnh của sự kiện
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting event images", e);
        }
    }

    public Event getEventById(int eventId) {
        Event event = null;
        // Thực hiện truy vấn SQL để lấy sự kiện dựa trên eventId
        String query = "SELECT Event.*, Location.locationName AS LocationName FROM [event] JOIN [Location] ON Event.locationId = Location.id WHERE Event.id = ?";
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                // Tạo đối tượng Event từ kết quả truy vấn
                event = new Event();
                event.setId(rs.getInt("id"));
                event.setFullname(rs.getString("fullname"));
                event.setDescription(rs.getString("description"));
                event.setCategory(new Category(rs.getInt("categoryId"))); // Giả sử có setter cho Category
                event.setLocation(new Location(
                        rs.getInt("locationId"),
                        rs.getNString("locationName")
                )); // Giả sử có setter cho Location
                event.setDateOfEvent(rs.getDate("dateOfEvent").toLocalDate());
                event.setStartTime(rs.getTime("startTime").toLocalTime());
                event.setEndTime(rs.getTime("endTime").toLocalTime());
                event.setGuestRegisterLimit(rs.getInt("guestRegisterLimit"));
                event.setRegisterDeadline(rs.getDate("guestRegisterDeadline").toLocalDate());
                event.setCollaboratorRegisterLimit(rs.getInt("collaboratorRegisterLimit"));
                event.setCollaboratorRegisterDeadline(rs.getDate("collaboratorRegisterDeadline").toLocalDate());
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        return event;
    }

    public Page<Object[]> getForGuest(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria) {
        Page<Object[]> page = new Page<>();
        ArrayList<Object[]> datas = new ArrayList<>();
        String query = buildSelectQueryForGuest(pagingCriteria, searchEventCriteria);

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet rs = executeQueryPreparedStatement(conn, query);) {
            while (rs.next()) {
                if (page.getTotalPage() == null && page.getCurrentPage() == null) {
                    page.setTotalPage((int) Math.ceil(rs.getInt("TotalRow") / pagingCriteria.getFetchNext()));
                    page.setCurrentPage(pagingCriteria.getOffset() / pagingCriteria.getFetchNext());
                }
                Organizer organizer = new Organizer();
                organizer.setId(rs.getInt("organizerId"));
                organizer.setFullname(rs.getString("organizerName"));

                List<String> images = new ArrayList<>();
                images.add(rs.getNString("avatarPath"));

                Event event = new Event(
                        rs.getInt("id"),
                        organizer,
                        rs.getNString("fullname"),
                        rs.getNString("description"),
                        new Category(
                                rs.getInt("id"),
                                rs.getNString("categoryName")
                        // rs.getNString("description")
                        ),
                        new Location(
                                rs.getInt("id"),
                                rs.getNString("locationName")),
                        rs.getDate("dateOfEvent").toLocalDate(),
                        rs.getTimestamp("startTime").toLocalDateTime().toLocalTime(),
                        rs.getTimestamp("endTime").toLocalDateTime().toLocalTime(),
                        rs.getInt("guestRegisterLimit"),
                        rs.getDate("guestRegisterDeadline").toLocalDate()
                // rs.getInt("guestAttendedCount")
                );
                event.setImages(images);
                int registeredCount = rs.getInt("guestRegisterCount");
                event.setGuestRegisterCount(registeredCount);

                Object[] data = new Object[]{false, event};
                datas.add(data);
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        page.setDatas(datas);

        return page;
    }

    private String buildSelectQueryForGuest(PagingCriteria pagingCriteria, SearchEventCriteria searchEventCriteria) {
        StringBuilder query = new StringBuilder(SELECT_EVENTS_FOR_GUEST);
        boolean isWhereInserted = false;
        
        if (!searchEventCriteria.isEmpty()) {
            if (searchEventCriteria.getName() != null && !searchEventCriteria.getName().isBlank()) {
                query.append("\nWHERE LOWER(e.fullname) LIKE LOWER('%");
                query.append(searchEventCriteria.getName());
                query.append("%')\n ");
                isWhereInserted = true;
            }
            
            if (searchEventCriteria.getCategoryId() != null) {
                if (isWhereInserted){
                    query.append(" AND ");
                } else {
                    query.append("\nWHERE ");
                    isWhereInserted = true;
                }
                query.append("e.categoryId=");
                query.append(searchEventCriteria.getCategoryId());
                
            }
            
            if (searchEventCriteria.getOrganizerId() != null) {
                if(isWhereInserted){
                    query.append("\nAND ");
                }else{
                    query.append("\nWHERE ");
                    isWhereInserted = true;
                }
                query.append("e.organizerId=");
                query.append(searchEventCriteria.getOrganizerId());
            }
            if (searchEventCriteria.getFrom() != null && searchEventCriteria.getTo() != null) {
                if(isWhereInserted){
                    query.append("\nAND ");
                }else{
                    query.append("\nWHERE ");
                    isWhereInserted = true;
                }
                query.append("e.dateOfEvent BETWEEN '");
                query.append(searchEventCriteria.getFrom());
                query.append("' AND '");
                query.append(searchEventCriteria.getTo());
                query.append("'");
            }
        }
        
        if (isWhereInserted) {
            query.append("\nAND ");
        } else {
            query.append("\nWHERE ");
        }
        query.append("\n e.dateOfEvent > CAST(GETDATE() AS DATE) AND e.status='APPROVED'");

        if (EventOrderBy.DATE_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append("\n ORDER BY dateOfEvent ASC");
        } else if (EventOrderBy.FULLNAME_DESC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" e.fullname DESC");
        } else if (EventOrderBy.FULLNAME_ASC.equals(searchEventCriteria.getOrderBy())) {
            query.append(" e.fullname ASC");
        } else {
            query.append("\n ORDER BY dateOfEvent DESC");
        }

        if (!pagingCriteria.isEmpty()) {
            query.append("\n OFFSET ");
            query.append(pagingCriteria.getOffset());
            query.append(" ROWS\n FETCH NEXT ");
            query.append(pagingCriteria.getFetchNext());
            query.append(" ROWS ONLY");
        }
        return query.toString();
    }
    
    /**
     * 
     * @author HungHV 
     */
    public int getAttendedCount(int eventId) {
        int count = 0;
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, GET_ATTENDED_COUNT_BY_EVENT_ID, eventId)) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        
        return count;
    }
    
    /**
     * 
     * @author HungHV
     */
    public boolean changeEventStatus(int eventId, EventStatus status) {
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
            executeUpdatePreparedStatement(conn, UPDATE_STATUS_BY_EVENT_ID, status, eventId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        
        return true;
    }
    
    /**
     * 
     * @author HungHV 
     */
    public String getEventNameById(int eventId) {
        String name = "";
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet rs = executeQueryPreparedStatement(conn, SELECT_EVENT_NAME_BY_EVENT_ID, eventId)) {
            if (rs.next()) {
                name = rs.getNString(1);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, null, e);
        }
        
        return name;
    }
}
