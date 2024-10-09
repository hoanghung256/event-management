/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.listeners;

import com.fuem.repositories.SQLDatabase;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author hoang hung
 */
@WebListener
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Web server started!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Web server stopped!");
    }
}
