<%@ include file="header.jsp" %>
<%@page import="java.text.NumberFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nạp Tiền Điện Thoại</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 100vh; background-color: #f3f3f3; }
        .container { width: 400px; padding: 20px; border: 1px solid #ddd; background-color: #fff; border-radius: 8px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); }
        .account-info, .amount-selection, .phone-input { margin-bottom: 20px; }
        .amount-selection label { margin-right: 15px; }
        .amount-selection input[type="radio"] { margin-right: 5px; }
        .submit-button { width: 100%; padding: 10px; background-color: #4CAF50; color: white; font-size: 16px; border: none; border-radius: 5px; cursor: pointer; }
        .submit-button:hover { background-color: #45a049; }
        .message { color: green; font-weight: bold; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Nạp Tiền Điện Thoại</h2>
        
        <!-- Thông tin tài khoản người dùng -->
        <div class="account-info">
            <p><strong>Số tài khoản:</strong> ${sessionScope.accountNumber}</p>
            <p><strong>Số dư hiện tại:</strong> 
            <%= NumberFormat.getNumberInstance().format(session.getAttribute("balance")) %> VND
            </p>

        </div>

        <!-- Hiển thị thông báo thành công nếu có -->
        <c:if test="${not empty successMessage}">
            <p class="message">${successMessage}</p>
        </c:if>
        
        <!-- Hiển thị lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <p class="error">${errorMessage}</p>
        </c:if>

        <!-- Form nạp tiền -->
        <form action="PrepareRecharge" method="post">
            <!-- Chọn mệnh giá tiền nạp -->
            <div class="amount-selection">
                <p><strong>Chọn mệnh giá:</strong></p>
                <label><input type="radio" name="amount" value="10000"> 10.000 VND</label>
                <label><input type="radio" name="amount" value="20000"> 20.000 VND</label>
                <label><input type="radio" name="amount" value="30000"> 30.000 VND</label>
                <label><input type="radio" name="amount" value="50000"> 50.000 VND</label>
                <label><input type="radio" name="amount" value="100000"> 100.000 VND</label>
                <label><input type="radio" name="amount" value="500000"> 500.000 VND</label>
            </div>

            <!-- Nhập số điện thoại -->
            <div class="phone-input">
                <label for="phone"><strong>Số điện thoại:</strong></label>
                <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
            </div>

            <!-- Nút nạp tiền -->
            <button type="submit" class="submit-button">Nạp Tiền</button>
        </form>
    </div>
</body>
</html>
