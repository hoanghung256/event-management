<%-- 
    Document   : 500
    Created on : Oct 3, 2024, 12:24:22 PM
    Author     : hoang hung 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            /* Đặt style cho toàn bộ trang */
            body {
                padding-top: 80px;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Style cho container chứa nội dung */
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
                background-image: url("${pageContext.request.contextPath}/assets/error/error.gif"); /* Đặt GIF làm background */
                background-size: cover;
                background-position: center;
            }

            /* Style cho tiêu đề 403 */
            .content-500 {
                font-size: 3em;
                font-family: 'flaticon_expovent';
                font-weight: 600;
                color: #dc3545;
                margin: 10px 0;
                position: absolute;
                top: 40px; /* Khoảng cách từ trên cùng */
            }

            /* Style cho nội dung văn bản */
            .content {
                color: #6c757d;
                margin: 0;
                padding-bottom: 50px;
                position: absolute; /* Đặt ở vị trí tuyệt đối */
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
            <div class="content-500">
                <span>500 - Server error</span>
            </div>
            <div class="content">
                <h4 class="text-danger">Oops, something went wrong!</h4>
                <h4>Please go back then try to come again</h4>
                <a href="/event-management/home" class="input__btn">Back Home</a> <!-- Nút Back Home -->
            </div>
        </div>
    </body>
</html>


