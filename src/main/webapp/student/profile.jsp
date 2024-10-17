<%-- 
    Document   : profile
    Created on : Sep 26, 2024, 3:50:35?PM
    Author     : TRINHHUY
--%>

<%@include file="../include/student-layout-header.jsp"%>

<style>
    /* C?n ch?nh v? b? c?c */
    .profile__main-wrapper {
        padding: 20px;
        text-align: center;
    }
    .profile__thumb {
        margin: 0 auto;
        margin-bottom: 20px;
    }
    .profile__thumb img {
        border-radius: 50%;
        width: 150px;
        height: 150px;
        object-fit: cover;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .profile__user-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f9f9f9;
    }
    .profile__user-tiitle {
        font-weight: bold;
        color: #333;
        flex-basis: 30%;
    }
    .profile__user-info {
        text-align: left;
        font-size: 16px;
        color: #666;
        flex-basis: 65%;
    }
    .change-password-section {
        display: flex;
        justify-content: center;
      
        text-align: center;
        margin-top: 30px;

    }
    .unfield__input-btn {
        padding: 10px 20px;
        background-color: #ffffff;
        color: #000000;
        font-size: 16px;
        border-radius: 5px;
        transition: background-color 0.3s;
        border: none;
        width: 100%;
        max-width: 300px;
    }
    .unfield__input-btn:hover {
        background-color: #155a8a;
    }
    .profile__about-info {
        padding: 20px;
        max-width: 600px;
        margin: 0 auto;
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

<!-- HTML layout -->
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
                                    <li><span><a href="<c:url value="/home" />">Home</a></span></li>
                                    <li class="active"><span>Profile</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      
        <!--Bat dau content cua page o day-->
        <div class="userInfor">
            <div class="profile__main-wrapper mt-35">
                <div class="profile__thumb">
                    <img src="" alt="Profile Image">
                </div>

                <div class="profile__about-info">
                    <ul>
                        <li>
                            <div class="profile__user-item">
                                <div class="profile__user-tiitle">
                                    <span>Full Name:</span>
                                </div>
                                <div class="profile__user-info">
                                    <span>${sessionScope.userInfor.fullname}</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="profile__user-item">
                                <div class="profile__user-tiitle">
                                    <span>Email:</span>
                                </div>
                                <div class="profile__user-info">
                                    <span>${sessionScope.userInfor.email}</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="profile__user-item">
                                <div class="profile__user-tiitle">
                                    <span>Student ID:</span>
                                </div>
                                <div class="profile__user-info">
                                    <span>${sessionScope.userInfor.studentId}</span>
                                </div>
                            </div>
                        </li>
                    </ul>

                    <!-- N?t ??i m?t kh?u -->
                    <c:if test="${not empty error}">
                        <div class="error-message" style="color: red; margin-bottom: 15px;">${error}</div>
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
                    <div class="change-password-section">
                        <button class="unfield__input-btn" type="button" id="changePasswordBtn">
                            <i class="flaticon-lock"></i> Change Password
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Modal cho vi?c ??i m?t kh?u -->
    <div id="changePasswordModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Change Password</h3>
            <form action="<c:url value='/student/change-password' />" method="POST" id="changePasswordForm">
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

<!-- JavaScript -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var modal = document.getElementById("changePasswordModal");
        var btn = document.getElementById("changePasswordBtn"); // N?t m? modal
        var span = document.getElementsByClassName("close")[0];

        btn.onclick = function () {
            modal.style.display = "flex"; // M? modal khi nh?n n?t
        }

        span.onclick = function () {
            modal.style.display = "none"; // ??ng modal khi nh?n n?t ??ng
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none"; // ??ng modal n?u nh?n ra ngo?i
            }
        }
    });
</script>

<%@include file="../include/master-footer.jsp"%>
