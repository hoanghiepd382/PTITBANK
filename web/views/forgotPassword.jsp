<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm tài khoản của bạn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f2f5;
        }
        .container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .container h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }
        .container p {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .container input[type="email"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
        }
        .button {
            width: 48%;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .cancel-button {
            background-color: #e4e6eb;
            color: #333;
        }
        .search-button {
            background-color: #1877f2;
            color: #fff;
        }
        .cancel-button:hover {
            background-color: #d3d6da;
        }
        .search-button:hover {
            background-color: #166fe5;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Tìm tài khoản của bạn</h2>
    <p>Vui lòng nhập email để tìm kiếm tài khoản của bạn.</p> 
    <!-- Hiển thị thông báo lỗi nếu có -->
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <p style="color: red; font-size: 14px;"><%= message %></p>
    <%
        }
    %>
    
    <form action="ForgotPasswordServlet" method="POST">
        <input type="email" name="email" placeholder="Email hoặc số di động" required>
        <div class="button-container">
            <button type="button" class="button cancel-button" onclick="window.location.href='home.jsp'">Hủy</button>
            <button type="submit" class="button search-button">Tìm kiếm</button>
        </div>
    </form>
</div>

</body>
</html>
