<%@ include file="../include/admin-layout-header.jsp" %>

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <script src="js/script.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DynaPuff:wght@400..700&display=swap" rel="stylesheet">
    <style>
        .welcome-hero {
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('<c:url value="/assets/img/decorate/check-in-page.jpg" />') no-repeat center center / cover;
            height: 1000px;
            animation: fadeInBackground 3s forwards 1s;
        }
        .header-text h2 {
            font-size: 54px;
            font-weight: 700;
            font-family: "DynaPuff", sans-serif;
            color: #FFFFFF !important;
        }
        #clock {
            font-size: 48px;
            font-weight: bold;
            color: #FFFFFF !important;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 1);
            padding: 10px 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .event-info {
            font-family: "Inter", sans-serif;
            color: #FFFFFF !important;

            text-align: center;
            background-color: rgba(0, 0, 0, 0.3); /* Simple dark overlay */
            padding: 15px;
            border-radius: 8px;
            width: fit-content;
            margin: 0 auto;
            background-size: cover;
            background-position: center;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2); /* Subtle shadow for depth */
        }

        .event-info p {
            color: #FFFFFF !important;
            margin: 8px 0;

            line-height: 1.4;
            font-size: 25px;
            font-weight: bold;
        }

        .event-info span {
            display: inline-block;
            margin-left: 4px;
            padding: 2px 4px;
            background: rgba(255, 255, 255, 0.1); /* Light overlay for clarity */
            border-radius: 4px;
        }
        .animated-text {
            padding: 5px 15px; /* Reduce padding */
            font-size: 2.5rem; /* Adjust font size as needed */
            font-weight: bold;
            color: #FFFFFF;
            background: #D1E9F6; /* Background color */
            border-radius: 8px;
            max-width: 100%; /* Set max width */
            overflow: hidden; /* Hide overflow */
            display: inline-block; /* Ensure it behaves as an inline element */
        }

        @keyframes animate__heartBeat {
            0%, 100% {
                transform: scale(1);
            }
            30% {
                transform: scale(1.1);
            } /* Reduced scale */
            60% {
                transform: scale(0.9);
            }
        }
    </style>
</head>

<section class="welcome-hero">
    <div class="container text-center">
        <div class="header-text">
            <h2 class="animate__animated animate__heartBeat animate__infinite" style="padding-bottom: 10px;">CHECK IN NOW</h2>

        </div>
        <div class="qr-container">
            <div class="event-info">
                <p>
                    <span>${event.fullname}</span>
                </p>
                <p>
                    Date: <span>${event.dateOfEvent} <span>${event.startTime} - ${event.endTime}</span>
                </p>

                <p>
                    <span>${event.location.name}</span>
                </p>
            </div>
            <img style="padding-top:20px;" src="https://api.qrserver.com/v1/create-qr-code/?data=<c:url value='${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/student/check-in?eventId=${event.id}' />&size=380x380" alt="QR Code" />
            <h1 id="clock"></h1>
        </div>
    </div>

    <script type="text/javascript">
        setInterval(displayDate, 1000);
        function displayDate() {
            const currentdate = new Date();
            const datetime = formatValue(currentdate.getHours()) + ":" + formatValue(currentdate.getMinutes()) + ":" + formatValue(currentdate.getSeconds());
            document.getElementById("clock").innerHTML = datetime;
        }
        function formatValue(value) {
            return value < 10 ? "0" + value : value;
        }
    </script>
</section>

<%@ include file="../include/master-footer.jsp" %>
