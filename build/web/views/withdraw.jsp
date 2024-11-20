<%@ include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rút Tiền</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #333;
        }

        .container {
            width: 90%;
            max-width: 400px;
            margin-top: 50px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #004080;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }

        .submit-button {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #004080;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #0066cc;
        }

        .alert-success {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .alert-error {
            background-color: #dc3545;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
    <script>
        // Hàm để thêm dấu phân cách hàng nghìn
        function formatMoney(input) {
            let value = input.value.replace(/,/g, ''); // Xóa các dấu phẩy hiện có
            if (!isNaN(value) && value !== '') {
                input.value = Number(value).toLocaleString('en-US'); // Thêm dấu phẩy
            } else {
                input.value = ''; // Nếu không phải số thì xóa giá trị
            }
        }

        // Hàm để xử lý giá trị trước khi gửi lên server
        function parseInput(input) {
            // Chuyển đổi lại về định dạng số để gửi lên server
            let value = input.value.replace(/,/g, ''); // Xóa dấu phẩy
            input.value = value; // Cập nhật lại giá trị ô nhập liệu
        }
    </script>
</head>
<body>
    <% 
    String accountNumber = (String) session.getAttribute("accountNumber");
    Double balance = (Double) session.getAttribute("balance");

    // Kiểm tra nếu không có tài khoản hoặc số dư
    if (accountNumber == null || balance == null) {
        response.sendRedirect("login.jsp"); // Chuyển hướng đến trang đăng nhập
        return;
    }
    %>

    <div class="container">
        <h2>Rút Tiền</h2>
        
        <!-- Hiển thị thông báo thành công hoặc lỗi -->
        <% 
        String message = (String) request.getAttribute("message");
        if (message != null) {
            if (message.contains("Thành công")) {
    %>
        <div class="alert-success"><%= message %></div>
        <% 
            } else {
        %>
        <div class="alert-error"><%= message %></div>
        <% 
            }
        }
        %>
        
        <form action="WithdrawServlet" method="post" onsubmit="parseInput(document.getElementById('amount'))">
            <div>
                <label>Số tài khoản: <strong><%= accountNumber %></strong></label>
            </div>
            <div>
                <label>Số dư khả dụng: <strong><%= String.format("%,.0f", balance) %> VND</strong></label>
            </div>
            
            <!-- Ô nhập tiền với sự kiện oninput để format tiền khi người dùng nhập -->
            <input type="text" id="amount" name="amount" placeholder="Nhập số tiền cần rút" class="input-field" required min="1000" oninput="formatMoney(this)">
            
            <input type="password" name="pin" placeholder="Nhập mã PIN" class="input-field" required>
            
            <button type="submit" class="submit-button">Rút Tiền</button>
        </form>
    </div>
</body>
</html>
