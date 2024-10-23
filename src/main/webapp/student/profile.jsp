<%@include file="../include/student-layout-header.jsp"%>

<style>
    /* C?u trúc chính */
    .profile__main-wrapper {
        text-align: center;
        background-color: #f0f4f7;
        height: 560px;
        border-radius: 10px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* ?? bóng */
    }

    .profile__thumb {
        margin: 0 auto 20px auto;
        position: relative;
    }

    .profile__thumb img {
        border-radius: 50%;
        width: 180px;
        height: 180px;
        object-fit: cover;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.8); /* ?? bóng ??m h?n */
        transition: transform 0.3s ease; /* Hi?u ?ng phóng to khi hover */
    }

    .profile__thumb img:hover {
        transform: scale(1.3); /* Phóng to nh? khi hover */
    }

    .profile__user-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 15px;
        border-radius: 8px;
        background-color: #ffffff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        transition: background-color 0.3s ease; /* Hi?u ?ng chuy?n màu n?n */
    }



    .profile__user-tiitle {
        font-weight: bold;
        color: #444;
        flex-basis: 35%;
    }

    .profile__user-info {
        font-size: 20px;
        color: #666;
        text-align: left;
        flex-basis: 60%;
    }

    .change-password-section {
        margin-top: 40px;
    }

    .unfield__input-btn {
        padding: 12px 24px;
        background-color: #ff7b54; /* Màu cam n?i b?t */
        color: #fff;
        font-size: 16px;
        border-radius: 8px;
        border: none;
        transition: background-color 0.3s;
        cursor: pointer;
    }

    .unfield__input-btn:hover {
        background-color: #ff5722;
    }

    .profile__about-info {
        padding : 20px;
        max-width: 650px;
        height: 300px;
        margin: 0 auto;
        background-color: #f0f4f7;
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
        background-color: rgba(0, 0, 0, 0.6); /* N?n t?i h?n */
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        background-color: #fff;
        padding: 25px;
        border-radius: 10px;
        width: 400px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* ?? bóng rõ h?n */
        position: relative;
    }

    .close {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 24px;
        font-weight: bold;
        color: #999;
        cursor: pointer;
    }

    .close:hover {
        color: #333;
    }

    .form-group input {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
    }

    .form-group input:focus {
        border-color: #ff5722;
        box-shadow: 0 0 5px rgba(255, 87, 34, 0.5); /* Highlight khi focus */
    }

    .profile__thumb {
        position: relative;
        margin: 0 auto 20px auto;
    }

    .profile__thumb img {
        border-radius: 50%;
        width: 180px;
        height: 180px;
        object-fit: cover;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.8);
        transition: transform 0.3s ease;
    }

    .profile__thumb {
        position: relative;
        margin: 0 auto 20px auto;
    }

    .profile__thumb img {
        border-radius: 50%;
        width: 180px;
        height: 180px;
        object-fit: cover;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.8);
        transition: transform 0.3s ease;
    }
    .input-row {
        display: flex;
        justify-content: space-between;
    }

    .input-row .singel__input-field {
        flex: 1; 
        margin-right: 10px; 
    }

    .input-row .singel__input-field:last-child {
        margin-right: 0; 
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
                                    <li><span><a href="<c:url value='/home' />">Home</a></span></li>
                                    <li class="active"><span>Profile</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="userInfor">
            <div class="profile__main-wrapper mt-35">
                <div class="profile__thumb">
                    <form style="padding-top: 10px;"action="<c:url value='/student/profile' />" method="POST" enctype="multipart/form-data">
                        <input type="file" name="avatar" accept="image/*" id="avatarInput" style="display: none;" onchange="this.form.submit()"> 
                        <img src="${pageContext.request.contextPath}${sessionScope.userInfor.avatarPath != null ? sessionScope.userInfor.avatarPath : defaultAvatar}" alt="Profile Image" class="avatar-img" id="avatar" onclick="document.getElementById('avatarInput').click()"> <!-- Khi nh?n vào avatar thì m? h?p tho?i ch?n file -->
                    </form>
                </div>
                <div class="profile__about-info">
                    <ul>
                        <li class="profile__user-item">
                            <div class="profile__user-tiitle">
                                <span>Full Name:</span>
                            </div>
                            <div class="profile__user-info">
                                <span>${sessionScope.userInfor.fullname}</span>
                            </div>
                        </li>
                        <li class="profile__user-item">
                            <div class="profile__user-tiitle">
                                <span>Email  :</span>
                            </div>
                            <div class="profile__user-info">
                                <span>${sessionScope.userInfor.email}</span>
                            </div>
                        </li>
                        <div class="input-row mb-15">
                            <li class="profile__user-item singel__input-field">
                                <div class="profile__user-tiitle">
                                    <span>Student ID:</span>
                                </div>
                                <div class="profile__user-info">
                                    <span>${sessionScope.userInfor.studentId}</span>
                                </div>
                            </li>
                            <li class="profile__user-item singel__input-field">
                                <div class="profile__user-tiitle">
                                    <span>Gender:</span>
                                </div>
                                <div class="profile__user-info">
                                   <span>${sessionScope.userInfor.gender}</span>
                                </div>
                            </li>
                        </div>
                    </ul>
                    <div class="change-password-section">
                        <button class="unfield__input-btn" style="margin-left: 210px;
                                height:40px;"type="button" id="changePasswordBtn">
                            <i class="flaticon-lock"></i> Change Password
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal thay ??i m?t kh?u -->
    <div id="changePasswordModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Change Password</h3>
            <form action="<c:url value='/student/change-password' />" method="POST">
                <div class="form-group">
                    <input type="password" name="currentPassword" placeholder="Current Password" required>
                </div>
                <div class="form-group">
                    <input type="password" name="newPassword" placeholder="New Password" required>
                </div>
                <div class="form-group">
                    <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <br>
                <button class="unfield__input-btn" style="margin-left: 90px;
                        padding-top: 10px;" type="submit">Change Password</button>
            </form>
        </div>
    </div>
</section>

<script>
    function openModal() {
        document.getElementById("changeAvatarModal").style.display = "flex"; // M? modal cho avatar
    }

    function closeModal() {
        document.getElementById("changeAvatarModal").style.display = "none"; // ?óng modal
    }

    document.addEventListener("DOMContentLoaded", function () {
        var changePasswordModal = document.getElementById("changePasswordModal");
        var changePasswordBtn = document.getElementById("changePasswordBtn");
        var changePasswordSpan = document.getElementsByClassName("close")[0];

        changePasswordBtn.onclick = function () {
            changePasswordModal.style.display = "flex";
        }

        changePasswordSpan.onclick = function () {
            changePasswordModal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == changePasswordModal) {
                changePasswordModal.style.display = "none";
            }
            if (event.target == document.getElementById("changeAvatarModal")) {
                closeModal(); // ?óng modal cho avatar
            }
        }
    });
</script>


<%@include file="../include/master-footer.jsp"%>
