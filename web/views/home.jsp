<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <style>
        /* Đặt font chữ và reset margin */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: rgba(0, 0, 0, 0.1);
            background-image: url("https://i.ibb.co/WF09btD/Screenshot-2024-11-16-133834.png");
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Đảm bảo chiều cao tối thiểu bằng chiều cao màn hình */
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        /* Logo */
        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #ffffff;
            text-transform: uppercase;
        }

        /* Menu */
        nav ul {
            list-style-type: none;
            display: flex;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            text-decoration: none;
            color: #ffffff;
            font-size: 16px;
        }

        nav ul li a:hover {
            color: #90caf9;
        }

        /* Đăng ký, Đăng nhập */
        .auth-buttons {
            display: flex;
            gap: 10px;
        }

        .auth-buttons a {
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 5px;
            color: #0049b1;
            background-color: #ffffff;
            font-weight: bold;
        }

        /* Phần nội dung chính */
        .main-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 80px 20px;
            color: #ffffff;
            flex-grow: 1; /* Tự động chiếm không gian còn lại */
        }

        .main-content h1 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .main-content p {
            font-size: 20px;
            margin-bottom: 40px;
            max-width: 600px;
        }

        .main-content .cta-button {
            padding: 15px 30px;
            font-size: 18px;
            color: #ffffff;
            background-color: #00c853;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }

        .main-content .cta-button:hover {
            background-color: #00b248;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 15px;
            background-color: rgba(0, 0, 0, 0.2);
            font-size: 14px;
            color: #ffffff;
            margin-top: auto; /* Đảm bảo footer luôn nằm ở dưới cùng */
        }
    </style>
</head>
<body>
<header>
    <div class="logo">PTIT BANK</div>
    <nav>
        <ul>
            <li><a href="#">Dịch vụ</a></li>
            <li><a href="#">Hỗ trợ</a></li>
            <li><a href="#">Liên hệ</a></li>
        </ul>
    </nav>
    <div class="auth-buttons">
        <a href="${pageContext.request.contextPath}/RegisterStep1Servlet">Đăng ký</a>
        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
</header>

<div class="main-content">
    <h1>Ngân hàng nội bộ dành cho cán bộ sinh viên PTIT </h1>
    <p>Hãy dùng thử ngay và khám phá các tính năng để hỗ trợ các giao dịch, đóng học phí và hơn thế nữa.</p>
    <a href="login" class="cta-button">Trải nghiệm ngay</a>
</div>

<footer>
    &copy; 2024 Ngân hàng PTIT. Tất cả các quyền được bảo lưu.
</footer>

</body>
</html>
