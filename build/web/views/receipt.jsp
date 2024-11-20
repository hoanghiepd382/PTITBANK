<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biên lai giao dịch</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .receipt-container {
            background-color: #fff;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
            max-width: 90%;
            text-align: center;
        }
        .receipt-header {
            font-size: 20px;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 20px;
        }
        .receipt-details {
            text-align: left;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 20px;
            color: #333;
        }
        .receipt-details div {
            margin-bottom: 10px;
        }
        .receipt-details span {
            font-weight: bold;
        }
        .receipt-footer {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .btn {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #ddd;
            color: #333;
        }
        .btn-secondary:hover {
            background-color: #ccc;
        }
    </style>
</head>
<body>
    <div class="receipt-container">
        <div class="receipt-header">Chuyển tiền thành công</div>
        <div class="receipt-details">
            <div><span>Mã giao dịch:</span> ${sessionScope.transactionID}</div>
            <div><span>Ngày giao dịch:</span> ${formattedDateTime}</div>
            <div><span>Tài khoản người gửi:</span> ${sessionScope.accountNumber}</div>
            <div><span>Tên người gửi:</span> ${sessionScope.fullName}</div>
            <div><span>Tài khoản người nhận:</span> ${sessionScope.recipientAccount}</div>
            <div><span>Tên người nhận:</span> ${sessionScope.recipientName}</div>
            <div><span>Số tiền:<span> <%= session.getAttribute("amount") != null ? NumberFormat.getNumberInstance().format((Number) session.getAttribute("amount")) + " VND" : "" %></div>
            <div><span>Nội dung:</span> ${sessionScope.message}</div>
        </div>
        <div class="receipt-footer">
            <a href="${pageContext.request.contextPath}/transfer" class="btn btn-secondary">Giao dịch khác</a>
            <a href="views/dashboard.jsp" class="btn">Trang chủ</a>
        </div>
    </div>
</body>
</html>
