<%@ include file="headerhome.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <style>
        /* Reset mặc định */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Cài đặt body */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: #333;
        }

        /* Khung chính của form */
        .login-container {
            width: 350px;
            padding: 2rem;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .login-container:hover {
            transform: scale(1.05);
        }

        /* Tiêu đề */
        .login-container h2 {
            margin-bottom: 1.5rem;
            color: #4e54c8;
        }

        /* Thông báo lỗi */
        .error-message {
            color: red;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        /* Các trường input */
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s;
        }

        .login-container input[type="text"]:focus,
        .login-container input[type="password"]:focus {
            border-color: #4e54c8;
        }

        /* Nút đăng nhập */
        .login-container button {
            width: 100%;
            padding: 0.8rem;
            background: #4e54c8;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .login-container button:hover {
            background: #3a41b0;
        }

        /* Liên kết quên mật khẩu */
        .login-container a {
            display: block;
            margin-top: 1rem;
            color: #4e54c8;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }

        .login-container a:hover {
            color: #3a41b0;
        }

        /* Phần footer */
        .footer {
            margin-top: 1.5rem;
            font-size: 0.85rem;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Đăng Nhập</h2>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="text" name="username" placeholder="Tên đăng nhập" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <button type="submit">Đăng Nhập</button>
        </form>
        <a href="ForgotPasswordServlet">Quên mật khẩu?</a>
        <div class="footer">
            <p>&copy; 2024 Ngân Hàng Nội Bộ</p>
        </div>
    </div>
</body>
</html>
