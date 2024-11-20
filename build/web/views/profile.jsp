<%@ include file="headerst.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cài đặt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: auto;
            margin: 0;
        }
        .settings-container {
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
        input[type="text"], input[type="email"], input[type="date"] {
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
            flex: 1; /* Để nút chiếm đều không gian */
            padding: 12px;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin: 0 5px; /* Khoảng cách giữa các nút */
        }
        .update-button {
            background-color: #4CAF50; /* Màu xanh cho nút cập nhật */
        }
        .update-button:hover {
            background-color: #45a049; /* Màu khi hover */
        }
        .home-button {
            background-color: #f44336; /* Màu đỏ cho nút trang chủ */
        }
        .home-button:hover {
            background-color: #d32f2f; /* Màu khi hover */
        }
        .message {
            color: green;
            text-align: center;
        }
        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="settings-container">
        <h2>Cài đặt thông tin cá nhân</h2>

        <!-- Hiển thị thông báo nếu có -->
        <%
            String message = (String) session.getAttribute("message");
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (message != null) {
        %>
            <div class="message"><%= message %></div>
        <%
            }
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <%
            }
            session.removeAttribute("message"); // Xóa thông báo sau khi hiển thị
            session.removeAttribute("errorMessage");
        %>

        <form action="${pageContext.request.contextPath}/updateProfile" method="post">
            <label>Họ và tên:</label>
            <input type="text" value="<%= session.getAttribute("fullName") %>" readonly>

            <label>Số điện thoại:</label>
            <input type="text" name="phoneNumber" value="<%= session.getAttribute("phone") %>" required>

            <label>Số CMND/Hộ chiếu/Thẻ CCCD:</label>
            <input type="text" value="<%= session.getAttribute("customerID") %>" readonly>

            <label>Ngày cấp:</label>
            <input type="date" name="issueDate" value="<%= session.getAttribute("issueDate") != null ? session.getAttribute("issueDate") : "" %>" required>

            <label>Nơi cấp:</label>
            <input type="text" name="issuePlace" value="<%= session.getAttribute("issuePlace") %>" required>

            <label>Địa chỉ thường trú:</label>
            <input type="text" name="address" value="<%= session.getAttribute("address") %>" required>

            <label>Email:</label>
            <input type="email" name="email" value="<%= session.getAttribute("email") %>" required>

            <label>Ngày tham gia:</label>
            <input type="text" value="<%= session.getAttribute("dateOpened") %>" readonly>

            <div class="button-container">
                <button type="submit" class="update-button">Cập nhật thông tin</button>
                <button type="button" class="home-button" onclick="location.href='dashboard.jsp'">Trang chủ</button>
            </div>
        </form>
    </div>
</body>
</html>
