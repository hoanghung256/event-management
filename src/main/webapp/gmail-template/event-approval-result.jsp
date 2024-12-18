<%-- 
    Document   : event-approval-result
    Created on : Nov 12, 2024, 11:23:00 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Event Registration Success</title>
        <style>
            /* Định dạng chung */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .header {
                background-color: #F37C21;
                color: white;
                padding: 20px;
                text-align: center;
                border-radius: 8px 8px 0 0;
            }
            .header h1 {
                margin: 0;
                font-size: 24px;
            }
            .content {
                padding: 20px;
                color: #333333;
                line-height: 1.6;
            }
            .content h2 {
                color: #000000;
            }
            .button {
                display: block;
                width: 200px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background-color: #F3;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
            .footer {
                text-align: center;
                color: #888888;
                font-size: 12px;
                padding: 10px;
                border-top: 1px solid #eeeeee;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="content">
                <h2>Kính gửi [ClubName],</h2>
                    <p>Chúng tôi rất vui mừng thông báo rằng yêu cầu đăng ký sự kiện <strong>[EventName]</strong> của câu lạc bộ đã được xem xét!</p>

                    <p><strong>Thông tin sự kiện:</strong></p>
                    <ul>
                        <li><strong>Kết quả phê duyệt: </strong> <i>[Result]</i></li>
                        <li><strong>Ngày:</strong> [Date]</li>
                        <li><strong>Thời gian:</strong> [StartTime] - [EndTime]</li>
                        <li><strong>Địa điểm:</strong> [Location]</li>
                    </ul>
            </div>

            <div class="footer">
                <p>Trường Đại học FPT phân hiệu Đà Nẵng, Khu Công nghệ cao, Ngũ Hành Sơn, Đà Nẵng, Việt Nam</p>
            </div>
        </div>
    </body>
</html>
