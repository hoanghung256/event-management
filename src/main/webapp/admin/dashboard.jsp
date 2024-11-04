<%-- 
    Document   : admin-dashboard
    Created on : Oct 1, 2024, 11:25:51?AM
    Author     : ThangNM
--%>
<%@include file="../include/admin-layout-header.jsp"%>
<style>
    .no-events {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 200px; /* Adjust based on your layout */
        background-color: #f5f5f5;
        border: 1px solid #ddd;
        border-radius: 8px;
        text-align: center;
        font-size: 18px;
        font-weight: bold;
        color: #777;
    }

    .no-events span {
        display: block;
        padding: 20px;
    }
</style>
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
                        <h3 class="expovent__count-number">${totalOrganizedEvents}</h3>
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
                        <h3 class="expovent__count-number">${totalClubs}</h3>
                        <span class="expovent__count-text">Total Clubs</span>
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

        <!-- Start of Today Event List -->
        <div>
            <!-- Check if Today Event is empty -->
            <c:if test="${not empty upcomingList}">
                <c:forEach var="event" items="${upcomingList}">
                    <c:if test="${event.dateOfEvent eq loginDate}">
                        <div class="card__wrapper">
                            <div class="card__header">
                                <div class="card__title-inner d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <div class="card__header-icon">
                                            <i class="flaticon-reminder"></i>
                                        </div>
                                        <div class="card__header-title ml-5">
                                            <h3>Today: ${event.fullname}</h3>
                                        </div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${event.organizer.id == sessionScope.userInfor.id}"> 
                                            <div class="card__header-right">
                                                <div class="element__btn yellow-bg pl-5">
                                                    <a href="#">Check-in Page</a>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="card__header-right">
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <hr/>
                            </div>

                            <div>
                                <div class="card__inner">
                                    <div class="card-body" style="display: flex; align-items: center;">
                                        <div class="col-xxl-6 col-xl-6">
                                            <div class="event__meta-time">
                                                <ul>
                                                    <li><span>Organizer : </span>${event.organizer.fullname}</li>
                                                    <li><span>Date : </span><time id="date">${event.dateOfEvent}</time> 
                                                        <span>Time : </span><time id="time">${event.startTime}</time> - <time id="time">${event.endTime}</time></li>
                                                    <li><span>Category : </span>${event.category.name}</li>
                                                    <li><span>Location : </span>${event.location.name}</li>
                                                    <li>
                                                        <span>Status : </span>
                                                        <c:choose>
                                                            <c:when test="${event.status == 'APPROVED'}">
                                                                <span class="status__tag bg-green">${event.status}</span>
                                                            </c:when>
                                                            <c:when test="${event.status == 'ON_GOING'}">
                                                                <span class="status__tag teal-bg">ON GOING</span>
                                                            </c:when>
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
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
        <!-- End of Today Event List -->

        <!-- Start of Upcoming Event List-->
        <div class="row">
            <div class="col-xxl-12">
                <div class="card__wrapper">
                    <div class="card__header">
                        <div class="card__header-top mb-5">
                            <div class="card__title-inner">
                                <div class="card__header-icon">
                                    <i class="flaticon-ticket-1"></i>
                                </div>
                                <div class="card__header-title">
                                    <h4>Upcoming Event List</h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="attendant__wrapper mb-20">
                        <!-- Check if Upcoming Event is empty -->
                        <c:if test="${empty upcomingList}">
                            <div class="no-events">
                                <span>No events registered yet</span>
                            </div>
                        </c:if>

                        <!-- Display table if there are events -->
                        <c:if test="${not empty upcomingList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID No</th>
                                        <th>Organizer</th>
                                        <th>Event Name</th>
                                        <th>Date</th>
                                        <th>Category</th>
                                        <th>Location</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Loop through events passed from servlet -->
                                    <c:forEach var="event" items="${upcomingList}">
                                        <c:if test="${event.dateOfEvent > loginDate}">
                                            <tr>
                                                <td>
                                                    <div class="attendant__serial">
                                                        <span>#${event.id}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__user-item">
                                                        <div class="user__portfolio-thumb">
                                                            <img src="<c:url value="${event.organizer.avatarPath}"/>" alt="image not found">
                                                        </div>
                                                        <div class="attendant__user-title">
                                                            <span>
                                                                <a href="<c:url value="/profile?role=club&id=${event.organizer.id}" />">
                                                                    ${event.organizer.fullname}
                                                                </a>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__seminer">
                                                        <span><a href="">${event.fullname}</a></span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__date">
                                                        <span>${event.dateOfEvent}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="category">
                                                        <span>${event.category.name}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="location">
                                                        <span>${event.location.name}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__action">
                                                        <div class="card__header-dropdown">
                                                            <div class="dropdown">
                                                                <button>
                                                                    <svg class="dropdown__svg" width="14" height="4" viewBox="0 0 14 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                                                        <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                                                        <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                                                    </svg>
                                                                </button>
                                                                <div class="dropdown-list">
                                                                    <a class="dropdown__item" href="<c:url value="" />">Detail</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>


        <!-- End of notification -->

        <!-- Start of organize event and registration Event -->
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
                                        <a href="<c:url value="/admin/approval-events?action=show"/>">View All</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="scroll-w-4 card__scroll">
                            <div class="card__inner">
                                <c:if test="${empty registrationList}">
                                    <div class="no-events">
                                        <span>No events organized yet</span>
                                    </div>
                                </c:if>

                                <c:if test="${not empty registrationList}">
                                    <c:forEach var="event" items="${registrationList}">
                                        <div class="news__item">
                                            <div class="news__content">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h4 class="news__title">
                                                        <a href="<c:url value="/admin/approval-events?action=detail&eventId=${event.id}" />">${event.fullname}</a>
                                                    </h4>
                                                    <span class="status__tag warning-bg">${event.status}</span>
                                                </div>
                                                <div class="news__meta">
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-user"></i></span>
                                                        <span>${event.organizer.fullname}</span>
                                                    </div>
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-clock"></i></span>
                                                        <span id="date">${event.dateOfEvent}</span>
                                                    </div>
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-event"></i></span>
                                                        <span>${event.category.name}</span>
                                                    </div>
                                                    <div class="news__meta-status">
                                                        <span><i class="flaticon-event"></i></span>
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
                                    <a href="<c:url value="/admin/organized-event"/>">View All Event</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="scroll-w-4 card__scroll">
                            <div class="card__inner">
                                <c:if test="${empty organizedList}">
                                    <div class="no-events">
                                        <span>No events organized yet</span>
                                    </div>
                                </c:if>

                                <c:if test="${not empty organizedList}">
                                    <c:forEach var="event" items="${organizedList}">
                                        <div class="news__item">
                                            <div class="news__item-inner">
                                                <div class="news__content">
                                                    <h4 class="news__title"><a href="<c:url value="/admin/organized-event-report?eventIdDetail=${event.id}&action=detail&organizerId=${event.organizer.id}"/>">${event.fullname}</a></h4>
                                                    <div class="news__meta">
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-user"></i></span>
                                                            <span>${event.organizer.acronym}</span>
                                                        </div>
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-clock"></i></span>
                                                            <span>${event.dateOfEvent}</span>
                                                        </div>
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-placeholder-1"></i></span>
                                                            <span>${event.location.name}</span>
                                                        </div>
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-placeholder-1"></i></span>
                                                            <span>${event.category.name}</span>
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
        <!-- end of organize event and registration Event -->
        <!-- Dashboard area end -->
</section>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
    <c:forEach var="event" items="${upcomingList}">
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

<%@include file="../include/master-footer.jsp"%>