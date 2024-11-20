<%@ include file="header.jsp" %>
<<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yêu cầu thiết lập mã pin</title>
    <style>
        .message {
            font-size: 18px;
            color: #333;
            margin-top: 20px;
            text-align: center;
        }
        .link {
            color: #007bff;
            text-decoration: none;
        }
        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="message">
        <p>Vui lòng thiết lập mã PIN để tiếp tục sử dụng chức năng chuyển khoản.</p>
        <p><a href="setPin.jsp" class="link">Thiết lập mã PIN tại đây</a></p>
    </div>
</body>
</html>
