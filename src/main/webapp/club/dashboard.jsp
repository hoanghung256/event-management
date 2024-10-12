<%-- 
    Document   : club-dashboard
    Created on : Oct 1, 2024, 11:25:51?AM
    Author     : ThangNM
--%>
<%@include file="../include/club-layout-header.jsp"%>
<%@ page import="com.fuem.models.Event" %>
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

        <!<!-- Start of Upcoming Event-->
        <div>
            <c:if test="${not empty upcomingEvent}">
                <c:forEach var="event" items="${upcomingEvent}">
                    <div class="card__wrapper">
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
                                                        <c:when test="${event.status == 'CANCEL'}">
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
        <!-- End of notification -->

        <!-- Start of organize event -->
        <div>
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
                            <div class="card__header-right">
                                <div class="card__btn">
                                    <form action="<c:url value="/club/organized-event"/>" method="GET">
                                        <button type="submit">View All Event</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="card__header-dropdown">
                            <div class="dropdown">
                                <button>
                                    <svg class="dropdown__svg" width="14" height="4" viewBox="0 0 14 4" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z"
                                        fill="white"></path>
                                    <path
                                        d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z"
                                        fill="white"></path>
                                    <path
                                        d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z"
                                        fill="white"></path>
                                    </svg>
                                </button>
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
                                            <h4 class="news__title"><a href="#">${event.fullname}</a></h4>
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
                                                    <span>${event.location.description}</span>
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