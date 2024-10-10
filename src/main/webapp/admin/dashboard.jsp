<%-- 
    Document   : club-dashboard
    Created on : Oct 1, 2024, 11:25:51?AM
    Author     : ThangNM
--%>
<%@include file="../include/admin-layout-header.jsp"%>
<%@ page import="com.fuem.models.Event" %>
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

        <!<!-- Start of Registration Event List-->
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
                                    <h4>Event Registration List</h4>
                                </div>
                            </div>
                            <div class="card__header-dropdown">
                                <div class="dropdown">
                                    <button>
                                        <svg class="dropdown__svg" width="14" height="4" viewBox="0 0 14 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                        <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                        <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="attendant__wrapper mb-20">
                        <!-- Check if registrationList is empty -->
                        <c:if test="${empty registrationList}">
                            <div class="no-events">
                                <span>No events registered yet</span>
                            </div>
                        </c:if>

                        <!-- Display table if there are events -->
                        <c:if test="${not empty registrationList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID No</th>
                                        <th>Club Name</th>
                                        <th>Event Name</th>
                                        <th>Date</th>
                                        <th>Category</th>
                                        <th>Location</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Loop through events passed from servlet -->
                                    <c:forEach var="event" items="${registrationList}">
                                        <tr>
                                            <td>
                                                <div class="attendant__serial">
                                                    <span>#${event.id}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="attendant__user-item">
                                                    <div class="registration__user-thumb">
                                                        <img src="${event.organizer.avatarPath}" alt="image not found">
                                                    </div>
                                                    <div class="attendant__user-title">
                                                        <span>${event.organizer.fullname}</span>
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
                                                    <span>${event.location.description}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="attendant__status">
                                                    <span class="status__tag warning-bg">
                                                        ${event.status}
                                                    </span>
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
                                                                <a class="dropdown__item" href="javascript:void(0)">Edit</a>
                                                                <a class="dropdown__item" href="javascript:void(0)">Delete</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>


        <!-- End of notification -->

        <!-- Start of organize event and Upcoming Event -->
        <div class="row">
            <!--Organized Events -->
            <div class="col-xxl-6 col-xl-6">
                <div class="card__wrapper">
                    <div class="card__header">
                        <div class="card__header-top">
                            <div class="card__title-inner">
                                <div class="card__header-icon">
                                    <i class="flaticon-calendar-3"></i>
                                </div>
                                <div class="card__header-title">
                                    <h4>Organized Events</h4>
                                </div>
                            </div>
                            <div class="card__header-right">
                                <div class="card__btn">
                                    <form action="<c:url value="/club/organized-event"/>" method="GET">
                                        <button type="submit">View All Event</button>
                                    </form>
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
                                                    <h4 class="news__title">
                                                        <a href="event-details.html">${event.fullname}</a>
                                                    </h4>
                                                    <div class="news__meta">
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
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Upcoming Events -->
            <div class="col-xxl-6 col-xl-6">
                <div class="card__wrapper">
                    <div class="card__header">
                        <div class="card__header-top">
                            <div class="card__title-inner">
                                <div class="card__header-icon">
                                    <i class="flaticon-calendar-3"></i>
                                </div>
                                <div class="card__header-title">
                                    <h4>Upcoming Events</h4>
                                </div>
                            </div>
                            <div class="card__header-right">
                                <div class="card__btn">
                                    <a href="event-details.html">view all Event</a>
                                </div>
                                <div class="card__header-dropdown">
                                    <div class="dropdown">
                                        <button>
                                            <svg class="dropdown__svg" width="14" height="4" viewBox="0 0 14 4" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                            <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                            <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                            </svg>
                                        </button>
                                        <div class="dropdown-list">
                                            <a class="dropdown__item" href="javascript:void(0)">Edit</a>
                                            <a class="dropdown__item" href="javascript:void(0)">Delete</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="scroll-w-4 card__scroll">
                            <div class="card__inner">
                                <c:if test="${empty upcomingList}">
                                    <div class="no-events">
                                        <span>No events upcoming yet</span>
                                    </div>
                                </c:if>

                                <c:if test="${not empty upcomingList}">
                                    <c:forEach var="event" items="${upcomingList}">
                                        <div class="news__item">
                                            <div class="news__item-inner">
                                                <div class="news__content">
                                                    <h4 class="news__title"><a href="event-details.html">${event.fullname}</a></h4>
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
                                                            <span>${event.location.description}</span>
                                                        </div>
                                                        <div class="news__meta-status">
                                                            <span><i class="flaticon-placeholder-1"></i></span>
                                                            <span>${event.type.name}</span>
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
                                        
<%@include file="../include/master-footer.jsp"%>