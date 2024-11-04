<%-- 
    Document   : club-view-feedback
    Created on : Oct 11, 2024, 9:47:28?AM
    Author     : Administrator
--%>

<%@ page import="java.util.List" %>

<%@include file="../include/club-layout-header.jsp"%>
<section>
    <div class="app__slide-wrapper">
        <div class="row">
            <div class="col-xl-12">
                <div class="breadcrumb__wrapper mb-35">
                    <div class="breadcrumb__inner">
                        <div class="breadcrumb__icon">
                            <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                            <nav>
                                <ul>
                                    <li><span><a href="<c:url value="/club/dashboard" />">Dashboard</a></span></li>
                                    <li><span><a href="<c:url value="/club/organized-event" />">Organized Events</a></span></li>
                                    <li class="active"><span>Event Feedback</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-7">
                <c:if test="${not empty feedbackList}">
                    <c:forEach var="feedback" items="${feedbackList}">
                        <div class="body__card-wrapper  p-2 mt-0 mb-3 m-3 " >
                            <div class="col-md-12">
                                <div class="review__item ml-10 ">
                                    <div class="review__item-inner">
                                        <div class="review__item-thumb user__portfolio-thumb" >
                                            <img src="<c:url value="${feedback.guest.avatarPath}" />" alt="Student Avatar">
                                        </div>
                                        <div class="review__item-content">
                                            <h5>
                                                <a href="<c:url value="/profile?role=student&id=${feedback.guest.id}" />">
                                                    ${feedback.guest.fullname}
                                                </a>
                                            </h5> 
                                        </div>
                                    </div>
                                    <p class="mt-2">${feedback.content}</p> 
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty feedbackList}">
                    <p>There is no feedback for this event.</p>
                </c:if>
            </div>
            <div class="col-md-5">
                <div class="card__wrapper p-4 pb-2">
                    <div class="card__header">
                        <div class="card__header-top mb-5">
                            <div class="card__title-inner">
                                <div class="card__header-title">
                                    <h3>Event Feedback</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="event__meta-time">
                        <ul>
                            <li class="pb-2">
                                <span>Event Name: </span>
                                <i>${event.fullname}</i>
                            </li>
                            <li class="pb-2">
                                <span>Date: </span>
                                <i id="date">${event.dateOfEvent}</i>
                            </li>
                            <li class="pb-2">
                                <span>Time: </span>

                                <i id="time">${event.startTime}</i> - <i id="time">${event.endTime}</i> 
                            </li>

                            <li class="pb-2">
                                <span>Venue: </span>
                                ${event.location.name}
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="../include/master-footer.jsp" %>
