<%-- 
    Document   : hompage
    Created on : Sep 24, 2024, 9:01:44 AM
    Author     : hoang hung 
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="include/student-layout-header.jsp"%>
<style>
    .today-event-list {
        width: 80%;
        margin: 0 auto;
    }

    .carousel-inner {
        width: 100%;
        height: auto;
        border-radius: 10px;
    }

    .carousel-item {
        height: 550px;
        background-size: cover;
        background-position: center;
        /*transition: transform 1s ease-in-out;  Smooth transition for sliding effect*/
        position: relative;
    }

    .carousel-caption {
        position: absolute;
        bottom: 0%;
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.5);
        text-align: center;
        width: 100%;
        height: 100%;
        opacity: 0;
        transition: opacity 0.4s ease, visibility 0.4s ease;
    }
    .carousel-item:hover .carousel-caption{
        opacity: 1; /* Hi?n th? n?i dung */
        visibility: visible; /* Hi?n th? n?i dung */
        /*transform: scale(1.1);*/
    }

    .carousel-caption h4 {
        font-size: 25px;
        color: white;
    }

    .carousel-caption a {
        margin-top: 10px;
        text-decoration: none;
        border: none;
        border-radius: 5px;
    }

    .carousel-indicators {
        bottom: -30px;
    }

    .list-title {
        text-align: center;
    }

    /* Thay ??i k�ch th??c v� m�u s?c c?a n�t ?i?u h??ng tr�i ph?i */
    .carousel-control-prev-icon,
    .carousel-control-next-icon {
        width: 30px; /* T?ng k�ch th??c bi?u t??ng */
        height: 30px;
    }
    .carousel-caption {
        position: absolute;
        top: 50%; /* ??a l�n gi?a chi?u d?c */
        left: 50%;
        transform: translate(-50%, -50%); /* C?n gi?a ho�n to�n */
        background-color: rgba(0, 0, 0, 0.5);
        text-align: center;
        width: 100%;
        padding: 20px; /* Th�m kho?ng c�ch */
        opacity: 0;
        transition: opacity 0.4s ease, visibility 0.4s ease;
    }

    .carousel-item:hover .carousel-caption {
        opacity: 1; /* Hi?n n?i dung */
        visibility: visible; /* Hi?n n?i dung */
    }

    .carousel-caption h4,
    .carousel-caption p,
    .carousel-caption .location,
    .carousel-caption .event-type {
        color: white; /* ??t m�u ch? th�nh tr?ng */
    }

    /* ?? l�m cho c�c li�n k?t tr? n�n n?i b?t h?n */


    .carousel-caption a:hover {
        background-color: #e6b800; /* M�u n?n khi hover */
    }

    .today-truncated-text {
        display: -webkit-box;          /* Thi?t l?p ch? ?? hi?n th? box */
        -webkit-box-orient: vertical;  /* H??ng c?a box l� d?c */
        -webkit-line-clamp: 3;        /* Gi?i h?n s? d�ng hi?n th? l� 3 */
        overflow: hidden;              /* ?n n?i dung th?a */
        text-overflow: ellipsis;      /* Hi?n th? d?u ba ch?m (...) n?u c� n?i dung b? c?t */
    }
    .carousel-caption > * {
        margin: 4rem 0 0 0; /* Th�m margin cho t?t c? c�c ph?n t? con */
    }
    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% {
            transform: translateY(0);
        }
        40% {
            transform: translateY(-10px);
        }
        60% {
            transform: translateY(-5px);
        }
    }

    .bounce-text {
        color: orange;
        animation: bounce 1s infinite; /* Th?i gian nh?y v� l?p l?i v� h?n */
        font-weight: bold;
    }

