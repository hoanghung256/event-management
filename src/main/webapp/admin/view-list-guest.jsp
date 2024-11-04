<!DOCTYPE html>
<%@include file="../include/admin-layout-header.jsp"%>

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
                                    <li><span><a href="<c:url value='/admin/dashboard'/>">Dashboard</a></span></li>
                                    <li class="active"><span>View list guest</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-wrapper"> 
            <div class="card__header">
                <div class="card__header-top mb-5">
                    <div class="card__title-inner">
                        <div class="card__header-icon">
                            <i class="flaticon-ticket-1"></i>
                        </div>
                        <div class="card__header-title">
                            <h4>Registered Event List</h4>
                        </div>
                    </div>
                </div>
            </div>

            <div class="pb-20">
                <div>
                    <div id="myTabContent">
                        <div role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                            <div class="body__card-wrapper">
                                <div class="attendant__wrapper mb-35">
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger">
                                            ${errorMessage}
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty page.datas}">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Guest Name</th>
                                                    <th>Student ID</th>
                                                    <th>Email</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:set var="i" value="1" />
                                                <c:forEach var="guest" items="${page.datas}">
                                                    <tr>
                                                        <td>
                                                            <div class="attendant__user-item">
                                                                <span>${i}</span>
                                                                <c:set var="i" value="${i + 1}" />
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__user-title">
                                                                <span>${guest.fullname}</span> 
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__user-item">
                                                                <span>${guest.studentId}</span> 
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <span>${guest.email}</span> 
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>

                                <!-- Pagination controls -->
                                <div class="basic__pagination d-flex align-items-center justify-content-end">
                                    <nav>
                                        <ul>
                                            <c:forEach var="i" begin="0" end="${page.totalPage}">
                                                <c:choose>
                                                    <c:when test="${i == 0 && page.currentPage > 0}">
                                                        <li>
                                                            <a href="view-list-guest?page=${page.currentPage - 1}&eventId=${eventId}">
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
                                                                    <a href="view-list-guest?page=${i}&eventId=${eventId}">${i + 1}</a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                                        <li> ... </li>
                                                        </c:when>
                                                        <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                                        <li>
                                                            <a href="view-list-guest?page=${page.totalPage - 1}&eventId=${eventId}">
                                                                ${page.totalPage}
                                                            </a>
                                                        </li>
                                                    </c:when>
                                                    <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                                        <li>
                                                            <a href="view-list-guest?page=${page.currentPage + 1}&eventId=${eventId}">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

<%@include file="../include/master-footer.jsp" %>