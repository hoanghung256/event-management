<%-- 
    Document : send-otp 
    Created on : Sep 26, 2024, 12:28:57 AM 
    Author : hoang hung 
--%> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <style>
            * {
                margin: 0;
                padding: 0;
            }
            .body {
                background-color: #eee;
                font-family: Arial, Helvetica, sans-serif;
                padding-top: 20px;
            }
            .container {
                max-width: 600px;
                margin: 50px auto;
                padding-bottom: 10px;
                background-color: white;
                border-radius: 12.5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                padding: 0 0 25px 0;
            }
            .img-header {
                padding: 0 0 0 0;
                text-align: center;
            }
            h1 {
                color: #f87a58;
                border-left: 4px solid #f87a58;
                padding-left: 30px;
                font-size: 30px;
            }
            .inside-content {
                padding: 34px;
                padding-bottom: 25px;
                text-align: justify;
            }
            .body1 {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .body2 {
                font-size: 17px;
                margin-bottom: 15px;
                line-height: 1.5;
            }
            ul {
                margin-left: 30px;
                margin-bottom: 15px;
            }
            li {
                padding: 3px 0 3px 10px;
            }
            .code-block {
                background-color: #f87a58;
                padding: 12px 0;
                color: white;
                text-align: center;
                font-weight: bold;
                font-size: 25px;
                letter-spacing: 1.5px;
                margin: 25px 0;
                border-radius: 5px;
            }
            a.link {
                text-decoration: none;
                color: #f7426f;
            }
            .footer {
                color: #888;
                padding: 20px;
            }
            .footer p {
                font-size: 12px;
                text-align: center;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="body">
            <div class="container">
                <div class="img-header">
                    <img src="" width="100"/>
                </div>
                <h1>Yêu cầu xác minh</h1>
                <div class="inside-content">
                    <p class="body1">Bạn đã gửi yêu cầu xác thực tài khoản!</p>
                    <p class="body2">
                        Dùng mã OTP sau đây để tiếp tục với điều đó.
                    </p>
                    <div class="code-block">[OTP]</div>
                    <p class="body2">OTP này sẽ hết hạn sau 5 phút!</p>
                    <p class="body2">Tuyệt đối không chia sẻ OTP này với bất kỳ ai khác!</p>
                </div>
            </div>
            <div class="footer">
                <p>Trường Đại học FPT phân hiệu Đà Nẵng, Khu Công nghệ cao, Ngũ Hành Sơn, Đà Nẵng, Việt Nam</p>
            </div>
        </div>
    </body>
</html>
