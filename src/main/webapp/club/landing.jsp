<%-- 
    Document   : landing
    Created on : Oct 24, 2024, 2:02:35 PM
    Author     : hoang hung 
--%>

<%@include file="../include/club-layout-header.jsp"%>

<section class="banner__area banner__area-1 banner__height-1" data-background="https://th.bing.com/th/id/OIP.kQB9XFdPTlin3KQdUaJUfQHaDt?rs=1&pid=ImgDetMain">
    <div class="banner__shape">
        <img class="banner__shape-1 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-1.png" />" alt="imge not found">
    <!--        <img class="banner__shape-2" src="<c:url value="/assets/img/shape/slider/shape-2.png" />" alt="imge not found">
        <img class="banner__shape-3" src="<c:url value="/assets/img/shape/slider/shape-3.png" />" alt="imge not found">-->
        <img class="banner__shape-4 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-4.png" />" alt="imge not found">
        <img class="banner__shape-5" src="<c:url value="/assets/img/shape/slider/shape-5.png" />" alt="imge not found">
        <img class="banner__shape-6 parallaxed" src="<c:url value="/assets/img/shape/slider/shape-6.png" />" alt="imge not found">

        <div class="container">
            <div class="text-center">
                <h1 class="text-white">Event Name Number 81</h1>
            </div>
            <div class="row">
                <div class="text-center">
                    <h1 class="text-white" id="attended-count"></h1>
                    <h1 class="text-white">Attended</h1>
                </div>

                <div class="text-center">
                    <div class="element__btn yellow-bg">
                        <a href="<c:url value="#" />">Start a Q&A</a>
                    </div>
                    <div class="element__btn yellow-bg">
                        <a href="<c:url value="#" />">Start a voting</a>
                    </div>
                    <div class="element__btn yellow-bg">
                        <a href="<c:url value="/club/on-going-event?action=end&eventId=${event.id}" />">End Event</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        setInterval(getAttendCount, 1000);

        function getAttendCount() {
            fetch("${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/club/on-going-event?action=get-attend-count&eventId=${event.id}")
                .then((res) => res.json())
                .then((resJson) => {
                    document.getElementById("attended-count").innerHTML = resJson.attendedCount;
                })
                .catch((err) => {
                    console.log(err);
                });
        }
    </script>
</section>

<%@include file="../include/master-footer.jsp" %>