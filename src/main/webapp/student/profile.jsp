<%@include file="../include/student-layout-header.jsp"%>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">


<style>
    /* C?u trúc chính */
    .profile__main-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-bottom: 15px;
        max-width: 700px;
        max-height: 900px;
        margin: auto;
        border-radius: 15px;
        background:  linear-gradient(145deg, #f0f8fff8ff, #e6f7ff);
        box-shadow: 0px 5px 25px rgba(0, 0, 0, 0.1);
    }
    .profile__thumb {
        position: relative;
        background-image: url('https://marketplace.canva.com/EAFMUqABEj8/1/0/1600w/canva-pink-minimalist-motivational-quote-facebook-cover-4i1_4CirhhQ.jpg');
        background-size: cover;
        background-position: center;
        border-radius: 15px 15px 0 0;
        width: 100%;
        height: 200px;
        display: flex;
        justify-content: center;
        align-items: center;
    }


    .profile__thumb img {
        border-radius: 50%;
        width: 190px;
        height: 190px;
        object-fit: cover;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        cursor: pointer;
        transition: transform 0.3s ease;
    }
    /*    .profile__thumb img:hover {
            transform: scale(1.2);
        }*/

    .profile__user-item {
        display: flex;
        padding: 15px 0;
        border-bottom: 1px solid #e0e0e0;
        font-family: 'Poppins', cursive;
        font-weight: 500;
        color: #555;
    }

    .profile__user-title {
        color: #333;
        text-align: left;
        flex-basis: 40%;
    }

    .profile__user-info {
        font-size: 18px;
        color: #666;
        flex-basis: 60%;
        text-align: left;
    }

    .change-password-section {
        display: grid;
        justify-content: center;
        margin-top: 30px;
    }

    .unfield__input-btn {
        padding: 12px 25px;
        background-color: #ff7b54;
        color: #ffffff;
        font-size: 16px;
        font-weight: 500;
        border-radius: 25px;
        border: none;
        transition: background-color 0.3s ease;
        cursor: pointer;
    }

    .unfield__input-btn:hover {
        transform: scale(1.3);
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
        background-color: rgba(0, 0, 0, 0.6);
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        width: 400px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        position: relative;
        text-align: center;
    }

    .close {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 22px;
        color: #999;
        cursor: pointer;
    }

    .close:hover {
        color: #333;
    }

    .form-group input {
        width: 100%;
        padding: 12px;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        margin-bottom: 15px;
    }

    .form-group input:focus {
        border-color: #ff5722;
        box-shadow: 0 0 8px rgba(255, 87, 34, 0.4);
    }



    .profile__box {
        text-align: center;
        padding: 50px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        background: linear-gradient(to bottom right, #fdfdfd, #f9f9f9);
    }

    .input-row {
        display: flex;
        gap: 15px;
        justify-content: space-between;
    }

    .single__input-field {
        display: flex;
    }
    .single__input-field .profile__user-title,
    .single__input-field .profile__user-info {
        flex-basis: 50%;
    }

    .single__input-field {
        padding-right: 10px;
    }
    .avatar-edit-btn {
        position: absolute;
        background-color: rgba(0, 0, 0, 0.3);
        border-radius: 3px;
        color: white;
        width: 50px;
        height: 25px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        cursor: pointer;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease;
        top: 245px; /* ?i?u ch?nh v? trí theo tr?c Y */
        left: calc(42% - 40px); /* C?n gi?a theo tr?c X */
        font-family: 'Poppins', cursive;
        font-size: 15px;
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
        <div class="background">
            <div class="userInfor">
                <div class="profile__main-wrapper mt-35">
                    <div class="profile__thumb">
                        <form style="padding-top: 170px;" action="<c:url value='/student/profile' />" method="POST" enctype="multipart/form-data">
                            <input type="file" name="avatar" accept="image/*" id="avatarInput" style="display: none;" onchange="this.form.submit()"> 
                            <c:url value="/assets/img/user/default-avatar.jpg" var="defaultAvatar" />
                            <img src="${pageContext.request.contextPath}${sessionScope.userInfor.avatarPath != null ? sessionScope.userInfor.avatarPath : defaultAvatar}" alt="Profile Image" class="avatar-img" id="avatar">
                            <button type="button" class="avatar-edit-btn" onclick="document.getElementById('avatarInput').click();">
                                <span>Edit</span>
                            </button></form>
                    </div>
                    <div class="profile__about-info" style="padding-top: 80px;">
                        <ul>
                            <li class="profile__user-item">
                                <div class="profile__user-tiitle">
                                    <span>Full Name:</span>
                                </div>
                                <div class="profile__user-info" style="padding-left: 30px;">
                                    <span>${sessionScope.userInfor.fullname}</span>
                                </div>
                            </li>
                            <li class="profile__user-item">
                                <div class="profile__user-tiitle">
                                    <span>Email:</span>
                                </div>
                                <div class="profile__user-info" style="padding-left: 30px;">
                                    <span>${sessionScope.userInfor.email}</span>
                                </div>
                            </li>
                            <div class="input-row mb-15" >
                                <li class="profile__user-item single__input-field" style="width: 200px;">
                                    <div class="profile__user-title">
                                        <span>Student ID:</span>
                                    </div>
                                    <div class="profile__user-info">
                                        <span>${sessionScope.userInfor.studentId}</span>
                                    </div>
                                </li>
                                <li class="profile__user-item single__input-field">
                                    <div class="profile__user-title">
                                        <span>Gender:</span>
                                    </div>
                                    <div class="profile__user-info">
                                        <span>${sessionScope.userInfor.gender}</span>
                                    </div>
                                </li>
                            </div>

                        </ul>
                        <div class="change-password-section">
                            <button class="unfield__input-btn" style="height:30px;"type="button" id="changePasswordBtn">
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
                <br>
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
                    <button class="unfield__input-btn" style="margin-left: 60px; height: 30px;
                            " type="submit">Change Password</button>
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