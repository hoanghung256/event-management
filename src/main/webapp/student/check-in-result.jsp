<%-- 
    Document   : check-in-result
    Created on : Nov 1, 2024, 3:31:40 PM
    Author     : hoang hung 
--%>

<%@ include file="../include/student-layout-header.jsp" %>

<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=DynaPuff:wght@400..700&family=Itim&display=swap" rel="stylesheet">
    <style>
/*        * {
            margin:0;
            padding:0;
            font-family: 'Arvo';
        }*/
        .main{
            height:100vh;
            width:100%;
            display:flex;
            align-items:center;
            justify-content:center;
            text-align:center;
            background-color:#f37021;

        }
        h1{
            text-align:center;
            text-transform: uppercase;
            color: #F1FAEE;
            font-size: 4rem;
            font-family: "Anton", sans-serif;
        }
        .roller{
            height: 4.125rem;
            line-height: 4rem;
            position: relative;
            overflow: hidden;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;

            color: #1D3557;
        }
        #spare-time{
            font-size: 1rem;
            font-style: italic;
            letter-spacing: 1rem;
            margin-top: 0;
            color: #A8DADC;

        }
        .roller #rolltext {
            position: absolute;
            top: 0;
            animation: slide 5s infinite;
            font-family: "DynaPuff", system-ui;
        }
        @keyframes slide {
            0%{
                top:0;
            }
            25%{
                top: -4rem;
            }
            50%{
                top: -8rem;
            }
            72.5%{
                top: -12.25rem;
            }
        }
        @media screen and (max-width: 600px){
            h1{
                text-align:center;
                text-transform: uppercase;
                color: #F1FAEE;
                font-size: 2.125rem;
            }

            .roller{
                height: 2.6rem;
                line-height: 2.125rem;
            }

            #spare-time {
                font-size: 1rem;
                letter-spacing: 0.1rem;
            }

            .roller #rolltext {
                animation: slide-mob 5s infinite;
            }

            @keyframes slide-mob {
                0%{
                    top:0;
                }
                25%{
                    top: -2.125rem;
                }
                50%{
                    top: -4.25rem;
                }
                72.5%{
                    top: -6.375rem;
                }
            }
        }
    </style>
</head>

<body>
    <div class="main">
        <h3 class="text-danger">${error}</h3>
        <h3 class="text-success">${message}</h3>
        <h1>Thank you <div class="roller">
                <span id="rolltext">FOR<br/>
                    Check in<br/>
                    Event Name<br/>


                    <span id="spare-time">FPT Event Management 

                    </span><br/>
            </div>
        </h1>

</body>

<%@ include file="../include/master-footer.jsp" %>
