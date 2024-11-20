<%@ include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chuyển khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .transfer-container {
            width: 400px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-top: 10px;
            color: #555;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input[type="text"][readonly] {
            background-color: #f4f6f9;
        }
        .button-container {
            display: flex;
            justify-content: space-between; /* Đặt khoảng cách giữa các nút */
            margin-top: 20px; /* Khoảng cách phía trên */
        }
        button {
            width: 48%; /* Chiều rộng của nút */
            padding: 12px;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .transfer-button {
            background-color: #4CAF50; /* Màu xanh cho nút chuyển tiền */
        }
        .transfer-button:hover {
            background-color: #45a049; /* Màu khi hover */
        }
        .home-button {
            background-color: #f44336; /* Màu đỏ cho nút trang chủ */
        }
        .home-button:hover {
            background-color: #d32f2f; /* Màu khi hover */
        }
    </style>
    <script>
        function formatNumber(input) {
            // Xóa tất cả ký tự không phải số
            let value = input.value.replace(/[^0-9]/g, '');
            // Định dạng số theo phân cách hàng nghìn
            if (value) {
                input.value = Number(value).toLocaleString('en-US');
            } else {
                input.value = '';
            }
        }

        function parseInput(input) {
            // Chuyển đổi lại về định dạng số để gửi lên server
            let value = input.value.replace(/,/g, '');
            input.value = value;
        }
    </script>
</head>
<body>
    <div class="transfer-container">
        <h2>Chuyển khoản</h2>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <form action="transfer" method="post">
            <%-- Hiển thị số dư thực từ session --%>
            <label>Số dư hiện tại:</label>
            <input type="text" value="<%= NumberFormat.getNumberInstance().format(session.getAttribute("balance")) %> VND" readonly>

            <%-- Tài khoản nguồn thực từ session --%>
            <label>Tài khoản nguồn:</label>
            <input type="text" name="senderAccount" value="<%= session.getAttribute("accountNumber") %>" readonly>

            <%-- Tài khoản người nhận --%>
            <label>Tài khoản người nhận:</label>
            <input type="text" name="recipientAccount" placeholder="Nhập số tài khoản người nhận" required>

            <%-- Số tiền chuyển --%>
            <label>Số tiền chuyển:</label>
            <input type="text" name="amount" placeholder="Nhập số tiền cần chuyển" min="1000" required oninput="formatNumber(this)" onblur="parseInput(this)">

            <%-- Nội dung chuyển khoản --%>
            <label>Nội dung:</label>
            <input type="text" name="message" value="<%= session.getAttribute("fullName") %> chuyển tiền" required>

            <%-- Nút chuyển khoản và nút trang chủ --%>
            <div class="button-container">
                <button type="button" class="home-button" onclick="location.href='views/dashboard.jsp'">Trang chủ</button>
                <button type="submit" class="transfer-button">Chuyển tiền</button>
                
            </div>
        </form>
    </div>
</body>
</html>
