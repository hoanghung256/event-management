<%-- 
    Document   : profile
    Created on : Oct 3, 2024, 10:19:13?PM
    Author     : Administrator
--%>
<!doctype html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../include/club-layout-header.jsp"%>
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

    .avatar-edit-btn {
        position: absolute;
        bottom: 0px;
        right: 0px;
        background-color: rgba(0, 0, 0, 0.5);
        border: none;
        color: white;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease;
        z-index: 2;
    }

    .avatar-edit-btn:hover {
        background-color: rgba(0, 0, 0, 0.7);
    }

    .banner-container {
        position: relative;
        display: inline-block;
        width: 100%;
        height: 300px;
        overflow: hidden;
    }

    .cover-edit-btn {
        position: absolute;
        bottom: 10px;
        right: 10px;
        background-color: rgba(0, 0, 0, 0.5);
        border: none;
        color: white;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease;
        z-index: 2;
    }

    .cover-edit-btn:hover {
        background-color: rgba(0, 0, 0, 0.7);
    }


    .profile__about-info {
        margin: 20px 0; /* Kho?ng c�ch tr�n/d??i */
    }

    .profile__title {
        display: block; /* Hi?n th? ti�u ?? d??i d?ng kh?i */
        font-size: 24px; /* K�ch th??c ch? */
        font-weight: bold; /* ??m ch? */
        margin-bottom: 10px; /* Kho?ng c�ch gi?a ti�u ?? v� textarea */
        color: var(--clr-text-secondary); /* M�u ch? ti�u ?? */
    }

    .singel__input-field textarea {
        display: block;
        height: 55px; /* Chi?u cao m?c ??nh */
        width: 100%;
        border: 1px solid var(--clr-border-4);
        padding: 15px;
        border-radius: 4px;
        background: var(--clr-bg-11);
        color: var(--clr-text-secondary);
        transition: border-color 0.3s; /* Hi?u ?ng chuy?n ??i m�u bi�n */
    }

    .singel__input-field textarea:focus {
        border-color: var(--clr-theme-1); /* M�u bi�n khi textarea ???c ch?n */
    }

    [bd-theme=bd-theme-dark] .singel__input-field textarea {
        background: var(--clr-bg-6);
        border-color: var(--clr-border-1);
    }

    [bd-theme=bd-theme-dark] .singel__input-field textarea:focus {
        border-color: var(--clr-common-white);
    }

    .popup__update textarea:active {
        color: var(--clr-text-9);
    }

    .singel__input-field.is-color-change textarea {
        color: var(--clr-text-9);
    }

    /* Modal Styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);

        justify-content: center;
        align-items: center;
    }/*
    */
    .modal-content {
        background-color: #fefefe;
        padding: 20px;
        border-radius: 10px;
        width: 400px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        position: relative;
    }
    .close {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 28px;
        font-weight: bold;
        color: #aaa;
        cursor: pointer;
    }
    .close:hover {
        color: #333;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

</style>

<section>
    <div class="app__slide-wrapper">
        <form id="editProfileForm" method="post" action="${pageContext.request.contextPath}/club/profile" enctype="multipart/form-data">
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
                                        <li><span><a href="<c:url value="/club/dashboard" />">Dashboard</a></span></li>
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
                    <div class="banner-container" style="overflow: hidden; height: 300px; object-fit: cover; border-radius: 10px; position: relative;">
                        <c:url value="/assets/img/user/banner-default.png" var="defaultBanner" />
                        <c:url value="${sessionScope.userInfor.coverPath}" var="userBanner" />
                        <input type="file" class="form-control" id="coverFile" name="coverFile" style="display: none;" accept="image/*">
                        <img src="${sessionScope.userInfor.coverPath != null ? userBanner : defaultBanner}" alt="Banner" 
                             style="width: 100%; height: 100%; object-fit: cover;" 
                             id="currentBanner">
                        <img id="newBannerPreview" 
                             style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0; display: none;">
                        <button type="button" class="cover-edit-btn" onclick="document.getElementById('coverFile').click();">
                            <i class="flaticon-edit"></i>
                        </button>
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
                                                                <div style="width: 190px; height: 190px; position: relative; border-radius: 50%; margin: 0 auto;">
                                                                    <c:url value="/assets/img/user/default-avatar.jpg" var="defaultAvatar" />
                                                                    <c:url value="${sessionScope.userInfor.avatarPath}" var="userAvatar" />
                                                                    <input type="file" class="form-control" id="avatarFile" name="avatarFile" style="display: none;" accept="image/*">
                                                                    <img src="${sessionScope.userInfor.avatarPath != null ? userAvatar : defaultAvatar}" alt="Avatar" 
                                                                         style="width: 100%; height: 100%; object-fit: cover; object-position: center; border-radius: 50%;" 
                                                                         id="currentAvatar">
                                                                    <img id="newAvatarPreview" 
                                                                         style="width: 100%; height: 100%; object-fit: cover; object-position: center; display: none; border-radius: 50%;">
                                                                    <button type="button" class="avatar-edit-btn" onclick="document.getElementById('avatarFile').click();">
                                                                        <i class="flaticon-edit"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="profile__user">
                                                            <ul>
                                                                <li>
                                                                    <div class="profile__user-item" style=" column-gap: 0;">
                                                                        <div class="profile__user-tiitle" style="display: flex; align-items: center;">
                                                                            <label class="input__field-text">Club Name:</label>
                                                                        </div>
                                                                        <div class="singel__input-field">
                                                                            <input type="text" style="height: 40px;" name="fullname" value="${param.fullname != null ? param.fullname : userInfor.fullname}" required />
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="profile__user-item" style=" column-gap: 0;" >
                                                                        <div class="profile__user-tiitle" style="display: flex; align-items: center;">
                                                                            <label class="input__field-text">Club Acronym:</label>
                                                                        </div>
                                                                        <div class="singel__input-field">
                                                                            <input type="text" style="height: 40px;" name="acronym" value="${param.acronym != null ? param.acronym : userInfor.acronym}" required />
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="profile__user-item" style=" column-gap: 0;">
                                                                        <div class="profile__user-tiitle" style="display: flex; align-items: center;">
                                                                            <label class="input__field-text">Email Address:</label>
                                                                        </div>
                                                                        <div class="singel__input-field">
                                                                            <input type="email" style="height: 40px;" name="email" value="${param.email != null ? param.email : userInfor.email}" required />
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
                                                            <div class="singel__input-field p-3">
                                                                <textarea id="description"  name="description"  style="padding: 10px; width: 100%; overflow: hidden; resize: none; outline: none;" 
                                                                          oninput="this.style.height = 'auto'; this.style.height = (this.scrollHeight) + 'px';" 
                                                                          required>${userInfor.description}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div style="padding-left: 40px;">
                                                    <c:if test="${not empty error}">
                                                        <div class="error-message" style="  color: red; margin-bottom: 15px;">${error}</div>
                                                        <script>
                                                            document.getElementById('changePasswordModal').style.display = 'flex';
                                                        </script>
                                                    </c:if>
                                                    <c:if test="${not empty success}">
                                                        <div class="error-message" style="color: green; margin-bottom: 15px;">${success}</div>
                                                        <script>
                                                            document.getElementById('changePasswordModal').style.display = 'flex';
                                                        </script>
                                                    </c:if>
                                                            </div>
                                                    <div class="change-password-section" style=" text-align: right; margin-right: 25px;">
                                                        <button type="button" class="element__btn border-yellow" id="changePasswordBtn" style="padding:5px; height: 45px; margin-right: 20px;">Change Password</button>
                                                        <button type="submit" class="element__btn border-yellow" style="padding:5px; height: 45px;">Save Changes</button>
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
                                                            <a class="element__btn border-yellow" href="<c:url value="/club/organized-event-report?eventIdDetail=${event.id}&organizerId=${event.organizer.id}&action=detail"/> "> Details</a>
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
    <div id="changePasswordModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Change Password</h3>
            <form action="<c:url value='/club/change-password' />" method="POST" id="changePasswordForm">
                <div class="form-group">
                    <input type="password" name="currentPassword" placeholder="Current Password" required>
                </div>
                <div class="form-group">
                    <input type="password" name="newPassword" placeholder="New Password" required>
                </div>
                <div class="form-group">
                    <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <button class="unfield__input-btn" type="submit">Change Password</button>
            </form>
        </div>
    </div>
</section>



<script>
    //preview banner
    document.getElementById('coverFile').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const currentBanner = document.getElementById('currentBanner');
                const newBannerPreview = document.getElementById('newBannerPreview');
                newBannerPreview.src = e.target.result;
                newBannerPreview.style.display = 'block';
                newBannerPreview.style.opacity = '0';
                currentBanner.style.opacity = '1';
                setTimeout(() => {
                    currentBanner.style.opacity = '0';
                    newBannerPreview.style.opacity = '1';
                    currentBanner.style.display = 'none';
                }, 100); // Adjust timing for smooth transition
            }
            reader.readAsDataURL(file);
        }
    });
    // preview avatar
    document.getElementById('avatarFile').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const currentAvatar = document.getElementById('currentAvatar');
                const newAvatarPreview = document.getElementById('newAvatarPreview');
                newAvatarPreview.src = e.target.result;
                newAvatarPreview.style.display = 'block';
                newAvatarPreview.style.opacity = '0';
                currentAvatar.style.opacity = '1';

                setTimeout(() => {
                    currentAvatar.style.opacity = '0';
                    newAvatarPreview.style.opacity = '1';
                    currentAvatar.style.display = 'none';
                }, 100); // Adjust timing for smooth transition
            }
            reader.readAsDataURL(file);
        }
    });
    // change pass modal
    document.addEventListener("DOMContentLoaded", function () {
        var modal = document.getElementById("changePasswordModal");
        var btn = document.getElementById("changePasswordBtn");
        var span = document.getElementsByClassName("close")[0];
        btn.onclick = function () {
            modal.style.display = "flex";
        }
        span.onclick = function () {
            modal.style.display = "none";
        }
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });
</script>
<script>
    // auto change height description
    const textarea = document.getElementById('description');
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight + 'px';
</script>
<%@include file="../include/master-footer.jsp" %>