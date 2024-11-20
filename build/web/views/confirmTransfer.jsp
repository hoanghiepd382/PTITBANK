<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận giao dịch</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* ??t ki?u CSS n?i tuy?n cho trang */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
            padding: 20px;
            text-align: center;
        }

        .container h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .transaction-details {
            text-align: left;
            margin-bottom: 20px;
        }

        .transaction-details p {
            margin: 8px 0;
            font-size: 16px;
            color: #555;
        }

        .transaction-details span {
            font-weight: bold;
            color: #333;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button {
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            flex: 1;
            margin: 0 50px;
        }

        .button.cancel {
            background-color: #e74c3c;
            color: #fff;
            border: none;
            text-decoration: none;
        }

        .button.confirm {
            background-color: #2ecc71;
            color: #fff;
            border: none;
        }

        .button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Xác nhận Thông tin Giao dịch</h2>
        
        <div class="transaction-details">
            <p>Tên người nhận: <span>${recipientName}</span></p>
            <p>Số tài khoản người nhận: <span>${recipientAccount}</span></p>
            <p>Tên ngân hàng: <span>PTIT</span></p>
            <p>Số tiền chuyển: <span><%= session.getAttribute("amount") != null ? NumberFormat.getNumberInstance().format((Number) session.getAttribute("amount")) + " VND" : "" %></span></p>
            <p>Nội dung: <span><%= session.getAttribute("message") != null ? session.getAttribute("message") : "" %></span></p>
        </div>

        <div class="buttons">
            <a href="${pageContext.request.contextPath}/transfer" class="button cancel">Hủy</a>
            <form action="${pageContext.request.contextPath}/EnterPinServlet" method="post">
                <!-- ?n các thông tin ?ã xác nh?n ?? g?i l?i sang trang xác nh?n mã PIN -->
                <input type="hidden" name="recipientAccount" value="${recipientAccount}">
                <input type="hidden" name="amount" value="${amount}">
                <input type="hidden" name="content" value="${content}">
                <button type="submit" class="button confirm">Xác nhận</button>
            </form>
        </div>
    </div>
</body>
</html>
