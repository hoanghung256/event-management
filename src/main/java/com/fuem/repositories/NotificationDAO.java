/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories;

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

    public List<Notification> getNotificationsForUser(int userId) {
        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT n.id, n.senderId, n.content, n.sendingTime, o.acronym AS senderName "
                + "FROM Notification n "
                + "JOIN NotificationReceiver nr ON n.id = nr.notificationId "
                + "JOIN Organizer o ON n.senderId = o.id "
                + "WHERE nr.receiverId = ?";
        
        try (Connection conn = DataSourceWrapper.getDataSource().getConnection();
                ResultSet resultSet = executeQueryPreparedStatement(conn, sql, userId);){
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
