<%@include file="../include/club-layout-header.jsp"%>
<style>
    .nameevent{
        color:#859F3D;
        font-weight: 700;
    }
    #attended-count {
        color: red;
    }
</style>
<section class="banner__area banner__area-1 banner__height-1" 
         style="background-image: url('https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-6/462239137_935906218568371_4177881500911241990_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEvtvAWppLsnTnJkPckJUQ6y2YgaG-MpYfLZiBob4ylh0mcV3cHC-TLTn9zGgzWyYBtfnJDuiMLXJbOIgfOAlay&_nc_ohc=CPkNzqH8TMkQ7kNvgGqZh7F&_nc_zt=23&_nc_ht=scontent.fdad3-1.fna&_nc_gid=AWXw2OgxFzQEFM3LSGCI_YS&oh=00_AYBl9Qh4HjCd5E98bX9ci30ZzQyLl93Acz0RXlPDREKzYQ&oe=672E74D2'); background-size: cover; background-position: center;">
    <div class="banner__shape">
       

        <div class="container text-center">
            <h1 class="nameevent">Event Name Number 81</h1>
            <div id="attend-info" class="my-4">
                <h2 id="attended-count" class="text-white display-5"></h2>
                <h3 class="text-white">Attended</h3>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <a href="#" class="element__btn yellow-bg mx-2">Start a Q&A</a>
                <a href="#" class="element__btn yellow-bg mx-2">Start a Voting</a>
                <a href="<c:url value='/club/on-going-event?action=end&eventId=${event.id}' />" class="element__btn yellow-bg mx-2">End Event</a>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    setInterval(getAttendCount, 1000);

    function getAttendCount() {
        fetch("${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/club/on-going-event?action=get-attend-count&eventId=${event.id}")
            .then((res) => res.json())
            .then((resJson) => {
                document.getElementById("attended-count").textContent = resJson.attendedCount;
            })
            .catch((err) => console.error('Error fetching count:', err));
    }
</script>

<%@include file="../include/master-footer.jsp"%>
