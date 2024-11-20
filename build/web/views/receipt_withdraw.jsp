<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Biên Lai Rút Tiền</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .receipt-container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
        }
        .receipt-header {
            text-align: center;
            font-size: 20px;
            margin-bottom: 20px;
        }
        .receipt-info {
            margin-bottom: 15px;
        }
        .receipt-info span {
            font-weight: bold;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .button-group button {
            padding: 10px 20px;
            margin: 0 10px;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="receipt-container">
    <div class="receipt-header">Rút Tiền Thành Công</div>
    <div class="receipt-info">
        <p><span>Số tài khoản:</span> <%= session.getAttribute("accountNumber") %></p>
        <p><span>Số tiền rút:</span> <%= session.getAttribute("formattedWithdrawAmount") %> </p>
        <p><span>Hình thức nhận:</span> Trực tiếp tại quầy</p>
        <p><span>Thời gian rút tiền:</span> <%= session.getAttribute("transactionTime") %></p>
    </div>
    <div class="button-group">
        <button onclick="location.href='${pageContext.request.contextPath}/WithdrawServlet'">Giao dịch khác</button>
        <button onclick="location.href='dashboard.jsp'">Trang chủ</button>
    </div>
</div>
</body>
</html>
