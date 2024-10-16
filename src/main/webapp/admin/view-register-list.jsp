<%-- 
    Document   : view-register-list
    Created on : Oct 14, 2024, 6:14:04 PM
    Author     : ADMIN
--%>


<!DOCTYPE html>
<%@include file="../include/admin-layout-header.jsp"%>
<style>
      
        header {
            font-family: 'Roboto', sans-serif; /* Font ch? ??p */
            font-weight: bold; /* In ??m */
            font-size: 2em; /* Kích th??c ch? */
            color: #000000; /* Màu ch? c? b?n (?en) */
            text-align: center; /* C?n gi?a */
            margin-bottom: 10px; /* Kho?ng cách phía d??i */
            padding: 5px; /* Padding xung quanh */
            background-color: transparent; /* N?n trong su?t */
        }
     
    </style>
<section>
    <div class="app__slide-wrapper">
        <div class="breadcrumb__area">
            <div class="breadcrumb__wrapper mb-35">
                <div class="breadcrumb__main">
                    <div class="breadcrumb__inner">
                        <div class="breadcrumb__icon">
                            <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                            <nav>
                                <ul>
                                    <li><span><a href="<c:url value="/admin/dashboard"/>">Dashboard</a></span></li>
                                    <li class="active"><span>Registerd Event List</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

       
        <header>Registered Event List</header>
        <div class="pb-20">
            <div class="">
                <div class="" id="myTabContent">
                    <div class="" id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                        <div class="body__card-wrapper">
                            <div class="attendant__wrapper mb-35">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Guest Name</th>
                                            <th>Student ID </th>
                                            <th>Event ID</th>
                                            <th>Event Name</th>
                                            <th>Event Date</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="i" value="${1}" />

                                        <c:forEach var="guest" items="${registeredGuestsList.datas}">
                                            <tr>
                                                <td>
                                                    <div class="attendant__user-item">
                                                        <span>${i}</span>
                                                        <c:set var="i" value="${i+1}" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__user-title">
                                                        <span>${guest.student.fullname}</span> <!-- Tên ??y ?? c?a sinh viên -->
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__user-item">
                                                        <span>${guest.student.studentId}</span> <!-- ID c?a sinh viên -->
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__seminar">
                                                        <span>${guest.event.id}</span> <!-- ID c?a s? ki?n -->
                                                    </div>
                                                </td>

                                                <td>
                                                    <div class="attendant__seminar">
                                                        <span>${guest.event.fullname}</span> <!-- Tên s? ki?n -->
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__date">
                                                        <span>${guest.event.dateOfEvent}</span> <!-- Ngày di?n ra s? ki?n -->
                                                    </div>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Pagination controls -->
        <div class="basic__pagination d-flex align-items-center justify-content-end">
            <nav>
                <ul>
                    <c:forEach var="i" begin="0" end="${page.totalPage}">
                        <c:choose>
                            <c:when test="${i == 0 && page.currentPage > 0}">
                                <li>
                                    <a href="view-register-list?page=${page.currentPage - 1}">
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
                                            <a href="view-register-list?page=${i}">${i + 1}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                <li> ... </li>
                                </c:when>
                                <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                <li>
                                    <a href="view-register-list?page=${page.totalPage - 1}">
                                        ${page.totalPage}
                                    </a>
                                </li>
                            </c:when>
                            <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                <li>
                                    <a href="view-register-list?page=${page.currentPage + 1}">
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


</section>

<%@include file="../include/master-footer.jsp" %>
