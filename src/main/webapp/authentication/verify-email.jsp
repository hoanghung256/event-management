<%-- 
    Document   : verify-email
    Created on : Oct 2, 2024, 3:26:41 PM
    Author     : hoang hung 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FU - Event Management</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="theme-style-mode" content="1">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">
        <!-- CSS here -->
        <link rel="stylesheet" href="assets/app/css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/meanmenu.min.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/animate.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/metisMenu.min.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/swiper-bundle.min.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/slick.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/backtotop.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/flaticon_expovent.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/fontawesome-pro.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/spacing.css" type="text/css">
        <link rel="stylesheet" href="assets/app/css/main.css" type="text/css">
    </head> 

    <body class="body-area">
        <!-- Preloder start -->
        <div id="preloader">
            <div class="sk-three-bounce">
                <div class="sk-child sk-bounce1"></div>
                <div class="sk-child sk-bounce2"></div>
                <div class="sk-child sk-bounce3"></div>
            </div>
        </div>
        <!-- Preloder start -->

        <!-- signin area start -->
        <section class="signin__area">
            <div class="sign__main-wrapper">
                <div class="sign__left">
                    <div class="sign__header">
                        <div class="sign__logo">
                            <a href="dashboard.html">
                                <img class="logo-black" src="assets/img/logo/logo-fpt.svg" alt="image not found">
                                <img class="logo-white" src="assets/img/logo/logo-fpt.svg" alt="image not found">
                            </a>
                        </div>
                        <div class="sign__link">
                            <a class="sign__link-active" href="#">Sign in</a>
                        </div>
                    </div>
                    <div class="sign__center-wrapper text-center mt-90">
                        <div class="sign__title-wrapper mb-40">
                            <h3 class="sign__title">Verify email?</h3>
                            <p>We sent OTP to your email. Please check and enter.</p>
                        </div>
                        <div class="sign__input-form text-center">
                            <form id="resetform" action="sign-up" method="POST">
                                <c:if test="${error != null}">
                                    <p class="text-danger">error</p>
                                </c:if>
                                <div class="sign__input">
                                    <input type="text" placeholder="Enter OTP" name="inputOTP" required>
                                    <span><i class="flaticon-envelope"></i></span>
                                </div>
                                <input name="fullname" value="${registerInfor.fullname}" hidden>
                                <input name="studentId" value="${registerInfor.studentId}" hidden>
                                <input type="text" name="gender" value="${registerInfor.gender}" hidden>
                                <input name="email" value="${registerInfor.email}" hidden>
                                <input type="password" name="password" value="${registerInfor.password}" hidden>
                                <button id="save-button" class="input__btn w-100 mb-20" type="submit">Verify</button>
                            </form>
                            <div class="if__account mt-85">
                                <p>Don’t Have An Account?<a href="sign-up"> Sign up</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sign__right">
                    <div class="sign__input-thumb" data-background="assets/img/sign/forgetpassword1.jpg">
                    </div>
                </div>
            </div>
        </section>
        <!-- signin area end -->

        <!-- Back to top start -->
        <div class="progress-wrap">
            <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
            </svg>
        </div>
        <!-- Back to top end -->

        <!-- JS here -->
        <script src="assets/app/js/jquery-3.6.0.min.js"></script>
        <script src="assets/app/js/waypoints.min.js"></script>
        <script src="assets/app/js/bootstrap.bundle.min.js"></script>
        <script src="assets/app/js/apexcharts.min.js"></script>
        <script src="assets/app/js/metisMenu.min.js"></script>
        <script src="assets/app/js/meanmenu.min.js"></script>
        <script src="assets/app/js/swiper-bundle.min.js"></script>
        <script src="assets/app/js/slick.min.js"></script>
        <script src="assets/app/js/magnific-popup.min.js"></script>
        <script src="assets/app/js/backtotop.js"></script>
        <script src="assets/app/js/counterup.js"></script>
        <script src="assets/app/js/wow.min.js"></script>
        <script src="assets/app/js/countdown.js"></script>
        <script src="assets/app/js/smooth-scrollbar.js"></script>
        <script src="assets/app/js/ajax-form.js"></script>
        <script src="assets/app/js/custom.js"></script>
        <script src="assets/app/js/main.js"></script>
</html>
