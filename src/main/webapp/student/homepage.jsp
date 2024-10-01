<%-- 
    Document   : hompage
    Created on : Sep 24, 2024, 9:01:44 AM
    Author     : hoang hung 
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/student-layout-header.jsp"%>
<section>
    <div class="app__slide-wrapper">
        <div class="breadcrumb__area">
            <div class="breadcrumb__wrapper mb-35">
                <div class="breadcrumb__main container">
                    <div class="breadcrumb__inner col-md-2">
                        <div class="breadcrumb__icon">
                            <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                            <nav>
                                <ul>
                                    <li><span><a href="dashboard.html">Home</a></span></li>
                                    <li class="active"><span>Event List</span></li>

                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div>
                        <form action="event-list" method="GET" class="row g-3">
                            <!-- Row 1: Event Name, Event Type, Organizer -->
                            <div class="col-md-4">
                                <label for="name" class="form-label">Event Name</label>
                                <input type="text" id="name" name="name" value="${previousSearchEventCriteria.name}" class="form-control">
                            </div>

                            <div class="col-md-4">
                                <label for="typeId" class="form-label">Event Type</label>
                                <select id="typeId" name="typeId" class="form-select">
                                    <option value="1" ${previousSearchEventCriteria.typeId == 1 ? "selected" : ""}>Workshop</option>
                                    <option value="2" ${previousSearchEventCriteria.typeId == 2 ? "selected" : ""}>Seminar</option>
                                    <option value="3" ${previousSearchEventCriteria.typeId == 3 ? "selected" : ""}>Club Meeting</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="organizerId" class="form-label">Organizer</label>
                                <select id="organizerId" name="organizerId" class="form-select">
                                    <option value="1" ${previousSearchEventCriteria.organizerId == 1 ? "selected" : ""}>ICPDP Department</option>
                                    <option value="2" ${previousSearchEventCriteria.organizerId == 2 ? "selected" : ""}>FU - Dever</option>
                                    <option value="3" ${previousSearchEventCriteria.organizerId == 3 ? "selected" : ""}>TIA - Traditional Instrument Abide Club</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="notification col-md-1" >
                        <a id="notifydropdown" href="#" >
                            <div class="notification__icon" >
                                <svg width="25" height="25" viewBox="0 0 22 22" fill="none" style="ms-auto"
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
                    </div>
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
                                            <span class="status">${notification.sender.acronym}</span>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="container col-md-8">
                    <form action="event-list" method="GET" class="row g-3">
                        <!-- Row 2: Date From, Date To -->
                        <div class="col-md-4">
                            <label for="from" class="form-label">From</label>
                            <input type="date" id="from" name="from" value="${previousSearchEventCriteria.from}" class="form-control">
                        </div>

                        <div class="col-md-4">
                            <label for="to" class="form-label">To</label>
                            <input type="date" id="to" name="to" value="${previousSearchEventCriteria.to}" class="form-control">
                        </div>

                        <!-- Submit button -->
                        <div class="col-4 col-md-4">
                            <button type="submit" class="btn btn-primary">Find</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--B?t ??u n?i dung c?a trang ? ?ây-->
    <div class="pb-20">
        <div class="row">
            <div>
                <div class="" id="myTabContent">
                    <div class="" id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                        <!-- Event item - Start -->
                        <c:forEach var="event" items="${eventList}">
                            <div class="event-list-item clearfix" style="display: flex; margin-bottom: 20px;">
                                <!-- Event Image - Start -->
                                <div class="event-image" style="height: 100%; position: relative; width: 30%;">
                                    <div class="post-date" style="position: absolute; top: 10px; left: 10px; padding: 5px;">
                                        <span class="date" style="font-size: 20px; font-weight: bold;">
                                            <fmt:formatDate value="${event.dateOfEvent}" pattern="dd"/>
                                        </span>
                                        <small class="month" style="display: block;">
                                            <fmt:formatDate value="${event.dateOfEvent}" pattern="MMM"/>
                                        </small>
                                    </div>
                                    <img src="assets/img/event/event-details.jpg" alt="Event Image" style="width: 100%; height: auto;">
                                </div>
                                <!-- Event Image - End -->

                                <!-- Event Content - Start -->
                                <div class="event-content" style="width: 70%; padding-left: 20px;">
                                    <h3 class="event-title" style="margin-bottom: 10px; font-size: 24px;">
                                        ${event.fullname}
                                    </h3>
                                    <p>Register Deadline: <fmt:formatDate value="${event.registerDeadline}" pattern="dd/MM/yyyy"/></p>
                                    <p class="description-text truncated-text">
                                        ${event.description}
                                    </p>
                                    <div class="event-info-list" style="display: flex; justify-content: space-between;">
                                        <div style="margin-bottom: 10px;">
                                            <span class="event-type">Type: ${event.type.name}</span>
                                        </div>
                                        <div>
                                            <p class="location"><i class="fas fa-location-dot"></i> ${event.location.description}</p>
                                        </div>
                                        <div>
                                            <p>Registered: ${event.guestAttendedCount}/${event.guestRegisterLimit}</p>
                                        </div>
                                        <a class="element__btn border-yellow" href="#">Details</a>
                                    </div>
                                </div>
                                <!-- Event Content - End -->
                            </div>
                            <!-- Event item - End -->
                        </c:forEach>
                    </div>
                </div>
            </div>


            <div class="col-md-2">
                <div class="notification-section">

                </div>
            </div>
        </div>
        <!-- K?t thúc n?i dung c?a trang -->
    </div>
</div>
</section>
<%@include file="../include/master-footer.jsp" %>

