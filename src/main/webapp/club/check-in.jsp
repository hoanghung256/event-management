<%-- 
    Document   : check-in
    Created on : Oct 24, 2024, 2:02:35 PM
    Author     : hoang hung 
--%>

<%@include file="../include/club-layout-header.jsp"%>

<section class="banner__area banner__area-1 banner__height-1" data-background="<c:url value="/assets/img/bg/check-in.jpg" />">
    <div class="banner__shape">
        <img class="banner__shape-1 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-1.png" />" alt="imge not found">
        <img class="banner__shape-2" src="<c:url value="/assets/img/shape/slider/shape-2.png" />" alt="imge not found">
        <img class="banner__shape-3" src="<c:url value="/assets/img/shape/slider/shape-3.png" />" alt="imge not found">
        <img class="banner__shape-4 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-4.png" />" alt="imge not found">
        <img class="banner__shape-5" src="<c:url value="/assets/img/shape/slider/shape-5.png" />" alt="imge not found">
        <img class="banner__shape-6 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-6.png" />" alt="imge not found">
        
        <div class="container">
            <div class="text-center">
                <h1 class="text-white">Event Name Number 81</h1>
            </div>
            <div class="row">
                <div class="col-xl-8">
                <div class="text-center">
                    <img src="https://api.qrserver.com/v1/create-qr-code/?data=<c:url value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/student/check-in?eventId=${eventId}" />&size=500x500" alt="qr-code" />
                </div>
            </div>
            <div class="col-xl-4">
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
                        </div>
                        <div class="banner__time"></div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</section>

<%@include file="../include/master-footer.jsp" %>
