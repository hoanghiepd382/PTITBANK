<%@ include file="headerst.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thay Đổi Mã PIN</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            max-width: 450px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .message {
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .message.success {
            color: #28a745;
        }

        .message.error {
            color: #dc3545;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-buttons {
            display: flex;
            justify-content: center; /* Canh giữa các nút */
            gap: 20px;
        }

        .form-buttons button {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        /* Nút Cập Nhật */
        .form-buttons button[type="submit"] {
            background-color: #28a745;
            color: white;
            font-weight: bold;
        }

        /* Nút khi hover */
        .form-buttons button[type="submit"]:hover {
            background-color: #218838;
            transform: scale(1.05);
        }

        a.button-link {
            text-decoration: none;
            color: inherit;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Thay Đổi Mã PIN</h2>

        <% String message = request.getParameter("message"); %>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>

        <% if (message != null) { %>
            <p class="message success"><%= message %></p>
        <% } else if (errorMessage != null) { %>
            <p class="message error"><%= errorMessage %></p>
        <% } %>

        <form id="authForm" action="${pageContext.request.contextPath}/changePin" method="post">
            <div class="form-group">
                <label for="oldPin">Mã PIN Cũ:</label>
                <input type="password" id="oldPin" name="oldPin" required>
            </div>
            <div class="form-group">
                <label for="newPin">Mã PIN Mới:</label>
                <input type="password" id="newPin" name="newPin" required>
            </div>
            <div class="form-group">
                <label for="password">Mật Khẩu:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-buttons">
                <!-- Chỉ giữ lại nút Cập Nhật -->
                <button type="submit">Cập Nhật</button>
            </div>
        </form>
    </div>
</body>
</html>
