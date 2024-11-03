<%-- 
    Document   : event-register-success
    Created on : Nov 3, 2024, 12:15:19 PM
    Author     : hoang hung 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác Nhận Đăng Ký Sự Kiện Thành Công</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 600px;
                margin: 20px auto;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .header {
                background-color: #4CAF50;
                padding: 20px;
                text-align: center;
                border-radius: 8px 8px 0 0;
                color: #ffffff;
            }
            .header h1 {
                margin: 0;
                font-size: 24px;
            }
            .content {
                padding: 20px;
                color: #333333;
            }
            .content h2 {
                font-size: 20px;
                color: #333333;
            }
            .button {
                text-align: center;
                margin-top: 20px;
            }
            .button a {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: #ffffff;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
            }
            .footer {
                text-align: center;
                color: #777777;
                font-size: 12px;
                padding: 15px;
                margin-top: 20px;
                border-top: 1px solid #dddddd;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="header">
                <h1>Sự kiện đã được chấp thuận!</h1>
            </div>

            <div class="content">
                <h2>Kính gửi [ClubName],</h2>
                <p>Chúng tôi rất vui mừng thông báo rằng yêu cầu đăng ký sự kiện <strong>[EventName]</strong> của câu lạc bộ đã được <strong style="color: green;">chấp thuận</strong>!</p>

                <p><strong>Thông tin sự kiện:</strong></p>
                <ul>
                    <li><strong>Ngày:</strong> [Date]</li>
                    <li><strong>Thời gian:</strong> [StartTime] - [EndTime]</li>
                    <li><strong>Địa điểm:</strong> [Location]</li>
                </ul>

                <p>Hãy đảm bảo mọi công tác chuẩn bị cho sự kiện sẵn sàng và liên hệ với ban quản trị nếu cần thêm hỗ trợ.</p>

            </div>
            <div class="footer">
                <p>Trường Đại học FPT phân hiệu Đà Nẵng, Khu Công nghệ cao, Ngũ Hành Sơn, Đà Nẵng, Việt Nam</p>
            </div>

        </div>

    </body>
</html>
