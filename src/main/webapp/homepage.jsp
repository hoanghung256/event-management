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
        background-color: rgba(0, 0, 0, 0.3);
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


    /* Input fields and select dropdown */
    .input .form-control,
    .input .form-select {
        border: 1px solid #ced4da;
        border-radius: 4px;
        padding: 10px;
        transition: all 0.3s ease;
    }

    .input .form-control:focus,
    .input .form-select:focus {
        border-color: #F7C442;
        box-shadow: 0px 0px 8px rgba(92, 107, 192, 0.5);
        outline: none;
    }

    /* Labels */
    .form-label {
        font-weight: 500;
        color: #495057;
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
                <div class="col-md-12 d-flex" >
                    <form action="home" method="GET" class="row filter-form">
                        <!-- Row 1: Event Name, Event Type, Organizer -->
                        <div class="col-md-2 input">
                            <label for="name" class="form-label">Event name</label>
                            <input type="text" id="name" name="name" value="${previousSearchEventCriteria.name}" class="form-control" placeholder="Event Name...">
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
                        <div class="notification"  >
                            <a style="color: gray;" class="text-center" id="notifydropdown" href="#" >

                                <i style="width: 40px; padding-top: 2rem; font-size: 1.75rem;" class="fa-regular fa-bell"></i>

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
                                    <p><strong>Organizer: </strong><span><a class="acolor" href="<c:url value="/profile?role=organizer&id=${event.organizer.id}" />">${event.organizer.fullname}</a></span></p>
                                <p><strong>Register Deadline: </strong><span id="date">${event.guestRegisterDeadline}</span></p>
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