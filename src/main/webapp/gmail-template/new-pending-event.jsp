<%-- 
    Document   : new-pending-event
    Created on : Nov 3, 2024, 12:23:09 PM
    Author     : hoang hung 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông Báo Đăng Ký Sự Kiện Mới</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f6f6f6;
                color: #444444;
                margin: 0;
                padding: 0;
            }
            .email-container {
                max-width: 600px;
                margin: 20px auto;
                background-color: #ffffff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            .email-header {
                background-color: #f37c21;
                padding: 20px;
                text-align: center;
                color: #ffffff;
            }
            .email-header h1 {
                margin: 0;
                font-size: 28px;
            }
            .email-body {
                padding: 25px;
                color: #444444;
            }
            .email-body h2 {
                color: #f37c21;
                font-size: 24px;
                margin-top: 0;
            }
            .email-body p {
                line-height: 1.6;
                font-size: 16px;
            }
            .event-details {
                background-color: #f9f9f9;
                padding: 15px;
                border-left: 5px solid #f37c21;
                margin: 15px 0;
            }
            .cta-button {
                text-align: center;
                margin-top: 20px;
            }
            .cta-button a {
                background-color: #f37c21;
                color: #ffffff;
                padding: 12px 20px;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                display: inline-block;
                transition: background 0.3s;
            }
            .cta-button a:hover {
                background-color: #f37c21;
            }
            .email-footer {
                text-align: center;
                padding: 15px;
                background-color: #f6f6f6;
                font-size: 14px;
                color: #888888;
            }
            .email-footer a {
                color: #f37c21;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="email-container">
            <div class="email-header">
                <h1>Thông Báo Đăng Ký Sự Kiện Mới</h1>
            </div>

            <div class="email-body">
                <h2>Xin chào [AdminName],</h2>
                <p>Câu lạc bộ <strong>[ClubName]</strong> đã đăng ký sự kiện mới. Vui lòng xem chi tiết bên dưới:</p>

                <div class="event-details">
                    <h3>Chi tiết sự kiện:</h3>
                    <p><strong>Tên sự kiện:</strong> [EventName]</p>
                    <p><strong>Ngày tổ chức:</strong> [Date]</p>
                    <p><strong>Thời gian:</strong> [StartTime] - [EndTime]</p>
                </div>

                <p>Xin vui lòng xem xét và xác nhận yêu cầu này.</p>

            </div>
            <div class="email-footer">
                <p>Trường Đại học FPT phân hiệu Đà Nẵng, Khu Công nghệ cao, Ngũ Hành Sơn, Đà Nẵng, Việt Nam</p>
            </div>

        </div>

    </body>
</html>
