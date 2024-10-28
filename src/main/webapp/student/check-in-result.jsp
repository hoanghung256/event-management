<%@ include file="../include/student-layout-header.jsp" %>

<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background-color: black; /* N?n màu ?en */
            color: white;
            height: 100vh; /* Chi?m toàn b? chi?u cao màn hình */
            display: flex;
            justify-content: center; /* C?n gi?a theo chi?u ngang */
            align-items: center; /* C?n gi?a theo chi?u d?c */
            overflow: hidden; /* ?n thanh cu?n */
        }

        .thank-you {
            font-size: 4em; /* Kích th??c ch? l?n */
            text-align: center;
            animation: fadeIn 2s ease-in-out, bounce 1s infinite; /* Thêm hi?u ?ng */
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-50px); /* B?t ??u t? v? trí trên */
            }
            to {
                opacity: 1;
                transform: translateY(0); /* ??n v? trí bình th??ng */
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0); /* V? v? trí ban ??u */
            }
            40% {
                transform: translateY(-30px); /* Nâng lên */
            }
            60% {
                transform: translateY(-15px); /* Nâng lên m?t chút */
            }
        }
    </style>
</head>

<body>
    <div class="thank-you">Thank You!</div> <!-- Hi?n th? ch? "Thank You" -->
    
    <!-- Optional: jQuery to ensure animations are triggered -->
    <script>
        $(document).ready(function() {
            $('.thank-you').hide().fadeIn(1000); // Hi?n ch? "Thank You" v?i hi?u ?ng fade-in
        });
    </script>
</body>

<%@ include file="../include/master-footer.jsp" %>
