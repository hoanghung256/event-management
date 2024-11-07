<%@include file="../include/club-layout-header.jsp"%>
<style>
    .banner__area-1 {
        position: relative;
    }
    
    /* Add a semi-transparent overlay */
    .banner-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.3); /* Adjust opacity as needed */
        z-index: 1;
    }
    
    .banner__shape {
        position: relative;
        z-index: 2;
    }
    
    .nameevent{
        color:#FFFFFF;
        font-weight: 700;
    }
</style>
<section class="banner__area-1 banner__height-1" 
         style="background-image: url('https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-6/462239137_935906218568371_4177881500911241990_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEvtvAWppLsnTnJkPckJUQ6y2YgaG-MpYfLZiBob4ylh0mcV3cHC-TLTn9zGgzWyYBtfnJDuiMLXJbOIgfOAlay&_nc_ohc=CPkNzqH8TMkQ7kNvgGqZh7F&_nc_zt=23&_nc_ht=scontent.fdad3-1.fna&_nc_gid=AWXw2OgxFzQEFM3LSGCI_YS&oh=00_AYBl9Qh4HjCd5E98bX9ci30ZzQyLl93Acz0RXlPDREKzYQ&oe=672E74D2'); background-size: cover; background-position: center;">
    <div class="banner-overlay"></div>
    
    <div class="banner__shape">
        <div class="container text-center">
            <h2 class="nameevent">${eventName}</h2>
            <div id="attend-info" class="py-4">
                <h1 id="attended-count" class="text-white p-5"></h1>
                <h2 class="text-white">Attended</h2>
            </div>

            <div class="d-flex justify-content-center mt-5">
                <a href="#" class="element__btn yellow-bg mx-2">Start a Q&A</a>
                <a href="#" class="element__btn yellow-bg mx-2">Start a Voting</a>
                <a href="<c:url value='/club/on-going-event?action=end&eventId=${eventId}' />" class="element__btn yellow-bg mx-2">End Event</a>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    setInterval(getAttendCount, 1000);

    function getAttendCount() {
        fetch("${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/club/on-going-event?action=get-attend-count&eventId=${eventId}")
            .then((res) => res.json())
            .then((resJson) => {
                document.getElementById("attended-count").textContent = resJson.attendedCount;
            })
            .catch((err) => console.error('Error fetching count:', err));
    }
</script>

<%@include file="../include/master-footer.jsp"%>
