<%-- 
    Document   : profile
    Created on : Oct 3, 2024, 10:19:13?PM
    Author     : Administrator
--%>
<!doctype html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../include/admin-layout-header.jsp"%>
<style>

    @keyframes popupFadeIn {
        from {
            opacity: 0;
            transform: scale(0.8);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }


</style>

<section>
    <div class="app__slide-wrapper">
        <form id="editProfileForm" method="post" action="${pageContext.request.contextPath}/admin/profile" enctype="multipart/form-data">
            <div class="breadcrumb__area">
                <div class="breadcrumb__wrapper mb-20">
                    <div class="breadcrumb__main">
                        <div class="breadcrumb__inner">
                            <div class="breadcrumb__icon">
                                <i class="flaticon-home"></i>
                            </div>
                            <div class="breadcrumb__menu">
                                <nav>
                                    <ul>
                                        <li><span><a href="<c:url value="/admin/dashboard" />">Dashboard</a></span></li>
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
                        <input type="file" class="form-control" id="coverFile" name="coverFile" style="display: none;" accept="image/*">
                        <img src="../${org.coverPath}" alt="Current Banner" style="width: 100%; height: 100%; object-fit: cover; cursor: pointer;" id="currentBanner" onclick="document.getElementById('coverFile').click();">
                        <img id="newBannerPreview" style="width: 100%; height: 100%; object-fit: cover;position: absolute;  display: none;">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xxl-12">
                    <div class="profile__area">
                        <div class="body__card-wrapper mb-20">
                            <div class="">
                                <div class="card__title-inner">
                                    <h4 class="event__information-title">Profile Information</h4>

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
                                                                <div style="width: 190px; height: 190px; position: relative; border-radius: 50%; overflow: hidden; margin: 0 auto;">
                                                                    <input type="file" class="form-control" id="avatarFile" name="avatarFile" style="display: none;" accept="image/*">
                                                                    <img src="../${org.avatarPath}" alt="Current Avatar" 
                                                                         style="width: 100%; height: 100%; object-fit: cover; object-position: center; cursor: pointer; border-radius: 50%;" 
                                                                         id="currentAvatar" 
                                                                         onclick="document.getElementById('avatarFile').click();">
                                                                    <img id="newAvatarPreview" 
                                                                         style="width: 100%; height: 100%; object-fit: cover; object-position: center; display: none; cursor: pointer; border-radius: 50%;" 
                                                                         onclick="document.getElementById('avatarFile').click();">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="profile__user">
                                                            <ul>
                                                                <li>
                                                                    <div class="profile__user-item" style="width: 90%;">
                                                                        <div class="profile__user-tiitle">
                                                                            <span>Club Name:</span>
                                                                        </div>
                                                                        <div class="profile__user-info" >
                                                                            <input type="text" name="fullname" value="${param.fullname != null ? param.fullname : org.fullname}" required/>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="profile__user-item" style="width: 90%;">
                                                                        <div class="profile__user-tiitle">
                                                                            <span>Club Acronym:</span>
                                                                        </div>
                                                                        <div class="profile__user-info">
                                                                            <input type="text" name="acronym" value="${param.acronym != null ? param.acronym : org.acronym}" required/>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="profile__user-item" style="width: 90%;">
                                                                        <div class="profile__user-tiitle">
                                                                            <span>Email Address:</span>
                                                                        </div>
                                                                        <div class="profile__user-info">
                                                                            <input type="email" name="email" value="${param.email != null ? param.email : org.email}" required />
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
                                                            <div class="profile__text p-3">
                                                                <textarea id="description" class="yellow-bg" name="description"  style="padding: 10px; width: 100%; overflow: hidden; resize: none; outline: none;" 
                                                                          oninput="this.style.height = 'auto'; this.style.height = (this.scrollHeight) + 'px';" 
                                                                          required>${org.description}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div style=" text-align: right; margin-right: 25px;">
                                                        <button type="submit" class="element__btn yellow-bg">Save Changes</button>
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
                                                                <span class="category"><i class="fa-solid fa-list"></i> ${event.category.name}</span>
                                                            </div>
                                                            <div>
                                                                <p class="location"><i class="fas fa-location-dot"></i> ${event.location.name}</p>
                                                            </div>
                                                            <div>
                                                                <p><i class="fa-solid fa-user-group"></i> ${event.guestRegisterLimit}/${event.guestRegisterLimit} Registered</p>
                                                            </div> 
                                                            <a class="element__btn border-yellow" href="<c:url value="/admin/organized-event-report?eventIdDetail=${event.id}&organizerId=${event.organizer.id}&action=detail"/> "> Details</a>
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
        </form>
    </div>
</section>



<script>
    document.getElementById('coverFile').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('newBannerPreview').src = e.target.result;
                document.getElementById('newBannerPreview').style.display = 'block';
                document.getElementById('currentBanner').style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });
    document.getElementById('avatarFile').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const newAvatarPreview = document.getElementById('newAvatarPreview');
                newAvatarPreview.src = e.target.result;
                newAvatarPreview.style.display = 'block';
                newAvatarPreview.style.margin = '0 auto';
                document.getElementById('currentAvatar').style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });
</script>
<script>
    const textarea = document.getElementById('description');
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight + 'px';
</script>
<%@include file="../include/master-footer.jsp" %>