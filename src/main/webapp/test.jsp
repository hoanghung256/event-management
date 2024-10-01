<%-- 
    Document   : test
    Created on : Sep 18, 2024, 10:31:21 PM
    Author     : hoang hung 
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Event List</title>
        <link rel="stylesheet" href="assets/app/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/app/css/meanmenu.min.css">
        <link rel="stylesheet" href="assets/app/css/animate.css">
        <link rel="stylesheet" href="assets/app/css/metisMenu.min.css">
        <link rel="stylesheet" href="assets/app/css/swiper-bundle.min.css">
        <link rel="stylesheet" href="assets/app/css/slick.css">
        <link rel="stylesheet" href="assets/app/css/backtotop.css">
        <link rel="stylesheet" href="assets/app/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/app/css/flaticon_expovent.css">
        <link rel="stylesheet" href="assets/app/css/fontawesome-pro.css">
        <link rel="stylesheet" href="assets/app/css/spacing.css">
        <link rel="stylesheet" href="assets/app/css/main.css">
    </head>
    <body>

        <h2>Event List</h2>

        <form action="test" method="GET">
            <label>Event name: </label>
            <input type="text" name="name" value="${previousSearchEventCriteria.name}">
            
            <label>Choose event type:</label>

            <select name="typeId">
                <option value="1" ${previousSearchEventCriteria.typeId == 1 ? "selected" : ""}>Workshop</option>
                <option value="2" ${previousSearchEventCriteria.typeId == 2 ? "selected" : ""}>Seminar</option>
                <option value="3" ${previousSearchEventCriteria.typeId == 3 ? "selected" : ""}>Club Meeting</option>
            </select>

            <label>Choose event organization:</label>

            <select name="organizerId">
                <option value="1" ${previousSearchEventCriteria.organizerId == 1 ? "selected" : ""}>ICPDP Department</option>
                <option value="2" ${previousSearchEventCriteria.organizerId == 2 ? "selected" : ""}>FU - Dever</option>
                <option value="3" ${previousSearchEventCriteria.organizerId == 3 ? "selected" : ""}>TIA - Traditional Instrument Abide Club</option>
            </select>
            
            <br>
            
            <label>From:</label>
            <input type="date" name="from" value="${previousSearchEventCriteria.from}">
            
            <label>To:</label>
            <input type="date" name="to" value="${previousSearchEventCriteria.to}">
            
            <select name="orderBy">
                <option value="FULLNAME_ASC" ${previousSearchEventCriteria.orderBy == "FULLNAME_ASC" ? "selected" : ""}>Name A-Z</option>
                <option value="FULLNAME_DESC" ${previousSearchEventCriteria.orderBy == "FULLNAME_DESC" ? "selected" : ""}>Name Z-A</option>
                <option value="DATE_ASC" ${previousSearchEventCriteria.orderBy == "DATE_ASC" ? "selected" : ""}>Most recent</option>
                <option value="DATE_DESC" ${previousSearchEventCriteria.orderBy == "DATE_DESC" ? "selected" : ""}>Oldest</option>
            </select>
            
            <input type="submit" placeholder="Find">
        </form>

        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Host</th>
                    <th>Fullname</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Date of event</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="event" items="${page.datas}">
                    <tr>
                        <td>${event.id}</td>
                        <td>${event.organizerId}</td>
                        <td>${event.fullname}</td>
                        <td>${event.type.id}</td>
                        <td>${event.description}</td>
                        <td>${event.dateOfEvent}</td>
                        <td>${event.startTime}</td>
                        <td>${event.endTime}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination Controls -->
        <div>
            <div class="basic__pagination d-flex align-items-center justify-content-end">
                <nav>
                    <ul>
                        <c:forEach var="i" begin="0" end="${page.totalPage}">
                            <c:choose>
                                <c:when test="${i == 0 && page.currentPage > 0}">
                                    <li>
                                        <a href="test?page=${page.currentPage - 1}&name=${previousSearchEventCriteria.name}&typeId=${previousSearchEventCriteria.typeId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">
                                            <i class="fa-regular fa-arrow-left-long"></i>
                                        </a>
                                    </li>
                                </c:when>
                                <c:when test="${i >= page.currentPage && i <= page.currentPage + 4}">
                                    <c:choose>
                                        <c:when test="${i == page.currentPage}">
                                            <li>
                                                <span class="current">${i + 1}</span>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a href="test?page=${i}&name=${previousSearchEventCriteria.name}&typeId=${previousSearchEventCriteria.typeId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">${i + 1}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                    <li> ... </li>
                                </c:when>
                                <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                    <li>
                                        <a href="test?page=${page.totalPage - 1}&name=${previousSearchEventCriteria.name}&typeId=${previousSearchEventCriteria.typeId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">
                                           ${page.totalPage}
                                        </a>
                                    </li>
                                </c:when>
                                <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                    <li>
                                        <a href="test?page=${page.currentPage + 1}&name=${previousSearchEventCriteria.name}&typeId=${previousSearchEventCriteria.typeId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">
                                            <i class="fa-regular fa-arrow-right-long"></i>
                                        </a>
                                    </li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </nav>
            </div>
        </div>

        <script src="assets/app/js/jquery-3.6.0.min.js"></script>
        <script src="assets/app/js/waypoints.min.js"></script>
        <script src="assets/app/js/bootstrap.bundle.min.js"></script>
        <script src="assets/app/js/apexcharts.min.js"></script>
        <script src="assets/app/js/metisMenu.min.js"></script>
        <script src="assets/app/js/meanmenu.min.js"></script>
        <script src="assets/app/js/swiper-bundle.min.js"></script>
        <script src="assets/app/js/slick.min.js"></script>
        <script src="assets/app/js/magnific-popup.min.js"></script>
        <script src="assets/app/js/backtotop.js"></script>
        <script src="assets/app/js/counterup.js"></script>
        <script src="assets/app/js/wow.min.js"></script>
        <script src="assets/app/js/countdown.js"></script>
        <script src="assets/app/js/smooth-scrollbar.js"></script>
        <script src="assets/app/js/ajax-form.js"></script>
        <script src="assets/app/js/custom.js"></script>
        <script src="assets/app/js/main.js"></script>
    </body>
</html>