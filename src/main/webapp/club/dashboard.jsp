<%-- 
    Document   : club-dashboard
    Created on : Oct 1, 2024, 11:25:51?AM
    Author     : ThangNM
--%>
<%@include file="../include/club-layout-header.jsp"%>

<section>
    <!-- App side area start -->
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
                                    <li class="active"><span>Dashboard</span></li>
                                </ul>
                            </nav>
                        </div>
                        <div class="notification">
                            <a style="color: gray;" class="text-center" id="notifydropdown" href="#" >
                                <i style="width: 40px; font-size: 1.75rem;" class="fa-regular fa-bell"></i>
                            </a>
                            <div class="notification__dropdown">
                                <div class="notification__card card__scroll">
                                    <div class="notification__header">
                                        <div class="notification__inner">
                                            <h5>Notifications</h5>
                                        </div>
                                    </div>
                                    <ul>
                                        <c:forEach var="notification" items="${notiList}">
                                            <li class="notification__content">
                                                <p>${notification.content}</p>
                                                <div class="notification__time">
                                                    <span>${notification.timeAgo}</span>
                                                    <span class="status"><strong>${notification.sender.acronym}</strong></span>
                                                </div>
                                                <hr/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Start of statistic Number --> 
        <div class="row g-20">
            <div class="col-xxl-4 col-xl-6 col-lg-6 col-md-6">
                <div class="expovent__count-item mb-20">
                    <div class="expovent__count-thumb include__bg transition-3"
                         data-background="assets/img/bg/count-bg.png"></div>
                    <div class="expovent__count-content">
                        <h3 class="expovent__count-number">${totalEvents}</h3>
                        <span class="expovent__count-text">Total Events Organized</span>
                    </div>
                    <div class="expovent__count-icon">
                        <i class="flaticon-group"></i>
                    </div>
                </div>
            </div>
            <div class="col-xxl-4 col-xl-6 col-lg-6 col-md-6">
                <div class="expovent__count-item mb-20">
                    <div class="expovent__count-thumb include__bg transition-3"
                         data-background="assets/img/bg/count-bg.png"></div>
                    <div class="expovent__count-content">
                        <h3 class="expovent__count-number">${totalFollowers}</h3>
                        <span class="expovent__count-text">Total Followers</span>
                    </div>
                    <div class="expovent__count-icon">
                        <i class="flaticon-speaker"></i>
                    </div>
                </div>
            </div>
            <div class="col-xxl-4 col-xl-6 col-lg-6 col-md-6">
                <div class="expovent__count-item mb-20">
                    <div class="expovent__count-thumb include__bg transition-3"
                         data-background="assets/img/bg/count-bg.png"></div>
                    <div class="expovent__count-content">
                        <h3 class="expovent__count-number">${totalUpcomingEvents}</h3>
                        <span class="expovent__count-text">Total Upcoming Events</span>
                    </div>
                    <div class="expovent__count-icon">
                        <i class="flaticon-reminder"></i>
                    </div>
                </div>
            </div>
        </div>
        <!--End of statistic number--> 

        <!-- Start of Upcoming Event-->
        <div>
            <c:if test="${empty upcomingEvents}">
                <div class="no-events">
                    <span>No upcomming event!</span>
                </div>
            </c:if>
            <!-- Check if Upcoming Event is empty -->
            <c:if test="${not empty upcomingEvent}">
                <c:forEach var="event" items="${upcomingEvent}">
                    <div class="card__wrapper">
                        <c:choose>
                            <c:when test="${event.dateOfEvent eq loginDate}">
                                <div class="card__header">
                                    <div class="card__title-inner d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <div class="card__header-icon">
                                                <i class="flaticon-reminder"></i>
                                            </div>
                                            <div class="card__header-title ml-5">
                                                <h4>Today Events: ${event.fullname}</h4>
                                            </div>
                                        </div>

                                        <div class="card__header-right">
                                            <div class="element__btn yellow-bg pl-5">
                                                <a href="#">Check-in Page</a>
                                            </div>
                                        </div>
                                    </div>
                                    <hr/>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="card__header">
                                    <div class="card__header-top">
                                        <div class="card__title-inner">
                                            <div class="card__header-icon">
                                                <i class="flaticon-reminder"></i>
                                            </div>
                                            <div class="card__header-title">
                                                <h4>Upcoming Events: ${event.fullname}</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div>
                            <div class="card__inner">
                                <div class="card-body" style="display: flex; align-items: center;">
                                    <div class="col-xxl-6 col-xl-6">
                                        <div class="event__meta-time">
                                            <ul>
                                                <li><span>Date : </span><time id="date">${event.dateOfEvent}</time></li>
                                                <li><span>Time : </span><time id="time">${event.startTime}</time> - <time id="time">${event.endTime}</time></li>
                                                <li><span>Category : </span>${event.category.name}</li>
                                                <li><span>Location : </span>${event.location.description}</li>
                                                <li>
                                                    <span>Status : </span>
                                                    <c:choose>
                                                        <c:when test="${event.status == 'APPROVED'}">
                                                            <span class="status__tag bg-green">${event.status}</span>
                                                        </c:when>
                                                        <c:when test="${event.status == 'PENDING'}">
                                                            <span class="status__tag warning-bg">${event.status}</span>
                                                        </c:when>
                                                        <c:when test="${event.status == 'REJECTED'}">
                                                            <span class="status__tag bg-warn">${event.status}</span>
                                                        </c:when>
                                                        <c:when test="${event.status == 'ON_GOING'}">
                                                            <span class="status__tag teal-bg">ON GOING</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>${event.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Chart section -->
                                    <div class="col-xxl-6 col-xl-6" style="display: flex; justify-content: end;">
                                        <div class="chart-section" style="width: 300px; margin-left: 0px;">
                                            <canvas id="registrationChart${event.id}" width="300" height="400"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <!-- End of Upcoming Event -->

        <!-- Start of organized event -->
        <div class="card__wrapper">
            <div class="card__header">
                <div class="card__header-top">
                    <div class="card__title-inner">
                        <div class="card__header-icon">
                            <i class="flaticon-reminder"></i>
                        </div>
                        <div class="card__header-title">
                            <h4>Organized Events</h4>
                        </div>
                    </div>
                    <div class="card__header-right">
                        <div class="card__header-right">
                            <div class="card__btn">
                                <a href="<c:url value="/club/organized-event"/>">View All Event</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="scroll-w-1 card__scroll">
                <div class="card__inner">
                    <div class="card-body">
                        <c:forEach var="event" items="${organizedEvent}">
                            <div class="news__item">
                                <div class="news__item-inner">
                                    <div class="news__content">
                                        <h4 class="news__title"><a href="<c:url value="/club/organized-event-report?eventIdDetail=${event.id}&action=detail&organizerId=${event.organizer.id}"/>">${event.fullname}</a></h4>
                                        <div class="news__meta">
                                            <div class="news__meta-status">
                                                <span><i class="flaticon-user"></i></span>
                                                <span>${event.category.name}</span>
                                            </div>
                                            <div class="news__meta-status">
                                                <span><i class="flaticon-clock"></i></span>
                                                <span>${event.dateOfEvent}</span>
                                            </div>
                                            <div class="news__meta-status">
                                                <span><i class="flaticon-placeholder-1"></i></span>
                                                <span>${event.location.name}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- end of organize event -->
        <!-- Dashboard area end -->

</section>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
    <c:forEach var="event" items="${upcomingEvent}">
        const ctx${event.id} = document.getElementById('registrationChart${event.id}').getContext('2d');

        const data${event.id} = {
            labels: ['Registered', 'Available Slots'],
            datasets: [{
                    data: [${event.guestRegisterCount}, ${event.guestRegisterLimit - event.guestRegisterCount}],
                    backgroundColor: ['#FF6500', '#ECDFCC']
                }]
        };

        const config${event.id} = {
            type: 'doughnut',
            data: data${event.id}
        };

        console.log(config${event.id})

        const registrationChart${event.id} = new Chart(ctx${event.id}, config${event.id});
    </c:forEach>
    });
</script>

<%@include file="../include/master-footer.jsp" %>