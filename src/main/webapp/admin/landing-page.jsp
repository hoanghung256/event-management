<%-- 
    Document   : landing-page
    Created on : Oct 23, 2024, 10:59:30 PM
    Author     : hoang hung 
--%>

<%@include file="../include/admin-layout-header.jsp"%>

<section id="homeindex" class="banner__area banner__area-1 banner__height-1 d-flex align-items-center" data-background="assets/img/bg/banner.png">
    <div class="spotlight"></div>
    <div class="banner__meta-title">
        <span>Meet Up 2023</span>
    </div>
    <div class="banner__shape">
        <img class="banner__shape-1 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-1.png" />" alt="imge not found">
            <img class="banner__shape-2" src="<c:url value="/assets/img/shape/slider/shape-2.png" />" alt="imge not found">
                <img class="banner__shape-3" src="<c:url value="/assets/img/shape/slider/shape-3.png" />" alt="imge not found">
                    <img class="banner__shape-4 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-4.png" />" alt="imge not found">
                        <img class="banner__shape-5" src="<c:url value="/assets/img/shape/slider/shape-5.png" />" alt="imge not found">
                            <img class="banner__shape-6 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-6.png" />" alt="imge not found">
                                <div class="banner-all-line">
                                    <div class="banner__line banner__line-1"></div>
                                    <div class="banner__line banner__line-2"></div>
                                </div>
                                <div class="container-fluid">
                                    <div class="row align-items-xl-end">
                                        <div class="col-xxl-7 col-xl-8 col-lg-6">
                                            <div class="banner__content">
                                                <h2 class="banner__title">
                                                    Digital Thinkers <span class="text__highlight"> Conference </span>
                                                </h2>
                                                <div class="slider__btn">
                                                    <a href="signup.html">
                                                        Register Now
                                                        <svg class="btn-svg-border1 reg-hover-color-none" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path
                                                                d="M205.374 38.5573C205.374 43.679 202.612 48.6179 197.487 53.1693C192.362 57.7203 184.918 61.8416 175.677 65.3128C157.197 72.2539 131.634 76.5573 103.374 76.5573C75.1136 76.5573 49.5509 72.2539 31.0714 65.3128C21.8298 61.8416 14.3857 57.7203 9.26099 53.1693C4.13572 48.6179 1.37402 43.679 1.37402 38.5573C1.37402 33.4355 4.13572 28.4966 9.26099 23.9452C14.3857 19.3942 21.8298 15.2729 31.0714 11.8017C49.5509 4.86064 75.1136 0.557251 103.374 0.557251C131.634 0.557251 157.197 4.86064 175.677 11.8017C184.918 15.2729 192.362 19.3942 197.487 23.9452C202.612 28.4966 205.374 33.4355 205.374 38.5573Z"
                                                                stroke="white"
                                                                />
                                                        </svg>
                                                        <svg class="btn-svg-border2 reg-hover-color-none" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path
                                                                d="M205.374 38.5573C205.374 43.679 202.612 48.6179 197.487 53.1693C192.362 57.7203 184.918 61.8416 175.677 65.3128C157.197 72.2539 131.634 76.5573 103.374 76.5573C75.1136 76.5573 49.5509 72.2539 31.0714 65.3128C21.8298 61.8416 14.3857 57.7203 9.26099 53.1693C4.13572 48.6179 1.37402 43.679 1.37402 38.5573C1.37402 33.4355 4.13572 28.4966 9.26099 23.9452C14.3857 19.3942 21.8298 15.2729 31.0714 11.8017C49.5509 4.86064 75.1136 0.557251 103.374 0.557251C131.634 0.557251 157.197 4.86064 175.677 11.8017C184.918 15.2729 192.362 19.3942 197.487 23.9452C202.612 28.4966 205.374 33.4355 205.374 38.5573Z"
                                                                stroke="white"
                                                                />
                                                        </svg>
                                                        <svg class="btn-svg-border1 reg-hover-color" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path
                                                                d="M205.374 38.6717C205.374 43.7934 202.612 48.7323 197.487 53.2837C192.362 57.8347 184.918 61.956 175.677 65.4272C157.197 72.3683 131.634 76.6717 103.374 76.6716C75.1136 76.6716 49.5509 72.3682 31.0714 65.4272C21.8298 61.956 14.3857 57.8347 9.26098 53.2837C4.13571 48.7323 1.37402 43.7934 1.37402 38.6716C1.37402 33.5499 4.13571 28.611 9.26098 24.0596C14.3857 19.5086 21.8298 15.3873 31.0714 11.9161C49.5509 4.97503 75.1136 0.671644 103.374 0.671649C131.634 0.671654 157.197 4.97505 175.677 11.9161C184.918 15.3873 192.362 19.5086 197.487 24.0596C202.612 28.611 205.374 33.5499 205.374 38.6717Z"
                                                                stroke="url(#paint0_linear_42_638)"
                                                                />
                                                            <defs>
                                                                <linearGradient id="paint0_linear_42_638" x1="103.374" y1="0.171649" x2="103.374" y2="77.1716" gradientUnits="userSpaceOnUse">
                                                                    <stop offset="1" stop-color="#F7426F" />
                                                                    <stop offset="1" stop-color="#F87A58" />
                                                                </linearGradient>
                                                            </defs>
                                                        </svg>
                                                        <svg class="btn-svg-border2 reg-hover-color" width="206" height="78" viewBox="0 0 206 78" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path
                                                                d="M205.374 38.6717C205.374 43.7934 202.612 48.7323 197.487 53.2837C192.362 57.8347 184.918 61.956 175.677 65.4272C157.197 72.3683 131.634 76.6717 103.374 76.6716C75.1136 76.6716 49.5509 72.3682 31.0714 65.4272C21.8298 61.956 14.3857 57.8347 9.26098 53.2837C4.13571 48.7323 1.37402 43.7934 1.37402 38.6716C1.37402 33.5499 4.13571 28.611 9.26098 24.0596C14.3857 19.5086 21.8298 15.3873 31.0714 11.9161C49.5509 4.97503 75.1136 0.671644 103.374 0.671649C131.634 0.671654 157.197 4.97505 175.677 11.9161C184.918 15.3873 192.362 19.5086 197.487 24.0596C202.612 28.611 205.374 33.5499 205.374 38.6717Z"
                                                                stroke="url(#paint0_linear_42_638)"
                                                                />
                                                            <defs>
                                                                <linearGradient id="paint0_linear_42_6380" x1="103.374" y1="0.171649" x2="103.374" y2="77.1716" gradientUnits="userSpaceOnUse">
                                                                    <stop offset="1" stop-color="#F7426F" />
                                                                    <stop offset="1" stop-color="#F87A58" />
                                                                </linearGradient>
                                                            </defs>
                                                        </svg>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xxl-5 col-xl-4 col-lg-6">
                                            <div class="banner__right-content d-flex justify-content-lg-end">
                                                <div class="banner__card-wrapper ">
                                                    <div class="banner__card-inner">
                                                        <span class="card__icon"></span>
                                                        <span class="shape">
                                                            <svg width="146" height="227" viewBox="0 0 146 227" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M124 1H139C142.314 1 145 3.68629 145 7V220C145 223.314 142.314 226 139 226H7C3.68629 226 1 223.314 1 220V166.194" stroke="#F87A58"/>
                                                            </svg>                                 
                                                        </span>
                                                        <div class="banner__card-info">
                                                            <span>WHEN AND WHERE</span>
                                                            <h4>November 9 - 10 <br> The Midway SF</h4>
                                                        </div>
                                                        <div class="pluse__status">
                                                            <span class="dot"></span>
                                                            <span class="text">Online</span>
                                                        </div>
                                                    </div>
                                                    <div class="banner__time"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                </section>

                                <%@include file="../include/master-footer.jsp"%>