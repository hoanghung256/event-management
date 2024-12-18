<%-- 
    Document   : sign-in
    Created on : Sep 24, 2024, 9:01:44 AM
    Author     : huynh khiem
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FPTU Event Management </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="theme-style-mode" content="1">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo/logo-fpt-small.svg">
        <link rel="stylesheet" href="assets/app/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/app/css/meanmenu.min.css">
        <link rel="stylesheet" href="assets/app/css/animate.css">
        <link rel="stylesheet" href="assets/app/css/metisMenu.min.css">
        <link rel="stylesheet" href="assets/app/css/swiper-bundle.min.css">
        <link rel="stylesheet" href="assets/app/css/slick.css">
        <link rel="stylesheet" href="assets/app/css/backtotop.css">
        <link rel="stylesheet" href="assets/app/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/app/css/flaticon_expovent.css">
        <link rel="stylesheet" href="assets/app/css/fontawesome-pro.css">
        <link rel="stylesheet" href="assets/app/css/spacing.css">
        <link rel="stylesheet" href="assets/app/css/main.css">
        <link href="https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap" rel="stylesheet">
        <style>
            .sign__input-thumb {
                background-image: url('assets/img/sign/signin.jpg');
                background-size: cover; /* Để hình ảnh phủ kín */
                background-position: center; /* Căn giữa hình ảnh */
                width: 100%; /* Chiều rộng 100% */
                height: 100%; /* Chiều cao có thể tùy chỉnh */
            }
            .sign__title {
                font-size: 40px;
                font-family: 'Patrick Hand', cursive;
            }
            .flip-letter {
                display: inline-block;
                /* Kích thước chữ lớn */
                font-weight: bold;
                color: #ff5722; /* Màu chữ cam */
                opacity: 1; /* Đầy đủ hiển thị */
                animation: flip 8s infinite; /* Thời gian tổng thể của animation */
            }

            /* Chữ F rút lên biến mất */
            .flip-letter:nth-child(1) {
                animation-delay: 0s; /* Bắt đầu ngay lập tức */
            }

            /* Chữ P rút lên biến mất */
            .flip-letter:nth-child(2) {
                animation-delay: 2s; /* Bắt đầu sau 2 giây */
            }

            /* Chữ T rút lên biến mất */
            .flip-letter:nth-child(3) {
                animation-delay: 4s; /* Bắt đầu sau 4 giây */
            }

            /* Hiệu ứng CSS */
            @keyframes flip {
                /* Giai đoạn 1: Rút lên và biến mất */
                0%, 15% {
                    transform: translateY(0); /* Hiển thị ban đầu */
                    opacity: 1; /* Đầy đủ hiển thị */
                }
                15%, 30% {
                    transform: translateY(-100%); /* Rút lên và biến mất */
                    opacity: 0; /* Ẩn */
                }

                /* Dừng lại 2 giây */
                30%, 40% {
                    transform: translateY(-100%); /* Vẫn ẩn */
                    opacity: 0; /* Ẩn */
                }

                /* Giai đoạn 2: Hiện từ dưới lên */
                40%, 50% {
                    transform: translateY(100%); /* Hiển thị từ dưới lên */
                    opacity: 1; /* Hiển thị */
                }
                50%, 65% {
                    transform: translateY(0); /* Dừng lại và hiển thị */
                    opacity: 1; /* Đầy đủ hiển thị */
                }

                /* Dừng lại 4 giây trước khi thực hiện lại */
                65%, 100% {
                    transform: translateY(0); /* Vẫn hiển thị */
                    opacity: 1; /* Đầy đủ hiển thị */
                }
            }
        </style>
    </head>

    <body class="body-area">
        <!-- signin area start -->
        <section class="signin__area">
            <div class="sign__main-wrapper">
                <div class="sign__left">
                    <div class="sign__header">
                        <div class="sign__logo">
                            <a href="https://daihoc.fpt.edu.vn/">
                                <img class="logo-black" src="assets/img/logo/logoFpt.svg.png" alt="image not found" style="width: 150px; height: auto;">
                                <img class="logo-white" src="assets/img/logo/logoFpt.svg.png" alt="image not found" style="width: 150px; height: auto;">
                            </a>

                        </div>
                    </div>
                    <div class="sign__center-wrapper text-center mt-90">
                        <div class="sign__title-wrapper mb-40">
                            <h3 class="sign__title">
                                <span class="flip-letter">F</span>
                                <span class="flip-letter">P</span>
                                <span class="flip-letter">T</span> EVENT MANAGEMENT
                            </h3>

                            <p>Experience to success.</p>
                        </div>
                        <div class="sign__input-form text-center">
                            <form action="sign-in" method="POST">
                                <div class="sign__input">
                                    <input type="text" placeholder="Email" name="email">
                                    <span><i class="flaticon-user-2"></i></span>
                                </div>
                                <div class="sign__input">
                                    <input type="password" placeholder="Password" name="password">
                                    <span><i class="flaticon-password"></i></span>
                                </div>
                                <div class="sign__action">
                                    <div class="sign__check">
                                        <input class="e-check-input" type="checkbox" id="isOrganizer" name="role" value="organizer">
                                        <label class="sign__check-text" for="isOrganizer"><span>Is Organizer</span></label>
                                    </div>
                                    <div class="sign__forget">
                                        <span><a href="forget">Forget Password?</a></span>
                                    </div>
                                </div>

                                <div class="sing__button mb-20">
                                    <c:if test="${not empty error}">
                                        <p class="text-danger">${error}</p>
                                    </c:if>
                                    <c:if test="${not empty message}">
                                        <p class="text-info">${message}</p>
                                    </c:if>
                                    <button class="input__btn w-100 mb-20" type="submit">Sign in</button>
                                    <button class="gamil__sign-btn w-100" type="submit">
                                        <span>
                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <g clip-path="url(#clip0_322_540)">
                                            <path d="M4.43242 12.0863L3.73625 14.6852L1.19176 14.739C0.431328 13.3286 0 11.7149 0 10C0 8.34179 0.403281 6.77804 1.11812 5.40112H1.11867L3.38398 5.81644L4.37633 8.06815C4.16863 8.67366 4.05543 9.32366 4.05543 10C4.05551 10.7341 4.18848 11.4374 4.43242 12.0863Z" fill="#FBBB00"/>
                                            <path d="M19.8252 8.13184C19.94 8.73676 19.9999 9.36148 19.9999 9.99996C19.9999 10.7159 19.9246 11.4143 19.7812 12.0879C19.2944 14.3802 18.0224 16.3818 16.2604 17.7983L16.2598 17.7978L13.4065 17.6522L13.0027 15.1313C14.1719 14.4456 15.0857 13.3725 15.567 12.0879H10.2197V8.13184H15.645H19.8252Z" fill="#518EF8"/>
                                            <path d="M16.2595 17.7977L16.2601 17.7983C14.5464 19.1757 12.3694 19.9999 9.99965 19.9999C6.19141 19.9999 2.88043 17.8713 1.19141 14.7389L4.43207 12.0862C5.27656 14.34 7.45074 15.9444 9.99965 15.9444C11.0952 15.9444 12.1216 15.6483 13.0024 15.1312L16.2595 17.7977Z" fill="#28B446"/>
                                            <path d="M16.383 2.30219L13.1434 4.95437C12.2319 4.38461 11.1544 4.05547 10 4.05547C7.39344 4.05547 5.17859 5.73348 4.37641 8.06812L1.11871 5.40109H1.11816C2.78246 2.1923 6.1352 0 10 0C12.4264 0 14.6511 0.864297 16.383 2.30219Z" fill="#F14336"/>
                                            </g>
                                            <defs>
                                            <clipPath id="clip0_322_540">
                                                <rect width="20" height="20"/>
                                            </clipPath>
                                            </defs>
                                            </svg>
                                        </span>
                                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=https://fuem.azurewebsites.net/login-google&response_type=code&client_id=89142229238-cu1tiul7dl16gs4qigcjsgd0emkk3j0d.apps.googleusercontent.com&approval_prompt=force">
                                            Sign in With Google
                                        </a>
                                    </button>
                                </div>
                            </form>

                            <div class="if__account mt-85">
                                <p>Don't Have An Account? <a href="sign-up">Sign up now</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sign__right">
                    <div class="sign__input-thumb include__bg w-img" style="background-image: url('assets/img/decorate/sign-in.jpg');"></div>
                </div>
            </div>
        </section>
        <!-- signin area end -->

        <!-- JS here -->
        <script src="assets/app/js/jquery-3.6.0.min.js"></script>
        <!--<script src="assets/app/js/waypoints.min.js"></script>-->
        <script src="assets/app/js/bootstrap.bundle.min.js"></script>
        <script src="assets/app/js/apexcharts.min.js"></script>
        <script src="assets/app/js/metisMenu.min.js"></script>
        <script src="assets/app/js/meanmenu.min.js"></script>
        <script src="assets/app/js/swiper-bundle.min.js"></script>
        <script src="assets/app/js/slick.min.js"></script>
        <script src="assets/app/js/magnific-popup.min.js"></script>
        <script src="assets/app/js/main.js"></script>
        <audio id="background-audio" src="<%= request.getContextPath() %>/assets/music/nhacfpt.mp3" autoplay loop></audio>
    </body>
</html>
