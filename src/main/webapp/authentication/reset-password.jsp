<%-- 
    Document   : reset-password
    Created on : Sep 24, 2024, 9:01:26 AM
    Author     : hoang hung 
--%>

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
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo/logo-fpt-small.svg">
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
                            <h3 class="sign__title">Reset Password?</h3>
                            <p>Enter email address associated with your account and we’ll send email with instruction to reset your password.</p>
                        </div>
                        <div class="sign__input-form text-center">
                            <form id="resetform" action="reset" method="POST">
                                <div class="sign__input">
                                    <!-- enter otp -->
                                    <input type="text" placeholder="Enter OTP" name="otp" required>
                                    <span><i class="flaticon-envelope"></i></span>
                                </div>
                                <div class="sign__input">
                                    <!-- enter otp -->
                                    <input type="password" placeholder="New Password" id="new-password" name="new-password" required>
                                    <span><i class="flaticon-password"></i></span>
                                </div>
                                <div class="sign__input">
                                    <!-- enter otp -->
                                    <input type="password" placeholder="Confirm Password" id="confirm-password" name="confirm-password" required>
                                    <span><i class="flaticon-password"></i></span>
                                </div>
                                <div class="sing__button mb-20">
                                    <div id="error-message" style="color: red; display: none;">
                                        Password do not match!
                                    </div>
                                    <button id="save-button" class="input__btn w-100 mb-20" type="submit" disabled>Save</button>
                                </div>
                            </form>
                            <div class="if__account mt-85">
                                <p>Don’t Have An Account?<a href="signup.html"> Sign up</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sign__right">
                    <div class="sign__input-thumb" data-background="assets/img/decorate/reset-password.jpg">
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
        <script>
            var newPassword = document.getElementById("new-password");
            var confirmPassword = document.getElementById("confirm-password");
            var saveButton = document.getElementById("save-button");
            var errorMessage = document.getElementById("error-message");

            // Function to check if passwords match
            function checkPasswords() {
                if (newPassword.value === confirmPassword.value && newPassword.value !== "") {
                    saveButton.disabled = false; // Enable the button
                    errorMessage.style.display = "none"; // Hide error message
                } else {
                    saveButton.disabled = true; // Disable the button
                    errorMessage.style.display = "block"; // Show error message
                }
            }

            // Add event listeners to check passwords on input
            newPassword.addEventListener("input", checkPasswords);
            confirmPassword.addEventListener("input", checkPasswords);
        </script>
    </body>

</html>



