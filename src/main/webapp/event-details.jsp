<%-- 
    Document   : event-details
    Created on : Sep 25, 2024, 5:07:43?PM
    Author     : TuDK
--%>

<%@include file="include/student-layout-header.jsp"%>

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
                                <div class="col-xxl-7 col-xl-6">
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
                                                            <h4>${event.organizer.fullname}</h4> 
                                                        </div>
                                                    </a>
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
                                                                            <img src="${image}" alt="Event Image" />
                                                                        </c:forEach>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${pageContext.request.contextPath}/assets/img/event/default-image.jpg" alt="Default Image" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <div class="about__content mt-30">
                                                                <h4>About This Event</h4>
                                                                <p>${event.description}</p>
                                                            </div>

                                                            <div class="ticket__purchase-wrapper mt-30">
                                                                <h4 class="ticket__purchase-title">Register Now</h4>
                                                                <div class="ticket__price-inner">
                                                                    <div class="ticket__price-item">
                                                                        <c:if test="${event.collaboratorRegisterLimit != 0}">
                                                                            <button class="unfield__input-btn" type="submit">Collaborator register</button>
                                                                        </c:if>
                                                                    </div>
                                                                    <div class="ticket__price-item">
                                                                        <c:if test="${event.guestRegisterLimit != 0}">
                                                                            <button class="unfield__input-btn" type="submit">Guest register</button>
                                                                        </c:if>
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
                                <div class="col-xxl-5 col-xl-6">
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
        <!--End content cua page-->
    </div>
</section>

<%@include file="include/master-footer.jsp" %>