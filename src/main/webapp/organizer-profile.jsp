<%-- 
    Document   : organier-profile
    Created on : Oct 3, 2024, 10:19:13?PM
    Author     : TuDK
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
    <c:when test="${sessionScope.userInfor.role == 'CLUB'}">
        <%@include file="include/club-layout-header.jsp"%>
    </c:when>
    <c:when test="${sessionScope.userInfor.role == 'ADMIN'}">
        <%@include file="include/admin-layout-header.jsp"%>
    </c:when>
    <c:otherwise>
        <%@include file="include/student-layout-header.jsp"%>
    </c:otherwise>
</c:choose>

<style>
    .profile__about-info {
        margin: 20px 0;
    }

    .profile__title {
        display: block; 
        font-size: 24px; 
        font-weight: bold;
        margin-bottom: 10px;
        color: var(--clr-text-secondary);
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
                                    <c:choose>
                                        <c:when test="${sessionScope.userInfor.role == 'STUDENT'}">
                                            <li><span><a class="acolor" href="<c:url value="/home" />">Home</a></span></li>
                                        </c:when>
                                        <c:when test="${sessionScope.userInfor.role == 'ADMIN'}">
                                            <li><span><a class="acolor" href="<c:url value="/admin/dashboard" />">Dashboard</a></span></li>
                                        </c:when>
                                        <c:when test="${sessionScope.userInfor.role == 'CLUB'}">
                                            <li><span><a class="acolor" href="<c:url value="/club/dashboard" />">Dashboard</a></span></li>
                                        </c:when>
                                    </c:choose>
                                    <li class="active"><span>Profile</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Bat dau content cua page o day-->

        <div class="mb-15">
            <div class="banner-container" style="overflow: hidden; height: 300px; object-fit: cover;border-radius: 10px; ">
                <div style="width: 100%;height: 300px; position: relative;">
                    <img src="<c:url value="${organizer.coverPath}" />" alt="Banner" style="width: 100%; height: 100%; object-fit: cover;"  />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xxl-12">
                <div class="profile__area">
                    <div class="body__card-wrapper mb-20">
                        <div class="">
                            <div class="card__title-inner d-flex justify-content-between">
                                <h4 class="event__information-title">Profile Information</h4>
                                <div>
                                    <form action="<c:url value="/student/follow"/>" method="POST">
                                        <input type="hidden" name="organizerId" value="${organizer.id}">
                                        <c:choose>
                                            <c:when test="${isFollowing == true}">
                                                <input type="hidden" name="action" value="unfollow">
                                                <button type="submit" class="btn btn-danger">Unfollow</button>
                                            </c:when>

                                            <c:when test="${isFollowing == false}">
                                                <input type="hidden" name="action" value="follow">
                                                <button type="submit" class="btn btn-primary">Follow</button>
                                            </c:when>
                                        </c:choose>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="review__tab">
                            <nav>
                                <div class="nav nav-tabs mb-10" id="nav-tab" role="tablist">
                                    <button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true">About</button>
                                    <button class="nav-link" id="nav-recent-event-tab" data-bs-toggle="tab" data-bs-target="#nav-recent-event" type="button" role="tab" aria-controls="nav-recent-event" aria-selected="false">Recently</button>
                                </div>
                            </nav>
                            <div class="tab-content" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                                    <div class="profile__main-wrapper mt-35">
                                        <div class="row">
                                            <div class="col-xxl-4 col-xl-5 col-lg-6 col-md-6">
                                                <div class="profile__left p-2">

                                                    <div class="padding__left-inner p-relative">
                                                        <div class="profile__thumb mb-45 text-center">
                                                            <div style="width: 190px; height: 190px; position: relative; border-radius: 50%; margin: 0 auto;">
                                                                <img src="<c:url value="${organizer.avatarPath}" />" alt="Avatar" 
                                                                     style="width: 100%; height: 100%; object-fit: cover; object-position: center; border-radius: 50%;" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="profile__user">
                                                        <ul>
                                                            <li>
                                                                <div class="profile__user-item">
                                                                    <div class="profile__user-tiitle" style="display: flex; align-items: center;">
                                                                        <span>Club Name:</span>
                                                                    </div>
                                                                    <div class="profile__user-info">
                                                                        <span>${organizer.fullname}</span>
                                                                    </div>
                                                                </div>
                                                            </li>

                                                            <li>
                                                                <div class="profile__user-item">
                                                                    <div class="profile__user-tiitle" style="display: flex; align-items: center;">
                                                                        <span>Club Acronym:</span>
                                                                    </div>
                                                                    <div class="profile__user-info">
                                                                        <span>${organizer.acronym}</span> 
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="profile__user-item">
                                                                    <div class="profile__user-tiitle" style="display: flex; align-items: center;">
                                                                        <span>Email Address:</span>
                                                                    </div>
                                                                    <div class="profile__user-info">
                                                                        <span>${organizer.email}</span>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xxl-8 col-xl-7 col-lg-6 col-md-6">
                                                <div class="profile__right p-relative ml-20">
                                                    <div class="profile__about-info">
                                                        <span class="profile__title">About Us</span>
                                                        <div class="profile__text">
                                                            <p class="profile-description mb-25">${organizer.description}</p> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="nav-recent-event" role="tabpanel" aria-labelledby="nav-recent-event-tab" tabindex="0">
                                    <c:if test="${not empty recentEvents}">
                                        <c:forEach var="event" items="${recentEvents}">
                                            <div class="event-list-item clearfix" style="display: flex; margin-bottom: 20px;">
                                                <!-- Event Image - Start -->
                                                <div class="event-image" style="height: 100%; position: relative; width: 30%;">
                                                    <div class="post-date" style="position: absolute; top: 10px; left: 10px; padding: 5px;">
                                                        <small id="date" class="month" style="display: block;">
                                                            ${event.dateOfEvent}
                                                        </small>
                                                    </div>
                                                    <img src="<c:url value="${event.images[0]}" />" alt="Event Image" style="width: 100%; height: auto;">
                                                </div>
                                                <!-- Event Image - End -->

                                                <!-- Event Content - Start -->
                                                <div class="event-content" style="width: 70%; padding-left: 20px;">
                                                    <h3 class="event-title" style="margin-bottom: 10px; font-size: 24px;">
                                                        ${event.fullname}
                                                    </h3>
                                                    <p>Register deadline: <span id="datetime">${event.registerDeadline}</span></p>
                                                    <p class="description-text truncated-text">
                                                        ${event.description}
                                                    </p>
                                                    <div class="event-info-list" style="display: flex; justify-content: space-between;">
                                                        <div style="margin-bottom: 10px;">
                                                            <span class="event-type"><i class="fa-solid fa-list"></i> ${event.category.name}</span>
                                                        </div>
                                                        <div>
                                                            <p class="location"><i class="fas fa-location-dot"></i> ${event.location.name}</p>
                                                        </div>
                                                        <c:if test="${event.guestRegisterCount > 0}">
                                                            <div>
                                                                <p><i class="fa-solid fa-user-group"></i>${event.guestRegisterCount} attended</p>
                                                            </div> 
                                                        </c:if>
                                                        <a class="element__btn border-yellow" href="event-detail?eventId=${event.id}">Details</a>
                                                    </div>
                                                </div>
                                                <!-- Event Content - End -->
                                            </div>
                                            <!-- Event item - End -->
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty recentEvents}">
                                        <p>Non Event Recently.</p> 
                                    </c:if>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

</section>

<%@include file="../include/master-footer.jsp" %>