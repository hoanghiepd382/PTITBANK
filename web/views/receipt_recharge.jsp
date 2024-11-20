<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Biên Lai Nạp Tiền</title>
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
    <div class="receipt-header">Nạp tiền thành công</div>
    <div class="receipt-info">
        <p><span>Mã giao dịch:</span> <%= session.getAttribute("transactionID") %></p>
        <p><span>Số tài khoản:</span> <%= session.getAttribute("accountNumber") %></p>
        <p><span>Số điện thoại nạp tiền:</span> <%= session.getAttribute("phone") %></p>
        <p><span>Số tiền nạp:</span> <%= NumberFormat.getInstance(new Locale("vi", "VN")).format(session.getAttribute("amount")) %> VND</p>
        <p><span>Nội dung:</span> <%= session.getAttribute("rechargeContent") %></p>
    </div>
    <div class="button-group">
        <button onclick="location.href='views/dashboard.jsp'">Trang chủ</button>
        <button onclick="location.href='${pageContext.request.contextPath}/RechargeServlet'">Giao dịch khác</button>
    </div>
</div>
</body>
</html>
