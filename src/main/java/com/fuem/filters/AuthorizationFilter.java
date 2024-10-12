/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.filters;

import com.fuem.enums.Role;
import com.fuem.models.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author hoang hung
 */
@WebFilter(
        urlPatterns = {
            "/student/*",
            "/club/*",
            "/admin/*",
            "*.jsp"
        }
)
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        
        User user = (User) request.getSession().getAttribute("userInfor");
//        String url = request.getRequestURI(); (in deployment environment)
        String url = request.getRequestURI().substring(17); // (in development environment)
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/sign-in");
        } else if ((url.startsWith("/club") && user.getRole() != Role.CLUB) 
                || (url.startsWith("/admin") && user.getRole() != Role.ADMIN)
                || (url.startsWith("/student") && user.getRole() != Role.STUDENT)
                || (url.endsWith(".jsp") && !url.startsWith("/error")) ) {
            response.sendRedirect(request.getContextPath() + "/error/403.jsp");
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }
}
