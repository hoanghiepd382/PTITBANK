<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .register-container {
            width: 400px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .register-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
            display: block;
        }
        .register-container input[type="text"],
        .register-container input[type="email"],
        .register-container input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .button-group button,
        .button-group input[type="submit"] {
            width: 48%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .back-button {
            background-color: #e4e6eb;
            color: #333;
        }
        .back-button:hover {
            background-color: #d3d6da;
        }
        .submit-button {
            background-color: #4CAF50;
            color: white;
        }
    </style>
    <script>
        function validateForm() {
            let username = document.forms["registerForm"]["username"].value.trim();
            let email = document.forms["registerForm"]["email"].value.trim();
            let password = document.forms["registerForm"]["password"].value;
            let confirmPassword = document.forms["registerForm"]["confirmPassword"].value;
            let errorMessage = "";

            // Kiểm tra các điều kiện
            if (username === "" || /\s/.test(username)) {
                errorMessage = "Tên đăng nhập không hợp lệ. Không được chứa khoảng trắng.";
            } else if (email === "" || !/^\S+@\S+\.\S+$/.test(email)) {
                errorMessage = "Email không hợp lệ.";
            } else if (password.length < 8) {
                errorMessage = "Mật khẩu phải có ít nhất 8 ký tự.";
            } else if (!/[a-zA-Z]/.test(password) || !/\d/.test(password) || !/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                errorMessage = "Mật khẩu phải chứa ít nhất một chữ cái, một chữ số và một ký tự đặc biệt.";
            } else if (password !== confirmPassword) {
                errorMessage = "Mật khẩu xác nhận không khớp.";
            }

            // Hiển thị lỗi
            let errorElement = document.getElementById("error-message");
            if (errorMessage !== "") {
                errorElement.textContent = errorMessage;
                errorElement.style.display = "block";
                return false;
            }

            // Ẩn lỗi nếu hợp lệ
            errorElement.style.display = "none";
            return true;
        }
    </script>
</head>
<body>
    <div class="register-container">
        <h2>Đăng ký tài khoản</h2>

        <!-- Hiển thị lỗi từ server hoặc client -->
        <div class="error-message" id="error-message">
            <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) { 
            %>
                <%= errorMessage %>
            <% } %>
        </div>

        <!-- Form đăng ký tài khoản -->
        <form name="registerForm" action="RegisterStep1Servlet" method="POST" onsubmit="return validateForm()">
            <input type="text" name="username" placeholder="Tên đăng nhập" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>

            <!-- Nút Quay lại và Tiếp tục -->
            <div class="button-group">
                <button type="button" class="back-button" onclick="window.location.href='views/home.jsp';">Quay lại</button>
                <input type="submit" class="submit-button" value="Tiếp tục">
            </div>
        </form>
    </div>
</body>
</html>
