<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập mã PIN</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* CSS nội tuyến cho giao diện */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 300px;
            text-align: center;
        }

        .container h2 {
            color: #333333;
            margin-bottom: 20px;
        }

        .pin-input {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            text-align: center;
            border: 2px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            outline: none;
            transition: border-color 0.3s;
        }

        .pin-input:focus {
            border-color: #2ecc71;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            width: 45%;
            text-align: center;
            text-decoration: none;
        }

        .button.cancel {
            background-color: #e74c3c;
            color: #ffffff;
            border: none;
        }

        .button.confirm {
            background-color: #2ecc71;
            color: #ffffff;
            border: none;
        }

        .button:hover {
            opacity: 0.9;
        }

        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Xác nhận mã PIN</h2>
        
        <form action="${param.action}" method="post">
            <input type="password" name="pin" class="pin-input" placeholder="Nhập mã PIN của bạn" maxlength="6" required>
            
            <div class="buttons">
                <a href="${pageContext.request.contextPath}/transfer" class="button cancel">Hủy</a>
                <button type="submit" class="button confirm">Xác nhận</button>
            </div>
            
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>
        </form>
    </div>
</body>
</html>
