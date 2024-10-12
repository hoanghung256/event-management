<%-- 
    Document   : view-feedback
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
                                    <li><span><a href="dashboard.html">Home</a></span></li>
                                    <li class="active"><span>Event Feedback</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xxl-12">
                <div class="card__wrapper">
                    <div class="card__header">
                        <div class="card__header-top mb-5">
                            <div class="card__title-inner">
                                <div class="card__header-title">
                                    <h3>Event Feedback List</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="event__meta-time">
                        <ul>
                            <li>
                                <span>Event Name: </span>
                                <i >${event.fullname}</i>
                            </li>
                            <li>
                                <span>Date: </span>
                                <i id="date">${event.dateOfEvent}</i>
                            </li>
                            <li>
                                <span>Time: </span>

                                <i id="time">${event.startTime}</i> - <i id="time">${event.endTime}</i> 
                            </li>
                            
                            <li>
                                <span>Venue: </span>
                                ${event.location.name}
                            </li>
                            <li>
                                <span>Registered: </span>
                                ${event.guestRegisterCount} / ${event.guestRegisterLimit}
                            </li>
                            <li>
                                <span>Attended: </span>
                                ${event.guestAttendedCount}
                            </li>
                        </ul>
                       
                    </div>
                </div>
            </div>
            
                    <c:if test="${not empty feedbackList}">
                        <c:forEach var="feedback" items="${feedbackList}">
                            <div class="body__card-wrapper pb-4 pl-4 pr-4 pt-1 mb-5" >
                <div class="col-md-12">
                            <div class="review__item mt-35">
                                <div class="review__item-inner">
                                    <div class="review__item-thumb">
                                        <img src="../assets/img/user/default-avatar.jpg" alt="image not found">
                                    </div>
                                    <div class="review__item-content">
                                        <h4>${feedback.fullname}</h4> 
                                    </div>
                                </div>
                                <p>${feedback.content}</p> 
                            </div>
                </div>
            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty feedbackList}">
                        <p>There is no feedback for this event.</p>
                    </c:if>
                

        </div>
    </div>
</section>
<%@include file="../include/master-footer.jsp" %>
