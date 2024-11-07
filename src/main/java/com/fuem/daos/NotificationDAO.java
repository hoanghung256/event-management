/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos;

/**
 *
 * @author This PC
 */
import com.fuem.models.Notification;
import com.fuem.models.Organizer;
import com.fuem.utils.DataSourceWrapper;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NotificationDAO extends SQLDatabase {

    public NotificationDAO() {
        super();
    }

    private static String SELECT_NOTIFICATION_FOR_USER = "SELECT TOP 10 \n"
            + "    Notification.id, \n"
            + "    Notification.senderId, \n"
            + "    Notification.content, \n"
            + "    Notification.sendingTime, \n"
            + "    Organizer.acronym AS senderName\n"
            + "FROM \n"
            + "    Notification\n"
            + "JOIN \n"
            + "    NotificationReceiver ON Notification.id = NotificationReceiver.notificationId\n"
            + "JOIN \n"
            + "    Organizer ON Notification.senderId = Organizer.id\n"
            + "WHERE \n"
            + "    NotificationReceiver.receiverId = ? \n"
            + "    AND NotificationReceiver.isOrganizer = 0\n"
            + "ORDER BY \n"
            + "    Notification.sendingTime DESC;";

    private static String SELECT_NOTIFICATION_FOR_ORGANIZER = "SELECT TOP 10 \n"
            + "    Notification.id, \n"
            + "    Notification.senderId, \n"
            + "    Notification.content, \n"
            + "    Notification.sendingTime, \n"
            + "    Organizer.acronym AS senderName\n"
            + "FROM \n"
            + "    Notification\n"
            + "JOIN \n"
            + "    NotificationReceiver ON Notification.id = NotificationReceiver.notificationId\n"
            + "JOIN \n"
            + "    Organizer ON Notification.senderId = Organizer.id\n"
            + "WHERE \n"
            + "    NotificationReceiver.receiverId = ? \n"
            + "    AND NotificationReceiver.isOrganizer = 1\n"
            + "ORDER BY \n"
            + "    Notification.sendingTime DESC;";

    private static String INSERT_NEW_NOTIFICATION = "INSERT INTO [Notification] (senderId, content) "
            + "VALUES (?, ?)";

    private static String INSERT_NOTIFICATION_RECEIVER = "INSERT INTO NotificationReceiver (notificationId, receiverId, isOrganizer) "
            + "SELECT DISTINCT ?, guestId, 0 "
            + "FROM EventGuest "
            + "WHERE eventId IN (";

    private static String INSERT_NOTIFICATION_RECEIVER_AS_ALL_STUDENT = "INSERT INTO NotificationReceiver (notificationId, receiverId, isOrganizer) "
            + "SELECT ?, id, 0 "
            + "FROM Student";

    private static String INSERT_NOTIFICATION_RECEIVER_AS_ALL_CLUB = "INSERT INTO NotificationReceiver (notificationId, receiverId, isOrganizer) "
            + "SELECT ?, id, 1 "
            + "FROM Organizer "
            + "WHERE isAdmin = 0";

    public List<Notification> getNotificationsForUser(int userId) {
        List<Notification> notifications = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet resultSet = executeQueryPreparedStatement(conn, SELECT_NOTIFICATION_FOR_USER, userId);) {
            while (resultSet.next()) {
                int id = resultSet.getInt("id");

                int senderId = resultSet.getInt("senderId");
                String senderAcronym = resultSet.getString("senderName");
                Organizer sender = new Organizer(senderId, senderAcronym);
                String content = resultSet.getString("content");
                LocalDateTime sendingTime = resultSet.getTimestamp("sendingTime").toLocalDateTime();

                Notification notification = new Notification(id, sender, content, sendingTime);
                notifications.add(notification);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return notifications;
    }

    /**
     *
     * @author AnhNQ Insert and return the id of new notification
     */
    public int insertAndGetIdOfNewNotification(int senderId, String content) {
        int generatedId = -1;
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); PreparedStatement pstmt = conn.prepareStatement(INSERT_NEW_NOTIFICATION, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, senderId);
            pstmt.setString(2, content);
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedId = generatedKeys.getInt(1); // Lấy ID vừa chèn
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return generatedId;
    }

    /**
     * Insert notiId and receiverId into Notification Receiver table
     *
     * @author AnhNQ
     */
    public int insertIntoNotificationReceiver(String[] eventIds, int notificationId) throws SQLException {
        int res = 0;
        if (notificationId > 0 && eventIds.length != 0) {
            try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
                res = executeUpdatePreparedStatement(conn, buildInsertQuery(eventIds), notificationId);
            } catch (SQLException ex) {
                Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return res;
    }

    /**
     *
     * @author AnhNQ
     */
    private String buildInsertQuery(String[] eventIds) {
        StringBuilder sb = new StringBuilder(INSERT_NOTIFICATION_RECEIVER);
        for (int i = 0; i < eventIds.length; i++) {
            sb.append(eventIds[i]);
            if (i == eventIds.length - 1) {
                sb.append(");");
            } else {
                sb.append(", ");
            }
        }
        
        return sb.toString();
    }

    /**
     *
     * @author AnhNQ
     */
    public int insertNotificationReceiverForAllStudent(int notificationId) throws SQLException {
        int res = 0;
        if (notificationId > 0) {
            try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
                res = executeUpdatePreparedStatement(conn, INSERT_NOTIFICATION_RECEIVER_AS_ALL_STUDENT, notificationId);
            } catch (SQLException ex) {
                Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return res;
    }

    /**
     *
     * @author AnhNQ
     */
    public int insertNotificationReceiverForAllClub(int notificationId) throws SQLException {
        int res = 0;
        if (notificationId > 0) {
            try (Connection conn = DataSourceWrapper.getDataSource().getConnection();) {
                res = executeUpdatePreparedStatement(conn, INSERT_NOTIFICATION_RECEIVER_AS_ALL_CLUB, notificationId);
            } catch (SQLException ex) {
                Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return res;
    }
    
    public ArrayList<Notification> getNotificationsForOrganizer(int userId) {
        ArrayList<Notification> notifications = new ArrayList<>();

        try (Connection conn = DataSourceWrapper.getDataSource().getConnection(); ResultSet resultSet = executeQueryPreparedStatement(conn, SELECT_NOTIFICATION_FOR_ORGANIZER, userId);) {
            while (resultSet.next()) {
                int id = resultSet.getInt("id");

                int senderId = resultSet.getInt("senderId");
                String senderAcronym = resultSet.getString("senderName");
                Organizer sender = new Organizer(senderId, senderAcronym);
                String content = resultSet.getString("content");
                LocalDateTime sendingTime = resultSet.getTimestamp("sendingTime").toLocalDateTime();

                Notification notification = new Notification(id, sender, content, sendingTime);
                notifications.add(notification);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return notifications;
    }
}
