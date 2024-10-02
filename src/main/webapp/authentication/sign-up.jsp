<%-- 
    Document   : sign-in
    Created on : Sep 28, 2024, 11:21:09 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js" lang="zxx">
   
<!-- Mirrored from codeskdhaka.com/html/expovent-prev/expovent/signup.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 22 Sep 2024 08:45:00 GMT -->
<head>
      <meta charset="utf-8">
      <meta http-equiv="x-ua-compatible" content="ie=edge">
      <title>Expovent - Event Management Dashboard HTML5 Template</title>
      <meta name="description" content="">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="theme-style-mode" content="1">
      <!-- Place favicon.ico in the root directory -->
      <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">
      <!-- CSS here -->
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
   </head>
 
<body class="body-area">

      <!--[if lte IE 9]>
      <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
      <![endif]-->

      <!-- Preloder start -->
      <div id="preloader">
         <div class="sk-three-bounce">
            <div class="sk-child sk-bounce1"></div>
            <div class="sk-child sk-bounce2"></div>
            <div class="sk-child sk-bounce3"></div>
         </div>
      </div>
      <!-- Preloder start -->

       <!-- signup area start -->
       <section class="signin__area">
         <div class="sign__main-wrapper">
            <div class="sign__left">
               <div class="sign__header">
                  <div class="sign__logo">
                     <a href="dashboard.html">
                        <img class="logo-black" src="assets/img/logo/color-logo.svg" alt="image not found">
                        <img class="logo-white" src="assets/img/logo/color-logo-white.svg" alt="image not found">
                     </a>
                  </div>
                  <div class="sign__link">
                 <a class="sign__link-text" href="SignInController">Sign in</a>

                     <a class="sign__link-active" href="#">Sign Up</a>
                  </div>
               </div>
               <div class="sign__center-wrapper text-center mt-80">
                  <div class="sign__title-wrapper mb-40">
                     <h3 class="sign__title">Create An Account</h3>
                     <p>The faster you fill up. the faster you go to event</p>
                  </div>
                  <div class="sign__input-form text-center">
                     <form action="sign-up"method="POST"> 
                        <div class="sign__input">
                            <input type="text" placeholder="Full Name" name="fullname">
                           <span><i class="flaticon-user-2"></i></span>
                        </div>
                          <div class="sign__input">
                           <input type="text" placeholder="Student ID" name="studentId">
                           <span><i class="flaticon-user-2"></i></span>
                        </div>
                        <div class="sign__input">
                           <input type="email" placeholder="Email Address" name="email" value="${email}">
                           <span><i class="flaticon-user-2"></i></span>
                        </div>
                        <div class="sign__input">
                           <input type="password" placeholder="Enter Password" name="password">
                           <span><i class="flaticon-password"></i></span>
                        </div>
                        <div class="sign__input">
                           <input type="password" placeholder="Confirm Password" name="confirmPassword">
                           <span><i class="flaticon-password"></i></span>
                        </div>
                        <div class="sing__button mb-20">
                            <c:if test="${not empty error}">
                                <p class="text-danger">${error}</p>
                            </c:if>
                            <c:if test="${not empty message}">
                                <p class="text-info">${message}</p>
                            </c:if>
                           <button class="input__btn w-100 mb-20" type="submit">Sign-up</button>
                           <button class="gamil__sign-btn w-100" type="submit"><span><svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                              <g clip-path="url(#clip0_322_540)">
                              <path d="M4.43242 12.0863L3.73625 14.6852L1.19176 14.739C0.431328 13.3286 0 11.7149 0 10C0 8.34179 0.403281 6.77804 1.11812 5.40112H1.11867L3.38398 5.81644L4.37633 8.06815C4.16863 8.67366 4.05543 9.32366 4.05543 10C4.05551 10.7341 4.18848 11.4374 4.43242 12.0863Z" fill="#FBBB00"/>
                              <path d="M19.8252 8.13184C19.94 8.73676 19.9999 9.36148 19.9999 9.99996C19.9999 10.7159 19.9246 11.4143 19.7812 12.0879C19.2944 14.3802 18.0224 16.3818 16.2604 17.7983L16.2598 17.7978L13.4065 17.6522L13.0027 15.1313C14.1719 14.4456 15.0857 13.3725 15.567 12.0879H10.2197V8.13184H15.645H19.8252Z" fill="#518EF8"/>
                              <path d="M16.2595 17.7977L16.2601 17.7983C14.5464 19.1757 12.3694 19.9999 9.99965 19.9999C6.19141 19.9999 2.88043 17.8713 1.19141 14.7389L4.43207 12.0862C5.27656 14.34 7.45074 15.9444 9.99965 15.9444C11.0952 15.9444 12.1216 15.6483 13.0024 15.1312L16.2595 17.7977Z" fill="#28B446"/>
                              <path d="M16.383 2.30219L13.1434 4.95437C12.2319 4.38461 11.1544 4.05547 10 4.05547C7.39344 4.05547 5.17859 5.73348 4.37641 8.06812L1.11871 5.40109H1.11816C2.78246 2.1923 6.1352 0 10 0C12.4264 0 14.6511 0.864297 16.383 2.30219Z" fill="#F14336"/>
                              </g>
                              <defs>
                              <clipPath id="clip0_322_540">
                              <rect width="20" height="20" fill="white"/>
                              </clipPath>
                              </defs>
                              </svg>
<!--                              </span>Sign Up With Google</button>-->
                        </div>
                     </form>
                     <div class="if__account mt-90">
                         <p>Already have an account? <a href="sign-in">Sign in</a></p>
                     </div>
                  </div>
               </div>
            </div>
            <div class="sign__right">
               <div class="sign__input-thumb include__bg w-img" data-background="assets/img/sign/signup.jpg">
               </div>
            </div>
         </div>
      </section>
      <!-- Signup area start -->

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
   </body>

<!-- Mirrored from codeskdhaka.com/html/expovent-prev/expovent/signup.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 22 Sep 2024 08:45:00 GMT -->
</html>

