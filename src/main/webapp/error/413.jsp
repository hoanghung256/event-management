<%-- 
    Document   : 413
    Created on : Oct 22, 2024, 8:19:15?PM
    Author     : TRINHHUY
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FUEM-FPTU Event Management System</title>        
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="theme-style-mode" content="1">
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

        <title>403 - Forbidden</title>
        <style>
            /* ??t style cho toàn b? trang */
            body {
                padding-top: 80px;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Style cho container ch?a n?i dung */
            .content-container {
                text-align: center;
                background: rgba(255, 255, 255, 0.9);
                width: 700px;
                height: 600px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                position: relative;
                background-image: url("${pageContext.request.contextPath}/assets/error/error.gif"); /* ??t GIF làm background */
                background-size: cover;
                background-position: center;
            }

            /* Style cho tiêu ?? 403 */
            .content-413{
                font-size: 3em;
                font-family: 'flaticon_expovent';
                font-weight: 600;
                color: #dc3545;
                margin: 10px 0;
                position: absolute;
                top: 40px; /* Kho?ng cách t? trên cùng */
            }

            /* Style cho n?i dung v?n b?n */
            .content {
                color: #6c757d;
                margin: 0;
                padding-bottom: 50px;
                position: absolute; /* ??t ? v? trí tuy?t ??i */
                bottom: -50px;
                font-size: 50px;
            }


            /* Style cho nút Back Home */
            .input__btn {
                display: block;
                width: 150px;
                height: 40px;
                line-height: 40px;
                text-align: center;
                color: white;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                margin: 20px auto;
            }

        </style>
    </head>
    <body>
        <div class="content-container">
            <div class="content-413">
                <span>413 - File upload too large!</span>
            </div>
            <div class="content">
                <h4 class="text-danger">Oops, something went wrong!</h4>
                <h4>Please go back then try to come again</h4>
                <a href="<c:url value="/home" />" class="input__btn">Back Home</a> <!-- Nút Back Home -->
            </div>
        </div>
    </body>
</html>

