<%@ include file="../include/club-layout-header.jsp" %>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <script src="js/script.js"></script>
   <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DynaPuff:wght@400..700&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DynaPuff:wght@400..700&family=Prata&family=Readex+Pro:wght@160..700&family=Russo+One&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DynaPuff:wght@400..700&family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Playwrite+GB+S:ital,wght@0,100..400;1,100..400&family=Prata&family=Readex+Pro:wght@160..700&family=Russo+One&display=swap" rel="stylesheet">
 <style>
        .welcome-hero {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-end;
            position: relative;
            background: url('https://daihoc.fpt.edu.vn/wp-content/uploads/2024/03/dai-hoc-fpt-da-nang-1.jpeg') no-repeat center center / cover;
            height: 1000px;
            opacity: 0;
            animation: fadeInBackground 3s forwards 1s;
        }
.event-info p {
    color: #FFFFFF; 
    
}

        .header-text {
            opacity: 0;
            animation: fadeInText 3s forwards 1s;
            margin-top: 10px;
            max-width: 100%;
            overflow: hidden;
            position: relative; 
            margin-bottom: 50px;
        }

        .header-text h2 {
            font-size: 54px;
            font-weight: 700;
            line-height: 1.2;
            display: inline-block;
            justify-content: center;
            gap: 5px;
            font-family: "DynaPuff", system-ui;
  font-optical-sizing: auto;
            background: #D1E9F6;
            padding: 10px 20px;
            border-radius: 10px;
            overflow: hidden;
        }

        #clock {
            font-size: 48px;
            font-weight: bold;
            color: #E7E8D8; /* Màu vàng cho ??ng h? */
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 1); /* Khung m? màu ?en */
            background-color: rgba(0, 0, 0, 0.1); /* N?n m? cho ??ng h? */
            padding: 10px 20px;
            border-radius: 8px;
            display: inline-block;
            margin-top: 20px;
            width: 250px; /* ??t chi?u r?ng c? ??nh */
    height: 70px;
     font-family: "Prata", serif;
        }

        .event-info {
            color: #FFFFFF; /* ??i màu ch? thành tr?ng */
              font-family: "Inter", sans-serif;
            font-size: 18px;
            text-align: center;
            background-color: rgba(0, 0, 0, 0.1); /* N?n m? cho thông tin s? ki?n */
            padding: 5px 10px; /* Gi?m padding ?? khung v?a khít v?i ch? */
            border-radius: 8px;
            display: inline-block; /* Thay ??i thành inline-block ?? khung co l?i theo kích th??c ch? */
            margin-top: 10px; /* Gi? margin-top ?? t?o kho?ng cách v?i ph?n trên */
        }

        .header-text h2 span {
            display: inline-block;
            background: #F5F7F8;
            background-size: 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: letterGradientAnimation 4s infinite alternate;
            animation-timing-function: ease-in-out;
        }
        @import url("https://fonts.googleapis.com/css?family=Raleway:400,400i,700");








        @keyframes letterGradientAnimation {
            0% { background-position: 0% 50%; }
            100% { background-position: 100% 50%; }
        }

        @keyframes fadeInBackground {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInText {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
 </style>
</head>
<section id="welcome-hero" class="welcome-hero">
    <div class="container">
        <div class="row">


         <div class="col-md-12 text-center">
                <div class="header-text">
                    <h2 class="gradient-text animate__animated animate__heartBeat animate__infinite">
                        <span>C</span><span>H</span><span>E</span><span>C</span><span>K</span> 
                        <span>I</span><span>N</span> 
                        <span>N</span><span>O</span><span>W</span> 
                    </h2>
                </div>

                <div class="clock-container">
                    <h1 id="clock"></h1> 
                    <div class="event-info">
                        <p>Date: <span id="eventDate"></span></p>
                        <p>Event Name: <span id="eventName"></span></p>
                        <p>Location: <span id="eventLocation"></span></p>
                    </div>
                </div>

                <img style="padding-bottom:100px" src="https://api.qrserver.com/v1/create-qr-code/?data=<c:url value='${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/student/check-in?eventId=${eventId}' />&size=300x300" alt="qr-code" />
            </div>  
        </div>
    </div>

    <script type="text/javascript">
        // C?p nh?t thông tin s? ki?n
        document.getElementById('eventDate').innerText = '2024-10-27'; 
        document.getElementById('eventName').innerText = 'Sample Event Name';
        document.getElementById('eventLocation').innerText = 'Sample Location'; 

        setInterval(displayDate, 1000);
        
        function displayDate() {
            let currentdate = new Date();
            let datetime = formatValue(currentdate.getHours()) + ":"
                    + formatValue(currentdate.getMinutes()) + ":"
                    + formatValue(currentdate.getSeconds());
            document.getElementById("clock").innerHTML = datetime;
        };

        function formatValue(value) {
            return (value < 10 ? "0" + value : value);
        }
    </script>
</section>

<%@ include file="../include/master-footer.jsp" %>
