<%-- 
    Document   : club-layout-header
    Created on : Sep 26, 2024, 4:37:04 PM
    Author     : TRINHHUY
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FUEM-FPTU Event Management System</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="theme-style-mode" content="1">
        <!-- Place favicon.ico in the root directory -->
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/assets/img/logo/logo-fpt-small.svg" />">
        <!-- CSS here -->
        <link rel="stylesheet" href="<c:url value='/assets/app/css/bootstrap.min.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/meanmenu.min.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/animate.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/metisMenu.min.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/swiper-bundle.min.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/slick.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/backtotop.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/magnific-popup.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/flaticon_expovent.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/fontawesome-pro.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/spacing.css' />">
        <link rel="stylesheet" href="<c:url value='/assets/app/css/main.css' />">
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

        <!-- App sidebar area end -->
        <div class="page__full-wrapper">
            <!-- App sidebar area start -->
            <div class="expovent__sidebar">
                <div class="logo-details">
                    <span>
                        <a href="<c:url value="/club/dashboard"/>">
                            <img class="logo__white" src="<c:url value="/assets/img/logo/logo-fpt-small.svg"/>" alt="logo not found">
                        </a>
                    </span>
                    <span>
                        <a href="#">
                            <img class="log__smnall" style="margin-left: 1rem;" src="<c:url value="/assets/img/logo/logoFpt.svg.png"/>" width="65%" alt="logo not found">
                        </a>
                    </span>
                </div>
                <div class="sidebar__inner simple-bar">
                    <div class="dlabnav">
                        <ul class="metismenu" id="menu">
                            <li><a href="<c:url value="/club/dashboard"/>" aria-expanded="false">
                                    <i class="flaticon-home"></i>
                                    <span class="nav-text">Dashboard</span>
                                </a>
                            </li>
                            <li><a href="<c:url value="/club/register-event"/>" aria-expanded="false">
                                    <i class="flaticon-success"></i>
                                    <span class="nav-text">Register Event</span>
                                </a>
                            </li>
                            <li><a href="#" aria-expanded="false">
                                    <i class="flaticon-email"></i>
                                    <span class="nav-text">Send File</span>
                                </a>
                            </li>
                            <li><a href="<c:url value="/club/send-event-notification"/>" aria-expanded="false">
                                    <i class="flaticon-user-1"></i>
                                    <span class="nav-text">Send Notification</span>
                                </a>
                            </li>
                            <li><a href="<c:url value="/club/organized-event"/>" aria-expanded="false">
                                    <i class="flaticon-upcoming"></i>
                                    <span class="nav-text">Organized Events</span>
                                </a>
                            </li>
                            <li><a href="<c:url value="/sign-out" />" aria-expanded="false">
                                    <i class="flaticon-log-out-3"></i>
                                    <span class="nav-text">Log out</span>
                                </a>
                        </ul>
                        <div class="sidebar__copyright">
                            <p>Copyright @FUEM 2024</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- App sidebar area end -->
            <div class="page__body-wrapper">
                <!-- App header area start -->
                <div class="app__header__area">
                    <div class="app__header-inner">
                        <div class="app__header-left">
                            <a id="sidebar__active" class="app__header-toggle" href="javascript:void(0)">
                                <div class="bar-icon-2">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </a>
                        </div>
                        <div class="app__header-right">
                            <div class="nav-item p-relative">
                                    <div id="userportfolio" href="/profile">
                                        <div class="user__portfolio">
                                            <div class="user__portfolio-thumb">
                                                <c:url value="/assets/img/user/default-avatar.jpg" var="defaultAvatar" />
                                                <img 
                                                    src="${sessionScope.userInfor.avatarPath != null ? sessionScope.userInfor.avatarPath : defaultAvatar}" 
                                                    alt="Default Avatar" 
                                                />
                                            </div>
                                            <div class="user__content">
                                                <span>${sessionScope.userInfor.fullname != null ? sessionScope.userInfor.fullname : "Guest"}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="user__dropdown">
                                    <ul>
                                        <li>
                                            <a href="<c:url value="/club/profile" />"><svg width="16" height="16" viewBox="0 0 16 16" fill="none"
                                                                        xmlns="http://www.w3.org/2000/svg">
                                                <g clip-path="url(#clip0_643_344)">
                                                <path
                                                    d="M13.6569 10.3431C12.7855 9.47181 11.7484 8.82678 10.6168 8.43631C11.8288 7.60159 12.625 6.20463 12.625 4.625C12.625 2.07478 10.5502 0 8 0C5.44978 0 3.375 2.07478 3.375 4.625C3.375 6.20463 4.17122 7.60159 5.38319 8.43631C4.25162 8.82678 3.2145 9.47181 2.34316 10.3431C0.832156 11.8542 0 13.8631 0 16H1.25C1.25 12.278 4.27803 9.25 8 9.25C11.722 9.25 14.75 12.278 14.75 16H16C16 13.8631 15.1678 11.8542 13.6569 10.3431ZM8 8C6.13903 8 4.625 6.486 4.625 4.625C4.625 2.764 6.13903 1.25 8 1.25C9.86097 1.25 11.375 2.764 11.375 4.625C11.375 6.486 9.86097 8 8 8Z"
                                                    fill="#7A7A7A" />
                                                </g>
                                                <defs>
                                                <clipPath id="clip0_643_344">
                                                    <rect width="16" height="16" fill="white" />
                                                </clipPath>
                                                </defs>
                                                </svg>
                                                Profile</a>
                                        </li>
                                        <li>
                                            <a href="<c:url value="/sign-out" />"><svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                                                       xmlns="http://www.w3.org/2000/svg">
                                                <g clip-path="url(#clip0_643_343)">
                                                <path
                                                    d="M17.4368 8.43771H10.312C10.0015 8.43771 9.74951 8.18572 9.74951 7.87523C9.74951 7.56474 10.0015 7.31274 10.312 7.31274H17.4368C17.7473 7.31274 17.9993 7.56474 17.9993 7.87523C17.9993 8.18572 17.7473 8.43771 17.4368 8.43771Z"
                                                    fill="#7A7A7A" />
                                                <path
                                                    d="M14.6244 11.2502C14.4803 11.2502 14.3364 11.1954 14.2268 11.0852C14.0071 10.8654 14.0071 10.5091 14.2268 10.2894L16.6418 7.87457L14.2268 5.45958C14.0071 5.23986 14.0071 4.88364 14.2268 4.66392C14.4467 4.44406 14.8029 4.44406 15.0226 4.66392L17.835 7.47633C18.0547 7.69605 18.0547 8.05227 17.835 8.27199L15.0226 11.0844C14.9123 11.1954 14.7684 11.2502 14.6244 11.2502Z"
                                                    fill="#7A7A7A" />
                                                <path
                                                    d="M5.99986 18.0002C5.83932 18.0002 5.68703 17.9776 5.53488 17.9304L1.02142 16.4267C0.407305 16.2122 0 15.64 0 15.0003V1.50073C0 0.673487 0.672754 0.000732422 1.5 0.000732422C1.66039 0.000732422 1.81269 0.0232537 1.96498 0.0704934L6.4783 1.5742C7.09255 1.7887 7.49972 2.36093 7.49972 3.00059V16.5002C7.49972 17.3274 6.8271 18.0002 5.99986 18.0002ZM1.5 1.1257C1.29374 1.1257 1.12496 1.29447 1.12496 1.50073V15.0003C1.12496 15.16 1.23222 15.3085 1.3852 15.3617L5.8775 16.8587C5.90977 16.8692 5.95179 16.8752 5.99986 16.8752C6.20612 16.8752 6.37475 16.7064 6.37475 16.5002V3.00059C6.37475 2.84088 6.2675 2.69244 6.11452 2.63915L1.62222 1.14218C1.58995 1.13174 1.54793 1.1257 1.5 1.1257Z"
                                                    fill="#7A7A7A" />
                                                <path
                                                    d="M11.4371 6.00035C11.1266 6.00035 10.8746 5.74836 10.8746 5.43786V2.06297C10.8746 1.54622 10.454 1.12545 9.93722 1.12545H1.49998C1.18949 1.12545 0.9375 0.873462 0.9375 0.562971C0.9375 0.252479 1.18949 0.000488281 1.49998 0.000488281H9.93722C11.075 0.000488281 11.9996 0.925234 11.9996 2.06297V5.43786C11.9996 5.74836 11.7476 6.00035 11.4371 6.00035Z"
                                                    fill="#7A7A7A" />
                                                <path
                                                    d="M9.93699 15.7501H6.93699C6.6265 15.7501 6.37451 15.4981 6.37451 15.1876C6.37451 14.8771 6.6265 14.6251 6.93699 14.6251H9.93699C10.4537 14.6251 10.8744 14.2044 10.8744 13.6876V10.3127C10.8744 10.0022 11.1264 9.75024 11.4369 9.75024C11.7473 9.75024 11.9993 10.0022 11.9993 10.3127V13.6876C11.9993 14.8254 11.0747 15.7501 9.93699 15.7501Z"
                                                    fill="#7A7A7A" />
                                                </g>
                                                <defs>
                                                <clipPath id="clip0_643_343">
                                                    <rect width="18" height="18" fill="white" />
                                                </clipPath>
                                                </defs>
                                                </svg>
                                                Sign out</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
   
