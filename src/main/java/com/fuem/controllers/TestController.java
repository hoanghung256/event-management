/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.controllers;

import java.io.IOException;

import com.fuem.repositories.TestRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hoang hung
 */
@WebServlet(name = "TestController", urlPatterns = "/test")
public class TestController extends HttpServlet {

    private TestRepository testRepository = new TestRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ArrayList<String> result = testRepository.get();

        // System.out.println(result.size());

        // req.setAttribute("names", result);
        // req.getRequestDispatcher("test.jsp").forward(req, resp);
    }
}