</style>
<section>
    <div class="app__slide-wrapper">
        <div class="breadcrumb__area">
            <div class="breadcrumb__wrapper">
                <!--<div class="breadcrumb__main container">-->
                <div class="breadcrumb__inner col-md-12">
                    <div class="breadcrumb__icon">
                        <i class="flaticon-home"></i>
                    </div>
                    <div class="breadcrumb__menu">
                        <nav>
                            <ul style="margin-bottom: 0px;">
                                <li class="active"><span>Home</span></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-md-12 d-flex" sytle="justify-content: space-between;">
                    <form action="home" method="GET" class="row filter-form">
                        <!-- Row 1: Event Name, Event Type, Organizer -->
                        <div class="col-md-2 input">
                            <label for="name" class="form-label">Event name</label>
                            <input type="text" id="name" name="name" value="${previousSearchEventCriteria.name}" class="form-control">
                        </div>

                        <div class="col-md-2 input">
                            <label for="categoryId" class="form-label">Event category</label>
                            <select id="categoryId" name="categoryId" class="form-select">
                                <option value="" selected>Select Category</option>
                                <c:forEach var="category" items="${cateList}">
                                    <option value="${category.id}" ${previousSearchEventCriteria != null && previousSearchEventCriteria.categoryId == category.id ? 'selected' : ''}>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2 input">
                            <label for="organizerId" class="form-label">Organizer</label>
                            <select id="organizerId" name="organizerId" class="form-select">
                                <option value=""selected>Select Organizer</option>
                                <c:forEach var="organizer" items="${organizerList}">
                                    <option value="${organizer.id}" ${previousSearchEventCriteria != null && previousSearchEventCriteria.organizerId == organizer.id ? 'selected' : ''}>
                                        ${organizer.fullname}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <!-- Row 2: Date From, Date To -->
                        <div class="col-md-2 input">
                            <label for="from" class="form-label">From</label>
                            <input type="date" id="from" name="from" value="${previousSearchEventCriteria.from}" class="form-control">
                        </div>

                        <div class="col-md-2 input">
                            <label for="to" class="form-label">To</label>
                            <input type="date" id="to" name="to" value="${previousSearchEventCriteria.to}" class="form-control">
                        </div>

                        <!-- Submit button -->
                        <div class="col-md-1 input d-flex justify-content-center align-items-end">
                            <button type="submit" class="btn element__btn border-yellow find-button">Find</button>
                        </div>
                    </form>
                    <div class="col-md-1">       
                        <div class="notification" >
                            <a id="notifydropdown" href="#">
                                <div class="notification__icon" style="padding-top: 1.5rem">
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

    <!--B?t ??u n?i dung c?a trang ? ?�y-->
    <div class="pb-20">
        <div class="row m-0">
            <div>
                <c:if test="${not empty todayEvents}">
                    <div id="myTabContent" class="today-event-list" style="justify-content: center; align-items: center;">
                        <div class="list-title">
                            <h2 class="section__title pb-30">
                                TODAY
                                <span class="text__highlight"> EVENTS
                                    <svg class="title-underline" width="328" height="31" viewBox="0 0 328 31" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M2 29C110 8.62517 326 -19.8996 326 29" stroke="url(#paint0_linear_47_128)" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                                    <defs>
                                    <linearGradient id="paint0_linear_47_128" x1="2.50784" y1="22.0412" x2="322.486" y2="65.0473" gradientUnits="userSpaceOnUse">
                                    <stop offset="1" stop-color="#F7426F" />
                                    <stop offset="1" stop-color="#F87A58" />
                                    </linearGradient>
                                    </defs>
                                    </svg>
                                </span>
                            </h2>
                        </div>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                                <div class="about__event-thumb w-img mt-40">
                                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="3000"> <!-- Auto slide every 3 seconds -->
                                        <div class="carousel-inner">
                                            <c:forEach var="event" items="${todayEvents}" varStatus="status">
                                                <div class="carousel-item ${status.first ? 'active' : ''}" style="background-image: url('<c:url value="${event.images[0]}"/>');">
                                                    <div class="carousel-caption" style="">
                                                        <h4>${event.fullname}</h4>

                                                        <p class="description-tex today-truncated-text" style="padding: 0 5rem;">
                                                            ${event.description}
                                                        </p>
                                                        <div style="display: flex; justify-content: space-around; margin: 2rem 5rem;">
                                                            <p><strong>Organizer: </strong><span>${event.organizer.fullname}</span></p>
                                                            <div style="margin-bottom: 10px;">
                                                                <span class="event-type"><i class="fa-solid fa-list"></i> ${event.category.name}</span>
                                                            </div>
                                                            <div>
                                                                <p class="location"><i class="fas fa-location-dot"></i> ${event.location.name}</p>
                                                            </div>
                                                        </div>

                                                        <div class="slider__btn">
                                                            <a href="event-detail?eventId=${event.id}">
                                                                View Details
                                                                <svg class="btn-svg-border1 reg-hover-color-none" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path
                                                                    d="M205.374 38.5573C205.374 43.679 202.612 48.6179 197.487 53.1693C192.362 57.7203 184.918 61.8416 175.677 65.3128C157.197 72.2539 131.634 76.5573 103.374 76.5573C75.1136 76.5573 49.5509 72.2539 31.0714 65.3128C21.8298 61.8416 14.3857 57.7203 9.26099 53.1693C4.13572 48.6179 1.37402 43.679 1.37402 38.5573C1.37402 33.4355 4.13572 28.4966 9.26099 23.9452C14.3857 19.3942 21.8298 15.2729 31.0714 11.8017C49.5509 4.86064 75.1136 0.557251 103.374 0.557251C131.634 0.557251 157.197 4.86064 175.677 11.8017C184.918 15.2729 192.362 19.3942 197.487 23.9452C202.612 28.4966 205.374 33.4355 205.374 38.5573Z"
                                                                    stroke="white"
                                                                    />
                                                                </svg>
                                                                <svg class="btn-svg-border2 reg-hover-color-none" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path
                                                                    d="M205.374 38.5573C205.374 43.679 202.612 48.6179 197.487 53.1693C192.362 57.7203 184.918 61.8416 175.677 65.3128C157.197 72.2539 131.634 76.5573 103.374 76.5573C75.1136 76.5573 49.5509 72.2539 31.0714 65.3128C21.8298 61.8416 14.3857 57.7203 9.26099 53.1693C4.13572 48.6179 1.37402 43.679 1.37402 38.5573C1.37402 33.4355 4.13572 28.4966 9.26099 23.9452C14.3857 19.3942 21.8298 15.2729 31.0714 11.8017C49.5509 4.86064 75.1136 0.557251 103.374 0.557251C131.634 0.557251 157.197 4.86064 175.677 11.8017C184.918 15.2729 192.362 19.3942 197.487 23.9452C202.612 28.4966 205.374 33.4355 205.374 38.5573Z"
                                                                    stroke="white"
                                                                    />
                                                                </svg>
                                                                <svg class="btn-svg-border1 reg-hover-color" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path
                                                                    d="M205.374 38.6717C205.374 43.7934 202.612 48.7323 197.487 53.2837C192.362 57.8347 184.918 61.956 175.677 65.4272C157.197 72.3683 131.634 76.6717 103.374 76.6716C75.1136 76.6716 49.5509 72.3682 31.0714 65.4272C21.8298 61.956 14.3857 57.8347 9.26098 53.2837C4.13571 48.7323 1.37402 43.7934 1.37402 38.6716C1.37402 33.5499 4.13571 28.611 9.26098 24.0596C14.3857 19.5086 21.8298 15.3873 31.0714 11.9161C49.5509 4.97503 75.1136 0.671644 103.374 0.671649C131.634 0.671654 157.197 4.97505 175.677 11.9161C184.918 15.3873 192.362 19.5086 197.487 24.0596C202.612 28.611 205.374 33.5499 205.374 38.6717Z"
                                                                    stroke="url(#paint0_linear_42_638)"
                                                                    />
                                                                <defs>
                                                                <linearGradient id="paint0_linear_42_638" x1="103.374" y1="0.171649" x2="103.374" y2="77.1716" gradientUnits="userSpaceOnUse">
                                                                <stop offset="1" stop-color="#F7426F" />
                                                                <stop offset="1" stop-color="#F87A58" />
                                                                </linearGradient>
                                                                </defs>
                                                                </svg>
                                                                <svg class="btn-svg-border2 reg-hover-color" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path
                                                                    d="M205.374 38.6717C205.374 43.7934 202.612 48.7323 197.487 53.2837C192.362 57.8347 184.918 61.956 175.677 65.4272C157.197 72.3683 131.634 76.6717 103.374 76.6716C75.1136 76.6716 49.5509 72.3682 31.0714 65.4272C21.8298 61.956 14.3857 57.8347 9.26098 53.2837C4.13571 48.7323 1.37402 43.7934 1.37402 38.6716C1.37402 33.5499 4.13571 28.611 9.26098 24.0596C14.3857 19.5086 21.8298 15.3873 31.0714 11.9161C49.5509 4.97503 75.1136 0.671644 103.374 0.671649C131.634 0.671654 157.197 4.97505 175.677 11.9161C184.918 15.3873 192.362 19.5086 197.487 24.0596C202.612 28.611 205.374 33.5499 205.374 38.6717Z"
                                                                    stroke="url(#paint0_linear_42_638)"
                                                                    />
                                                                <defs>
                                                                <linearGradient id="paint0_linear_42_6380" x1="103.374" y1="0.171649" x2="103.374" y2="77.1716" gradientUnits="userSpaceOnUse">
                                                                <stop offset="1" stop-color="#F7426F" />
                                                                <stop offset="1" stop-color="#F87A58" />
                                                                </linearGradient>
                                                                </defs>
                                                                </svg>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <!-- Add more items if needed -->
                                        </div>
                                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="sr-only">Previous</span>
                                        </a>
                                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="" id="myTabContent">
                <div class="list-title ml-30 mb-30 mt-30">
                    <h4>Up coming events</h4>

                </div>
                <div class="" id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                    <!-- Event item - Start -->
                    <c:forEach var="data" items="${page.datas}">
                        <c:set var="event" value="${data[1]}" />
                        <c:set var="isFollowing" value="${data[0]}" />
                        <div class="event-list-item clearfix" style="display: flex;
                             margin-bottom: 20px;  position: relative;">
                            <!-- Event Image - Start -->
                            <div class="event-image" style="height: 100%;
                                 position: relative;
                                 width: 30%;">
                                <div class="post-date" style="position: absolute;
                                     top: 10px;
                                     left: 10px;
                                     padding: 5px;">
                                    <small id="date" class="month" style="display: block;">
                                        ${event.dateOfEvent}
                                    </small>
                                </div>
                                <img src="<c:url value="${event.images[0]}"/>" alt="Event Image" style="width: 100%;
                                     height: auto;">
                            </div>
                            <!-- Event Image - End -->
                            <c:if test="${isFollowing == true}">
                                <span class="status__tag bg-green" style="position: absolute; top: 10px; right: 10px;">Following Organizer</span>
                            </c:if>
                            <!-- Event Content - Start -->
                            <div class="event-content" style="width: 70%;
                                 padding-left: 20px;">
                                <h3 class="event-title" style="margin-bottom: 10px;
                                    font-size: 24px;">
                                    ${event.fullname}
                                </h3>
                                <p><strong>Organizer: </strong><span><a href="<c:url value="/profile?role=organizer&id=${event.organizer.id}" />">${event.organizer.fullname}</a></span></p>
                                <p><strong>Register Deadline: </strong><span id="datetime">${event.guestRegisterDeadline}</span></p>
                                <p class="description-text truncated-text">
                                    ${event.description}
                                </p>
                                <div class="event-info-list" style="display: flex;
                                     justify-content: space-between;">
                                    <div style="margin-bottom: 10px;">
                                        <span class="event-type"><i class="fa-solid fa-list"></i> ${event.category.name}</span>
                                    </div>
                                    <div>
                                        <p class="location"><i class="fas fa-location-dot"></i> ${event.location.name}</p>
                                    </div>
                                    <div>
                                        <p><i class="fa-solid fa-user-group"></i> ${event.guestRegisterCount} / ${event.guestRegisterLimit} registered</p>
                                    </div> 
                                    <a class="element__btn border-yellow" href="event-detail?eventId=${event.id}">Details</a>
                                </div>
                            </div>
                            <!-- Event Content - End -->
                        </div>
                        <!-- Event item - End -->
                    </c:forEach>
                </div>
                <!-- Tab panel - End -->
            </div>
            <!-- Tab content - End -->
        </div>
        <!-- row - End -->
        <div>
            <div class="basic__pagination d-flex align-items-center justify-content-end" style="margin-right: 3vw;">
                <nav>
                    <ul>
                        <c:forEach var="i" begin="0" end="${page.totalPage}">
                            <c:choose>
                                <c:when test="${i == 0 && page.currentPage > 0}">
                                    <li>
                                        <a href="home?page=${page.currentPage - 1}&name=${previousSearchEventCriteria.name}&categoryId=${previousSearchEventCriteria.categoryId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">
                                            <i class="fa-regular fa-arrow-left-long"></i>
                                        </a>
                                    </li>
                                </c:when>
                                <c:when test="${i >= page.currentPage && i <= page.currentPage + 4}">
                                    <c:choose>
                                        <c:when test="${i == page.currentPage}">
                                            <li>
                                                <span class="current">${i + 1}</span>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a href="home?page=${i}&name=${previousSearchEventCriteria.name}&categoryId=${previousSearchEventCriteria.categoryId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">${i + 1}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                    <li> ... </li>
                                    </c:when>
                                    <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                    <li>
                                        <a href="home?page=${page.totalPage - 1}&name=${previousSearchEventCriteria.name}&categoryId=${previousSearchEventCriteria.categoryId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">
                                            ${page.totalPage}
                                        </a>
                                    </li>
                                </c:when>
                                <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                    <li>
                                        <a href="home?page=${page.currentPage + 1}&name=${previousSearchEventCriteria.name}&categoryId=${previousSearchEventCriteria.categoryId}&organizerId=${previousSearchEventCriteria.organizerId}&from=${previousSearchEventCriteria.from}&to=${previousSearchEventCriteria.to}">
                                            <i class="fa-regular fa-arrow-right-long"></i>
                                        </a>
                                    </li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </nav>
            </div>
        </div>
        <!-- K?t th�c n?i dung c?a trang -->
    </div>
</section>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<%@include file="include/master-footer.jsp" %>