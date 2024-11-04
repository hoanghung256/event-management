<%-- 
    Document   : club-dashboard
    Created on : Oct 1, 2024, 11:25:51?AM
    Author     : ThangNM
--%>
<%@include file="../include/club-layout-header.jsp"%>

<section>
    <style>
        .dropdown {
            position: absolute; /* ??t v? tr� t??ng ??i ?? c� th? ?i?u ch?nh v? tr� */
            top: 10px; /* C�ch t? ph�a tr�n */
            right: 10px; /* C�ch t? b�n ph?i */
            z-index: 10; /* ??m b?o dropdown n?m tr�n c�c ph?n t? kh�c */
        }

        .dropdown button {
            background: transparent; /* N?n trong su?t cho n�t */
            border: none; /* Kh�ng c� vi?n */
            cursor: pointer; /* Hi?n th? con tr? khi di chu?t */

        }

        .dropdown-list {
            display: none; /* ?n dropdown m?c ??nh */
            position: absolute; /* ??t dropdown b�n d??i n�t */
            top: 20px; /* ??t kho?ng c�ch t? n�t ??n dropdown */
            right: 0; /* ??t dropdown c?n ph?i */
            background-color: white; /* N?n tr?ng cho dropdown */
            border: 1px solid #ccc; /* ???ng vi?n cho dropdown */
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15); /* ?? b�ng cho dropdown */
        }

        .dropdown:hover .dropdown-list {
            display: block; /* Hi?n dropdown khi hover */
        }
        .small-btn{
            height:3rem !important;
        }
    </style>
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
            <c:if test="${empty upcomingEvent}">
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
                                                <h4>Today: ${event.fullname}</h4>
                                            </div>
                                        </div>

                                        <div class="card__header-right">
                                            <div class="element__btn yellow-bg pl-5 small-btn ">
                                                <a href="<c:url value="/club/check-in?eventId=${event.id}" />">Check-in Page</a>
                                            </div>
                                            <div class="element__btn yellow-bg pl-5 small-btn">
                                                <a href="<c:url value="/club/on-going-event?action=access&eventId=${event.id}" />">Landing Page</a>
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
                                        <div class="dropdown">
                                            <button>
                                                <svg class="attendant__dot" width="50" height="5" viewBox="0 0 14 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                                <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                                <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                                </svg>
                                            </button>
                                            <div class="dropdown-list">
                                                <a class="dropdown__item" href="<c:url value='/club/view-list-guest?eventId=${event.id}'/>">View list guest</a>
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

        <!-- Start of pending event -->
        <div class="row">
            <!--Registration Events -->
            <div class="col-xxl-6 col-xl-6 p-2">
                <div class="card__wrapper">
                    <div class="card__header">
                        <div class="card__header-top">
                            <div class="card__title-inner">
                                <div class="card__header-icon">
                                    <i class="flaticon-calendar-3"></i>
                                </div>
                                <div class="card__header-title">
                                    <h4>Pending Events</h4>
                                </div>
                            </div>
                            <div class="card__header-right">
                                <div class="card__header-right">
                                    <div class="card__btn">
                                        <a href="<c:url value="#"/>">View All</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="scroll-w-4 card__scroll">
                            <div class="card__inner">
                                <c:if test="${empty pendingEvent}">
                                    <div class="no-events">
                                        <span>No pending event yet</span>
                                    </div>
                                </c:if>

                                <c:if test="${not empty pendingEvent}">
                                    <c:forEach var="event" items="${pendingEvent}">
                                        <div class="news__item">
                                            <div class="news__content">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h4 class="news__title">
                                                        <a href="<c:url value="/club/approval-events?action=detail&eventId=${event.id}" />">${event.fullname}</a>
                                                    </h4>

                                                    <div class="dropdown">
                                                        <button>
                                                            <svg class="attendant__dot" width="50" height="5" viewBox="0 0 14 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                                            <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                                            <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                                            </svg>
                                                        </button>
                                                        <div class="dropdown-list">
                                                            <a class="dropdown__item" href="<c:url value='/club/edit-event?eventId=${event.id}'/>">Edit23</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="news__meta">
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-clock"></i></span>
                                                        <span id="date">${event.dateOfEvent}</span>
                                                    </div>
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-event"></i></span>
                                                        <span>${event.category.name}</span>
                                                    </div>
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-placeholder-1"></i></span>
                                                        <span>${event.location.name}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Organized Events -->
            <div class="col-xxl-6 col-xl-6 p-2">
                <div class="card__wrapper">
                    <div class="card__header">
                        <div class="card__header-top">
                            <div class="card__title-inner">
                                <div class="card__header-icon">
                                    <i class="flaticon-calendar-3"></i>
                                </div>
                                <div class="card__header-title">
                                    <h4>Organized Events This Month</h4>
                                </div>
                            </div>
                            <div class="card__header-right">
                                <div class="card__btn">
                                    <a href="<c:url value="/club/organized-event"/>">View All Event</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="scroll-w-4 card__scroll">
                            <div class="card__inner">
                                <c:if test="${empty organizedEvent}">
                                    <div class="no-events">
                                        <span>No events organized yet</span>
                                    </div>
                                </c:if>

                                <c:if test="${not empty organizedEvent}">
                                    <c:forEach var="event" items="${organizedEvent}">
                                        <div class="news__item">
                                            <div class="news__item-inner">
                                                <div class="news__content">
                                                    <h4 class="news__title"><a href="<c:url value="/club/organized-event-report?eventIdDetail=${event.id}&action=detail&organizerId=${event.organizer.id}"/>">${event.fullname}</a></h4>
                                                    <div class="news__meta">
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-clock"></i></span>
                                                            <span>${event.dateOfEvent}</span>
                                                        </div>
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-event"></i></span>
                                                            <span>${event.category.name}</span>
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
                                </c:if>
                            </div>
                        </div>
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