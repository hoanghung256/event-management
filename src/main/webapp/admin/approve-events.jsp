<%-- 
    Document   : approve-events
    Created on : Oct 10, 2024, 10:07:43?AM
    Author     : ThangNM
--%>

<%@include file="../include/admin-layout-header.jsp"%>
<%@ page import="com.fuem.models.Event" %>
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
                                    <li><span><a href="<c:url value="/home"/>">Home</a></span></li>
                                    <li class="active"><span>Event Details</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Bat dau content cua page o day-->
        <div class="pb-20">
            <div>
                <div id="myTabContent">
                    <div id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                        <!-- BODY GO HERE -->
                        <div class="event__details-area">
                            <div class="row">
                                <div class="col-md-7 p-1">
                                    <div class="event__details-left">
                                        <div class="body__card-wrapper mb-20">
                                            <div class="card__header-top">
                                                <div class="card__title-inner">
                                                    <h4 class="event__information-title">${event.fullname}</h4>
                                                </div>
                                            </div>
                                            <div class="review__main-wrapper pt-25">
                                                <div class="review__meta mb-25"></div>
                                                <div class="review__author-meta mb-15">
                                                    <a href="#">
                                                        <div class="review__author-thumb">
                                                            <img src="${event.organizer.avatarPath}" alt="Organizer Avatar" onerror="this.onerror=null; this.src='assets/img/default-avatar.png';">
                                                        </div>
                                                        <div class="review__author-name">
                                                            <a href="club/OrganizerProfileController?organizerId=${event.organizer.id}"style="text-decoration: none; color: inherit;">
                                                                <h4 style="color: inherit; transition: color 0.3s ease;"
                                                                    onmouseover="this.style.color = '#F50963';" 
                                                                    onmouseout="this.style.color = 'inherit';">
                                                                    ${event.organizer.fullname}
                                                                </h4>
                                                            </a>
                                                        </div>
                                                </div>
                                                <div class="review__tab">
                                                    <nav>
                                                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                                            <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">About</button>
                                                        </div>
                                                    </nav>
                                                    <div class="tab-content" id="nav-tabContent">
                                                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                                                            <div class="about__event-thumb w-img mt-40">
                                                                <c:choose>
                                                                    <c:when test="${not empty event.images}">
                                                                        <c:forEach var="image" items="${event.images}">
                                                                            <img src="http://127.0.0.1:5500/muontheme/codeskdhaka.com/html/expovent-prev/expovent/assets/img/event/event-details-2.jpg" alt="Event Image" />
                                                                        </c:forEach>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${pageContext.request.contextPath}/assets/img/event/default-image.jpg" alt="Default Image" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <div class="about__content mt-30">
                                                                <h4>About This Event</h4>
                                                                <p>Hello World</p>
                                                            </div>

                                                            <div class="ticket__purchase-wrapper mt-30">
                                                                <div class="ticket__price-inner">
                                                                    <div class="ticket__price-item">

                                                                    </div>
                                                                    <div class="ticket__price-item">
                                                                        <form action="<c:url value="/admin/approval-events?eventId=${event.id}"/>" method="POST" onsubmit="return confirmAction(event)">
                                                                            <button class="element__btn green-bg" type="submit" value="approve" name="action">Approve</button>
                                                                            <button class="element__btn red-bg" type="submit" value="rejected" name="action">Rejected</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5 p-1">
                                    <div class="event__details-right">
                                        <div class="body__card-wrapper mb-20">
                                            <div class="event__meta-time">
                                                <ul>
                                                    <li>
                                                        <span>Date: </span>
                                                        <i id="date">${event.dateOfEvent}</i>
                                                    </li>
                                                    <li>
                                                        <span>Time: </span>

                                                        <i id="time">${event.startTime}</i> - <i id="time">${event.endTime}</i> 
                                                    </li>
                                                    <li>
                                                        <span>Register Deadline: </span>
                                                        <i id="date">${event.guestRegisterDeadline}</i>
                                                    </li>
                                                    <li>
                                                        <span>Venue: </span>
                                                        ${event.location.name}
                                                    </li>
                                                    <li>
                                                        <span>Registered: </span>
                                                        ${event.guestRegisterCount} / ${event.guestRegisterLimit}
                                                    </li>  
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End content of page-->
    </div>
</section>
<c:if test="${param.success eq 'true'}">
    <script>
        window.onload = function () {
            alert('Action processed successfully!');
        };
    </script>
</c:if>
<script>
    function confirmAction(event) {
        const action = event.submitter.value;
        let message = 'Are you sure you want to proceed with this action?';

        if (action === 'approve') {
            message = 'Are you sure you want to approve this event?';
        } else if (action === 'rejected') {
            message = 'Are you sure you want to reject this event?';
        }

        return confirm(message);
    }
</script>

<%@include file="../include/master-footer.jsp" %>