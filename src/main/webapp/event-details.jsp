<%-- 
    Document   : event-details
    Created on : Sep 25, 2024, 5:07:43?PM
    Author     : TuDK
--%>

<%@include file="include/student-layout-header.jsp"%>
<style>
    .carousel-item img {
        width: 100%;
        height: auto;
        max-height: 500px;
        object-fit: contain;
    }
    .carousel-control-prev,
    .carousel-control-next {
        width: 40px;
        height: 40px;

        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        top: 50%;
    }

    .carousel-control-prev-icon,
    .carousel-control-next-icon {
        width: 30px;
        height: 30px;
        background-color: rgba(0, 0, 0, 0.2);
        border-radius: 50%;
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
                                <div class="body__card-wrapper mb-1 pt-3 pb-2">
                                    <div class="card__header-top">
                                        <div class="card__title-inner">
                                            <h2 style="font-size: 28px;" class="event__information-title">${event.fullname}</h2>
                                        </div>
                                    </div>
                                    <div class="review__main-wrapper">
                                        <div class="review__meta mb-15"></div>
                                        
                                            <div class="review__main-wrapper pt-1">
                                                <div class="review__meta mb-25"></div>
                                                <div class="review__author-meta mb-15">
                                                    <a href="#">
                                                        <div class="review__author-thumb">
                                                            <img class="rounded-circle" style="height: 40px; width: 40px;"src="<c:url value="${event.organizer.avatarPath}"/>" alt="Organizer Avatar" onerror="this.onerror=null; this.src='assets/img/default-avatar.png';">
                                                        </div>
                                                        <div class="review__author-name">
                                                            <a href="<c:url value="/profile?role=club&id=${event.organizer.id}" />">
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
                                                           <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000">
                                                                <ol class="carousel-indicators">
                                                                    <c:forEach var="image" items="${event.images}" varStatus="status">
                                                                        <li data-target="#eventImageCarousel" data-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                                                                        </c:forEach>
                                                                </ol>
                                                                <div class="carousel-inner">
                                                                    <c:forEach var="image" items="${event.images}" varStatus="status">
                                                                        <div class="carousel-item ${status.first ? 'active' : ''}">
                                                                            <img class="d-block w-100" src="<c:url value='${image}'/>" alt="Event Image ${status.index + 1}">
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
                                                                <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
                                                                    <span class="carousel-control-prev-icon"></span>
                                                                    <span class="sr-only">Previous</span>
                                                                </a>
                                                                <a class="carousel-control-next" href="#myCarousel" data-slide="next">
                                                                    <span class="carousel-control-next-icon"></span>
                                                                    <span class="sr-only">Next</span>
                                                                </a>
                                                            </div>
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
                                            <div class="event__meta-time">
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
                                                            <c:if test="${event.collaboratorRegisterLimit > 0}">
                                                                <c:if test="${isCollabRegis == true and isGuestRegis == false}">
                                                                    <form action="<c:url value="/event-detail" />" method="POST">
                                                                        <input type="hidden" name="action" value="cancelAsCollaborator">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn red-bg" type="submit">Cancel Collaborator</button>
                                                                    </form>
                                                                </c:if>
                                                                <c:if test="${isCollabRegis == false and isGuestRegis == false}">
                                                                    <form action="<c:url value="/event-detail" />" method="POST">
                                                                        <input type="hidden" name="action" value="registerAsCollaborator">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn border-yellow" type="submit">Collaborator Register</button>
                                                                    </form>
                                                                </c:if>
                                                            </c:if>
                                                        </div>
                                                        <div class="ticket__price-item">
                                                            <c:if test="${event.guestRegisterLimit > 0}">
                                                                <c:if test="${isGuestRegis == true and isCollabRegis == false}">
                                                                    <form action="<c:url value="/event-detail" />" method="POST">
                                                                        <input type="hidden" name="action" value="cancelAsGuest">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn red-bg" type="submit">Cancel Guest Register</button>
                                                                    </form>
                                                                </c:if>
                                                                <c:if test="${isGuestRegis == false and isCollabRegis == false}">
                                                                    <form action="<c:url value="/event-detail" />" method="POST">
                                                                        <input type="hidden" name="action" value="registerAsGuest">
                                                                        <input type="hidden" name="eventId" value="${event.id}">
                                                                        <button style="height: 45px; padding: 0 10px;" class="element__btn border-yellow" type="submit">Guest Register</button>
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
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<%@include file="include/master-footer.jsp" %>