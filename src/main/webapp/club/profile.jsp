<%-- 
    Document   : profile
    Created on : Oct 3, 2024, 10:19:13?PM
    Author     : Administrator
--%>
<!doctype html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/club-layout-header.jsp"%>

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
                                    <li><span><a href="home">Home</a></span></li>
                                    <li class="active"><span>Club-Profile</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Bat dau content cua page o day-->

        <div class="mb-25">
            <div class="banner-container">
                <img src="https://scontent.fdad3-5.fna.fbcdn.net/v/t39.30808-6/376251256_791462792989198_2157449619517553064_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=86c6b0&_nc_ohc=L9EVE4y_HfUQ7kNvgFAA9c1&_nc_ht=scontent.fdad3-5.fna&_nc_gid=AARf0CXRXgELxPQ-y5xelu2&oh=00_AYAGXoeLHhlfut7DrQlCtEEcq23R4UFlihffJHpdkauMmg&oe=67053164" alt="image not found" style="width: 100%; height: 200">
            </div>
        </div>

        <div class="row">
            <div class="col-xxl-12">
                <div class="profile__area">
                    <div class="body__card-wrapper mb-20">
                        <div class="">
                            <div class="card__title-inner">
                                <h4 class="event__information-title">Profile Information</h4>
                                <c:choose>

                                    <c:when test="${canFollow}">
                                        <c:choose>
                                           
                                            <c:when test="${hasFollowed}">
                                                
                                                <form action="${pageContext.request.contextPath}/OrganizerProfileController" method="post">
                                                    <input type="hidden" name="organizerId" value="${org.id}">
                                                    <input type="hidden" name="action" value="unfollow">
                                                    <button type="submit" class="btn btn-danger">Followed</button>
                                                </form>
                                            </c:when>
                                           
                                            <c:otherwise>
                                              
                                                <form action="${pageContext.request.contextPath}/OrganizerProfileController" method="post">
                                                    <input type="hidden" name="organizerId" value="${org.id}">
                                                    <input type="hidden" name="action" value="follow">
                                                    <button type="submit" class="btn btn-primary">Follow</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
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
                                                <div class="profile__left">

                                                    <div class="padding__left-inner p-relative">
                                                        <div class="profile__thumb mb-45">
                                                            <img src="assets/img/speaker/list/04.jpg" alt="image not found"> 
                                                        </div>
                                                        <% if ((Boolean) request.getAttribute("canEdit")) { %>
                                                        <div class="profile__edit" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                                            <i class="flaticon-edit"></i>
                                                        </div>
                                                        <% } %>
                                                        <div class="profile__user">
                                                            <ul>
                                                                <li>
                                                                    <div class="profile__user-item">
                                                                        <div class="profile__user-tiitle">
                                                                            <span>Club Name:</span>
                                                                        </div>
                                                                        <div class="profile__user-info">
                                                                            <span>${org.fullname}</span>
                                                                        </div>
                                                                    </div>
                                                                </li>

                                                                <li>
                                                                    <div class="profile__user-item">
                                                                        <div class="profile__user-tiitle">
                                                                            <span>Club Acronym:</span>
                                                                        </div>
                                                                        <div class="profile__user-info">
                                                                            <span>${org.acronym}</span> 
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="profile__user-item">
                                                                        <div class="profile__user-tiitle">
                                                                            <span>Email Address:</span>
                                                                        </div>
                                                                        <div class="profile__user-info">
                                                                            <span>${org.email}</span>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xxl-8 col-xl-7 col-lg-6 col-md-6">
                                                <div class="profile__right p-relative ml-20">
                                                    <div class="profile__about-info">
                                                        <span class="profile__title">About Us</span>
                                                        <div class="profile__text">
                                                            <p class="profile-description mb-25">${org.description}</p> 
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
                                                    <img src="assets/img/event/event-details.jpg" alt="Event Image" style="width: 100%; height: auto;">
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
                                                            <span class="event-type"><i class="fa-solid fa-list"></i> ${event.type.name}</span>
                                                        </div>
                                                        <div>
                                                            <p class="location"><i class="fas fa-location-dot"></i> ${event.location.description}</p>
                                                        </div>
                                                        <div>
                                                            <p><i class="fa-solid fa-user-group"></i> ${event.guestRegisterLimit}/${event.guestRegisterLimit} Registered</p>
                                                        </div> 
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
    </div>
</section>
<div class="modal" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true" data-bs-backdrop="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body popup-tab-content">
                <form id="editProfileForm" method="post" action="OrganizerProfileController">
                    <input type="hidden" name="organizerId" value="${org.id}">
                    <div class="mb-3">
                        <label for="clubName" class="form-label">Club Name</label>
                        <input type="text" class="form-control" id="clubName" name="fullname" value="${org.fullname}">
                    </div>
                    <div class="mb-3">
                        <label for="clubAcronym" class="form-label">Club Acronym</label>
                        <input type="text" class="form-control" id="clubAcronym" name="acronym" value="${org.acronym}">
                    </div>
                    <div class="mb-3">
                        <label for="clubEmail" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="clubEmail" name="email" value="${org.email}">
                    </div>
                    <div class="mb-3">
                        <label for="clubDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="clubDescription" name="description">${org.description}</textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary"  form="editProfileForm" id="saveChanges">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector('.profile__edit').addEventListener('click', function () {
        const myModal = new bootstrap.Modal(document.getElementById('editProfileModal'));
        myModal.show();
    });

    document.getElementById('editProfileModal').addEventListener('hidden.bs.modal', function () {
        document.body.style.overflow = '';
    });
</script>






<%@include file="../include/master-footer.jsp" %>