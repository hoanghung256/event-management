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
                                <div class="body__card-wrapper mb-20 pt-3 pb-2">
                                    <div class="card__header-top">
                                        <div class="card__title-inner">
                                            <h2 style="font-size: 28px;" class="event__information-title">${event.fullname}</h2>
                                        </div>
                                    </div>
                                    <div class="review__main-wrapper">
                                        <div class="review__meta mb-15"></div>
                                        <div class="review__author-meta mb-15">
                                            <a href="#">
                                                <div class="review__author-thumb">
                                                    <img class="rounded-circle" style="height: 40px; width: 40px;" src="https://scontent.xx.fbcdn.net/v/t1.15752-9/454960482_989030249643168_4313190723573478073_n.jpg?stp=dst-jpg_s206x206&_nc_cat=102&ccb=1-7&_nc_sid=0024fc&_nc_ohc=MtvFlhdFJ1IQ7kNvgH7lh6P&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=scontent.xx&_nc_gid=AbI6Jx2D9mje_lezs6PEixF&oh=03_Q7cD1QGqJ5U0_jHfWBOrm0G9nyMP1QRbgIr6FGoZXDWogfOLvA&oe=67359E30" alt="Organizer Avatar" onerror="this.onerror=null; this.src='assets/img/default-avatar.png';">
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
                                    </div>
                                </div>
                                <div class="col-md-8 p-1">
                                    <div class="event__details-left">

                                        <div class="body__card-wrapper mb-20">
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
                                                                        <img src="<c:url value="${image}"/>" alt="Event Image" />
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


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-4 p-1">
                                    <div class="event__details-right">
                                        <div class="body__card-wrapper mb-20">
                                            <div class="event__meta-time" ">
                                                <ul>
                                                    <li style="display:flex;">
                                                        <div style="margin-right: 10px;">
                                                            <span>Date: </span>
                                                            <i id="date">${event.dateOfEvent}</i>
                                                        </div>
                                                        <div style="margin-right: 10px; position: relative;">
                                                            <span>   Time: </span>
                                                            <i id="time">${event.startTime}</i> - <i id="time">${event.endTime}</i>
                                                            <span style="position: absolute; left: -10px; top: 0;">    </span>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <span>Venue: </span>
                                                        ${event.location.name}
                                                    </li>
                                                    <li>
                                                        <span>Register Deadline: </span>
                                                        <i id="date">${event.guestRegisterDeadline}</i>
                                                    </li>

                                                    <li>
                                                        <span>Registered: </span>
                                                        ${event.guestRegisterCount} / ${event.guestRegisterLimit}
                                                    </li>  

                                                    <c:if test="${event.collaboratorRegisterLimit != 0}">
                                                        <li>
                                                            <span>Collaborator Deadline: </span>
                                                            ${event.collaboratorRegisterDeadline}
                                                        </li>
                                                        <li>
                                                            <span>Collaborator: </span>
                                                            ${event.collaboratorRegisterCount} / ${event.collaboratorRegisterLimit}
                                                        </li>
                                                    </c:if>

                                                </ul>
                                                <div class="ticket__purchase-wrapper mt-30">
                                                    <div class="ticket__price-inner">
                                                        <div class="ticket__price-item">
                                                            <c:if test="${event.collaboratorRegisterLimit != 0}">
                                                                <c:if test="${studentRole == 'COLLABORATOR'}">
                                                                    <form action="event-detail" method="post">
                                                                        <input type="hidden" name="action" value="cancelCollaborator">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn red-bg" type="submit">Cancel Collab</button>
                                                                    </form>
                                                                </c:if>
                                                                <c:if test="${studentRole == null}">
                                                                    <form action="event-detail" method="post">
                                                                        <input type="hidden" name="action" value="registerCollaborator">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn border-yellow" type="submit">Collab Regist</button>
                                                                    </form>
                                                                </c:if>
                                                            </c:if>
                                                        </div>
                                                        <div class="ticket__price-item">
                                                            <c:if test="${event.guestRegisterLimit != 0}">
                                                                <c:if test="${studentRole == 'GUEST'}">
                                                                    <form action="event-detail" method="post">
                                                                        <input type="hidden" name="action" value="cancelGuest">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn red-bg" type="submit">Cancel GuestRegist</button>
                                                                    </form>
                                                                </c:if>
                                                                <c:if test="${studentRole == null}">
                                                                    <form action="event-detail" method="post">
                                                                        <input type="hidden" name="action" value="registerGuest">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn border-yellow" type="submit">Guest Regist</button>
                                                                    </form>
                                                                </c:if>
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
                </div>
            </div>
        </div>
        <!--End content cua page-->
    </div>
</section>

<%@include file="include/master-footer.jsp" %>