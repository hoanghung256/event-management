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
                            <a id="notifydropdown" href="#" >
                                <div class="notification__icon" >
                                    <svg width="24" height="24" viewBox="0 0 22 22" fill="none" style="ms-auto"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <g clip-path="url(#clip0_209_757)">
                                            <path
                                                d="M9.1665 22C7.27185 22 5.729 20.4582 5.729 18.5625C5.729 18.183 6.037 17.875 6.4165 17.875C6.79601 17.875 7.104 18.183 7.104 18.5625C7.104 19.7002 8.02985 20.625 9.1665 20.625C10.3032 20.625 11.229 19.7002 11.229 18.5625C11.229 18.183 11.537 17.875 11.9165 17.875C12.296 17.875 12.604 18.183 12.604 18.5625C12.604 20.4582 11.0613 22 9.1665 22Z"
                                                fill="#7A7A7A" />
                                            <path
                                                d="M16.7291 19.2499H1.60411C0.719559 19.2499 0 18.5304 0 17.6458C0 17.1764 0.204437 16.7319 0.560944 16.4266C0.583939 16.4065 0.608612 16.3882 0.634293 16.3715C1.97992 15.1973 2.75 13.5079 2.75 11.724V9.16655C2.75 6.18106 4.77306 3.61805 7.66975 2.93323C8.04002 2.84797 8.41046 3.07439 8.49757 3.44483C8.58452 3.81426 8.35541 4.18453 7.98698 4.27164C5.71266 4.80875 4.125 6.82174 4.125 9.16655V11.724C4.125 13.9388 3.15417 16.0343 1.46396 17.4724C1.4502 17.4835 1.43828 17.4936 1.42351 17.5037C1.39883 17.5349 1.375 17.5826 1.375 17.6458C1.375 17.7704 1.47957 17.8749 1.60411 17.8749H16.7291C16.8538 17.8749 16.9584 17.7704 16.9584 17.6458C16.9584 17.5815 16.9346 17.5349 16.9089 17.5037C16.8951 17.4936 16.8822 17.4835 16.8694 17.4724C16.0482 16.7722 15.3999 15.9271 14.9436 14.9599C14.7804 14.617 14.9269 14.2073 15.2707 14.0442C15.6173 13.881 16.0233 14.0296 16.1856 14.3723C16.5485 15.1387 17.0573 15.8116 17.7008 16.3744C17.7246 16.3908 17.7495 16.4083 17.7704 16.4266C18.129 16.7319 18.3334 17.1764 18.3334 17.6458C18.3334 18.5304 17.6138 19.2499 16.7291 19.2499Z"
                                                fill="#7A7A7A" />
                                            <path
                                                d="M16.0417 11.9166C12.7565 11.9166 10.0835 9.24365 10.0835 5.95839C10.0835 2.67296 12.7565 0 16.0417 0C19.3271 0 22.0001 2.67296 22.0001 5.95839C22.0001 9.24365 19.3271 11.9166 16.0417 11.9166ZM16.0417 1.375C13.5145 1.375 11.4585 3.43112 11.4585 5.95839C11.4585 8.48566 13.5145 10.5416 16.0417 10.5416C18.569 10.5416 20.6251 8.48566 20.6251 5.95839C20.6251 3.43112 18.569 1.375 16.0417 1.375Z"
                                                fill="#7A7A7A" />
                                            <path
                                                d="M16.2709 8.70828C15.8914 8.70828 15.5834 8.40028 15.5834 8.02078V5.0415H15.125C14.7455 5.0415 14.4375 4.73351 14.4375 4.354C14.4375 3.9745 14.7455 3.6665 15.125 3.6665H16.2709C16.6504 3.6665 16.9584 3.9745 16.9584 4.354V8.02078C16.9584 8.40028 16.6504 8.70828 16.2709 8.70828Z"
                                                fill="#7A7A7A" />
                                        </g>
                                        <defs>
                                            <clipPath id="clip0_209_757">
                                                <rect width="22" height="22" fill="white" />
                                            </clipPath>
                                        </defs>
                                    </svg>
                                </div>
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
                                            <h3>Today Events: ${event.fullname}</h3>
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
                                                    <li><span>Organizer : </span>${event.organizer.acronym}</li>
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
                                                        <div class="registration__user-thumb">
                                                            <img class="rounded-circle" src="<c:url value="${event.organizer.avatarPath}"/>" alt="image not found">
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