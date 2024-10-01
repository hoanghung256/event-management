<%-- 
    Document   : test-profile
    Created on : Sep 26, 2024, 3:50:35?PM
    Author     : TRINHHUY
--%>

<%@include file="../include/student-layout-header.jsp"%>

<style>

    .profile__left{
        display: flex;
        justify-content: center;
    }


    .profile__user-item {
        display: flex;
        align-items: center;
        margin-bottom: 30px;
    }

    .profile__user-tiitle {
        font-weight: bold;
        width: 100px;
    }

    .profile__user-info {
        width: auto;
        text-align: left;
    }
    .change-password-section {
        text-align: right; 
        max-width: 200px; 
        margin-left: auto; 
    }

    .ticket__price-inner {
        font-size: 13px; 
    }

    .unfield__input-btn {
        padding: 5px 10px; 
        width: 100%; 
        height: 60%;
        box-sizing: border-box; 
    }







    .userInfor{
        padding-top: 30px;
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
                                    <li><span><a href="dashboard.html">Home</a></span></li>
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
                <div class="row">
                    <div class="col-xxl-4 col-xl-5 col-lg-6 col-md-6">
                        <div class="profile__left">
                            <div class="padding__left-inner p-relative">
                                <a href="setting.html">

                                </a>
                                <div class="profile__thumb mb-45">
                                    <img src="https://th.bing.com/th/id/OIP.e1KNYwnuhNwNj7_-98yTRwHaF7?rs=1&pid=ImgDetMain" alt="image not found">
                                </div>
                                <div class="profile__user">                                            
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xxl-8 col-xl-7 col-lg-6 col-md-6">
                        <div class="profile__right p-relative">
                            <a href="setting.html">
                                <div class="profile__edit">
                                    <i class="flaticon-edit"></i>
                                </div>
                            </a>
                            <div class="profile__about-info">
                                <ul>
                                    <li>
                                        <div class="profile__user-item">
                                            <div class="profile__user-tiitle">
                                                <span>First Name:</span>
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
                                                <span>StudentId:</span>
                                            </div>
                                            <div class="profile__user-info">
                                                <span>${sessionScope.userInfor.studentId}</span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                <!--changepass--> 
                                <div class="change-password-section">
                                    <div class="ticket__price-inner">
                                        <div class="ticket__price-item">
                                            <button class="unfield__input-btn" type="button" onclick="window.location.href = 'authentication/forget-password.jsp'">
                                                <i class="flaticon-lock"></i> Change Password
                                            </button>
                                        </div>
                                    </div>
                                </div>



                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</section>

<%@include file="../include/master-footer.jsp" %>
