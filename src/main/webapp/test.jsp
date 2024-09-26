<%-- 
    Document   : test
    Created on : Sep 18, 2024, 10:31:21 PM
    Author     : hoang hung 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Email not exist</h1>
        
        <c:forEach var="s" items="${names}">
            <div>${s}</div>
        </c:forEach>
    </body>
</html>
