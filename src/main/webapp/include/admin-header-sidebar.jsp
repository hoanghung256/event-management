<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-stylt" content="width=device-wie-mode" content="1" />
        <!-- <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <!-- Place favicon.ico in the root directory -->
        <!-- CSS here -->
        <link rel="stylesheet" href="assets/app/css/animate.css" />
        <link rel="stylesheet" href="assets/app/css/animate.css" />
        <link rel="stylesheet" href="assets/app/css/meanmenu.min.css" />
        <link rel="stylesheet" href="assets/app/css/metisMenu.min.css" />
        <link rel="stylesheet" href="assets/app/css/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/app/css/slick.css" />
        <link rel="stylesheet" href="assets/app/css/backtotop.css" />
        <link rel="stylesheet" href="assets/app/css/magnific-popup.css" />
        <link rel="stylesheet" href="assets/app/css/flaticon_expovent.css" />
        <link rel="stylesheet" href="assets/app/css/fontawesome-pro.css" />
        <link rel="stylesheet" href="assets/app/css/spacing.css" />
        <link rel="stylesheet" href= "assets/app/css/main.css" />
    </head>

    <body class="body-area">
        <!--[if lte IE 9]>
          <p class="browserupgrade">
            You are using an <strong>outdated</strong> browser. Please
            <a href="https://browsehappy.com/">upgrade your browser</a> to improve
            your experience and security.
          </p>
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
        <!-- Dashboard area start -->
        <div class="page__full-wrapper">
            <!-- App sidebar area start -->
            <div class="expovent__sidebar">
                <div class="sidebar__inner simple-bar">
                    <div class="dlabnav">
                        <ul class="metismenu" id="menu">
                            <li>
                                <a href="/admin-dashboard" aria-expanded="false">
                                    <i class="flaticon-home"></i>
                                    <span class="nav-text">Dashboard</span>
                                </a>
                            </li>
                            <li>
                                <a href="/create-event" aria-expanded="false">
                                    <i class="flaticon-calendar-1"></i>
                                    <span class="nav-text">Create Event</span>
                                </a>
                            </li>
                            <li>
                                <a href="/pending-post" aria-expanded="false">
                                    <i class="flaticon-upcoming"></i>
                                    <span class="nav-text">Pending Post Submissions</span>
                                </a>
                            </li>
                            <li>
                                <a href="/organized-events" aria-expanded="false">
                                    <i class="flaticon-success"></i>
                                    <span class="nav-text">Organized Events</span>
                                </a>
                            </li>
                            <li>
                                <a href="/send-noti)" aria-expanded="false">
                                    <i class="flaticon-notification"></i>
                                    <span class="nav-text">Send Notification</span>
                                </a>
                            </li>
                            <li>
                                <a href="/event-approval" aria-expanded="false">
                                    <i class="flaticon-clock"></i>
                                    <span class="nav-text">Pending Events Approval</span>
                                </a>
                            </li>
                            <li>
                                <a href="/review-report-plan" aria-expanded="false">
                                    <i class="flaticon-edit-1"></i>
                                    <span class="nav-text">Review Report-Plan Files</span>
                                </a>
                            </li>
                            <li><a class="has-arrow" href="javascript:void(0)" aria-expanded="false">
                                    <i class="flaticon-user-1"></i>
                                    <span class="nav-text">Account <br> Management</span>
                                </a>
                                <ul aria-expanded="false">
                                    <li><a href="/manage-user">User Account</a></li>
                                    <li><a href="/manage-club">Club Account</a></li>
                                </ul>
                            </li>
                        </ul>
                        <div>
                            <p></p>
                        </div>
                        <div class="sidebar__profile mb-50">
                            <a href="signin.html"
                               ><i class="flaticon-log-out-3"></i
                                ><span class="links_name">Log Out</span></a
                            >
                        </div>
                        <div class="sidebar__copyright">
                            <p>Copyright @FUEM 2024</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="app__offcanvas-overlay"></div>
            <!-- App sidebar area end -->
            <div class="page__body-wrapper">
                <!-- App header area start -->
                <div class="app__header__area">
                    <div class="app__header-inner">
                        <div class="app__header-left">
                            <a
                                id="sidebar__active"
                                class="app__header-toggle"
                                href="javascript:void(0)"
                                >
                                <div class="bar-icon-2">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </a>
                            <!-- <div class="app__herader-input p-relative">
                              <input type="search" placeholder="Search Here . . .">
                              <button><i class="flaticon-loupe"></i></button>
                           </div> -->

                            <!--logo FPT-->
                            <div class="app__header-logo">
                                <img
                                    src="assets/img/logo/logoFpt.svg.png"
                                    alt="University Logo"
                                    />
                            </div>
                        </div>
                        <div class="app__header-right">
                            <div class="app__header-action">
                                <ul>
                                    <!--full screen button begin-->
                                    <li>
                                        <a href="#!" onclick="javascript:toggleFullScreen()">
                                            <div class="nav-item">
                                                <div class="notification__icon">
                                                    <svg
                                                        width="22"
                                                        height="22"
                                                        viewBox="0 0 22 22"
                                                        fill="none"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                        >
                                                    <path
                                                        d="M7.47106 21.549C7.09156 21.549 6.78356 21.2417 6.78356 20.8615V14.7984H0.6875C0.308 14.7984 0 14.4911 0 14.1109C0 13.7308 0.308 13.4234 0.6875 13.4234H7.47106C7.85056 13.4234 8.15856 13.7308 8.15856 14.1109V20.8615C8.15856 21.2417 7.85056 21.549 7.47106 21.549V21.549ZM14.5289 21.5318C14.1494 21.5318 13.8414 21.2245 13.8414 20.8443V14.0601C13.8414 13.6799 14.1494 13.3726 14.5289 13.3726H21.2795C21.659 13.3726 21.967 13.6799 21.967 14.0601C21.967 14.4403 21.659 14.7476 21.2795 14.7476H15.2164V20.8443C15.2164 21.2245 14.9084 21.5318 14.5289 21.5318V21.5318ZM7.47106 8.17644H0.7205C0.341 8.17644 0.033 7.86912 0.033 7.48894C0.033 7.10875 0.341 6.80144 0.7205 6.80144H6.78356V0.704688C6.78356 0.3245 7.09156 0.0171875 7.47106 0.0171875C7.85056 0.0171875 8.15856 0.3245 8.15856 0.704688V7.48894C8.15856 7.86844 7.85056 8.17644 7.47106 8.17644ZM21.3125 8.12556H14.5289C14.1494 8.12556 13.8414 7.81825 13.8414 7.43806V0.6875C13.8414 0.307312 14.1494 0 14.5289 0C14.9084 0 15.2164 0.307312 15.2164 0.6875V6.75056H21.3125C21.692 6.75056 22 7.05788 22 7.43806C22 7.81825 21.692 8.12556 21.3125 8.12556Z"
                                                        fill="#7A7A7A"
                                                        />
                                                    </svg>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <!--full screen button end-->
                                </ul>
                            </div>
                            <div class="nav-item p-relative">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.currentUser}">
                                        <div id="userportfolio">
                                            <div class="user__portfolio">
                                                <div class="user__portfolio-thumb">
                                                    <img
                                                        src="<c:out value='${sessionScope.currentUser.avatarPath != null ? sessionScope.currentUser.avatarPath : "assets/img/user/default-avatar.jpg"}'/>"
                                                        alt="Image not found"
                                                        />
                                                </div>
                                                <div class="user__content">
                                                    <c:choose>
                                                        <c:when test="${not empty sessionScope.currentUser.fullName}">
                                                            <span><c:out value="${sessionScope.currentUser.fullName}"/></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>Guest</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>
                                <!--Logo user drop header begin-->
                                <div class="user__dropdown">
                                    <ul>
                                        <li>
                                            <a href="profile.html"
                                               ><svg
                                                    width="16"
                                                    height="16"
                                                    viewBox="0 0 16 16"
                                                    fill="none"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                <g clip-path="url(#clip0_643_344)">
                                                <path
                                                    d="M13.6569 10.3431C12.7855 9.47181 11.7484 8.82678 10.6168 8.43631C11.8288 7.60159 12.625 6.20463 12.625 4.625C12.625 2.07478 10.5502 0 8 0C5.44978 0 3.375 2.07478 3.375 4.625C3.375 6.20463 4.17122 7.60159 5.38319 8.43631C4.25162 8.82678 3.2145 9.47181 2.34316 10.3431C0.832156 11.8542 0 13.8631 0 16H1.25C1.25 12.278 4.27803 9.25 8 9.25C11.722 9.25 14.75 12.278 14.75 16H16C16 13.8631 15.1678 11.8542 13.6569 10.3431ZM8 8C6.13903 8 4.625 6.486 4.625 4.625C4.625 2.764 6.13903 1.25 8 1.25C9.86097 1.25 11.375 2.764 11.375 4.625C11.375 6.486 9.86097 8 8 8Z"
                                                    fill="#7A7A7A"
                                                    />
                                                </g>
                                                <defs>
                                                <clipPath id="clip0_643_344">
                                                    <rect width="16" height="16" fill="white" />
                                                </clipPath>
                                                </defs>
                                                </svg>
                                                Profile</a
                                            >
                                        </li>

                                        <li>
                                            <a href="signin.html">
                                                <svg
                                                    width="18"
                                                    height="18"
                                                    viewBox="0 0 18 18"
                                                    fill="none"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                <g clip-path="url(#clip0_643_343)">
                                                <path
                                                    d="M17.4368 8.43771H10.312C10.0015 8.43771 9.74951 8.18572 9.74951 7.87523C9.74951 7.56474 10.0015 7.31274 10.312 7.31274H17.4368C17.7473 7.31274 17.9993 7.56474 17.9993 7.87523C17.9993 8.18572 17.7473 8.43771 17.4368 8.43771Z"
                                                    fill="#7A7A7A"
                                                    />
                                                <path
                                                    d="M14.6244 11.2502C14.4803 11.2502 14.3364 11.1954 14.2268 11.0852C14.0071 10.8654 14.0071 10.5091 14.2268 10.2894L16.6418 7.87457L14.2268 5.45958C14.0071 5.23986 14.0071 4.88364 14.2268 4.66392C14.4467 4.44406 14.8029 4.44406 15.0226 4.66392L17.835 7.47633C18.0547 7.69605 18.0547 8.05227 17.835 8.27199L15.0226 11.0844C14.9123 11.1954 14.7684 11.2502 14.6244 11.2502Z"
                                                    fill="#7A7A7A"
                                                    />
                                                <path
                                                    d="M5.99986 18.0002C5.83932 18.0002 5.68703 17.9776 5.53488 17.9304L1.02142 16.4267C0.407305 16.2122 0 15.64 0 15.0003V1.50073C0 0.673487 0.672754 0.000732422 1.5 0.000732422C1.66039 0.000732422 1.81269 0.0232537 1.96498 0.0704934L6.4783 1.5742C7.09255 1.7887 7.49972 2.36093 7.49972 3.00059V16.5002C7.49972 17.3274 6.8271 18.0002 5.99986 18.0002ZM1.5 1.1257C1.29374 1.1257 1.12496 1.29447 1.12496 1.50073V15.0003C1.12496 15.16 1.23222 15.3085 1.3852 15.3617L5.8775 16.8587C5.90977 16.8692 5.95179 16.8752 5.99986 16.8752C6.20612 16.8752 6.37475 16.7064 6.37475 16.5002V3.00059C6.37475 2.84088 6.2675 2.69244 6.11452 2.63915L1.62222 1.14218C1.58995 1.13174 1.54793 1.1257 1.5 1.1257Z"
                                                    fill="#7A7A7A"
                                                    />
                                                <path
                                                    d="M11.4371 6.00035C11.1266 6.00035 10.8746 5.74836 10.8746 5.43786V2.06297C10.8746 1.54622 10.454 1.12545 9.93722 1.12545H1.49998C1.18949 1.12545 0.9375 0.873462 0.9375 0.562971C0.9375 0.252479 1.18949 0.000488281 1.49998 0.000488281H9.93722C11.075 0.000488281 11.9996 0.925234 11.9996 2.06297V5.43786C11.9996 5.74836 11.7476 6.00035 11.4371 6.00035Z"
                                                    fill="#7A7A7A"
                                                    />
                                                <path
                                                    d="M9.93699 15.7501H6.93699C6.6265 15.7501 6.37451 15.4981 6.37451 15.1876C6.37451 14.8771 6.6265 14.6251 6.93699 14.6251H9.93699C10.4537 14.6251 10.8744 14.2044 10.8744 13.6876V10.3127C10.8744 10.0022 11.1264 9.75024 11.4369 9.75024C11.7473 9.75024 11.9993 10.0022 11.9993 10.3127V13.6876C11.9993 14.8254 11.0747 15.7501 9.93699 15.7501Z"
                                                    fill="#7A7A7A"
                                                    />
                                                </g>
                                                <defs>
                                                <clipPath id="clip0_643_343">
                                                    <rect width="18" height="18" fill="white" />
                                                </clipPath>
                                                </defs>
                                                </svg>
                                                Log out</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                                <!--Logo user drop header end-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="body__overlay"></div>
            </div>
        </div>

        <!-- Back to top start -->
        <div class="progress-wrap">
            <svg
                class="progress-circle svg-content"
                width="100%"
                height="100%"
                viewBox="-1 -1 102 102"
                >
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
            </svg>
        </div>
        <!-- Back to top end -->
        <!-- JS here -->
        <script src="assets/app/js/jquery-3.6.0.min.js"></script>
        <script src="assets/app/js/waypoints.min.js"></script>
        <script src="assets/app/js/bootstrap.bundle.min.js"></script>
        <script src="ssets/app/js/apexcharts.min.js"></script>
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
</html>
