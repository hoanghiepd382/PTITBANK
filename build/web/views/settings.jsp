<%@ include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Lấy mã PIN từ session
    String pin = (String) session.getAttribute("pin"); // Giả sử mã PIN được lưu trong session
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt</title>
   <style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    /* Cài đặt cho container cài đặt */
    .settings-container {
        width: 100%;
        max-width: 500px;
        background: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: bold;
    }

    /* Cài đặt cho ul trong settings-container */
    .settings-container ul {
        list-style-type: none;
        padding: 0;
        margin-top: 20px;
    }

    /* Cài đặt cho li trong settings-container */
    .settings-container li {
        margin: 12px 0;
        background-color: #f1f1f1; /* Màu nền cho từng mục */
        border-radius: 5px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    }

    /* Cài đặt cho a trong settings-container */
    .settings-container a {
        display: inline-block;
        padding: 12px 20px;
        text-align: center;
        color: #fff;
        background-color: #4CAF50;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        width: 100%;
        transition: background-color 0.3s;
        box-sizing: border-box; /* Đảm bảo nút không tràn */
    }

    .settings-container a:hover {
        background-color: #45a049;
    }

    /* Đặc biệt cho nút đăng xuất */
    .settings-container .logout {
        background-color: #f44336;
    }

    .settings-container .logout:hover {
        background-color: #e53935;
    }

    /* Đảm bảo các phần tử khác ngoài settings-container không bị ảnh hưởng */
    header, body, footer {
        background: transparent !important;
        color: inherit !important;
    }
</style>
    <script>
        function redirectToPinMethod() {
            var pin = '<%= pin != null ? pin : "" %>'; // Lấy giá trị của mã PIN từ JSP
            
            if (pin) {
                // Nếu mã PIN đã thiết lập, chuyển đến trang đổi mã PIN
                window.location.href = 'authentication.jsp'; // Chuyển đến trang đổi mã PIN
            } else {
                // Nếu chưa thiết lập mã PIN, chuyển đến trang thiết lập mã PIN
                window.location.href = 'setPin.jsp'; // Chuyển đến trang thiết lập mã PIN
            }
        }

        function performLogout() {
            fetch('${pageContext.request.contextPath}/logout', { method: 'GET' })
                .then(response => {
                    if (response.ok) {
                        window.location.href = '/PTITBANK';
                    }
                })
                .catch(error => {
                    console.error('Đã xảy ra lỗi khi đăng xuất:', error);
                });
        }
    </script>
</head>
<body>
    <div class="settings-container">
        <h2>Cài đặt</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/updateProfile">Thông tin cá nhân</a></li>
            <li><a href="javascript:void(0);" onclick="redirectToPinMethod()">Phương thức xác thực</a></li>
            <li><a href="changePassword.jsp">Đổi mật khẩu</a></li>
            <li><a href="changeLimit.jsp">Thay đổi hạn mức giao dịch</a></li>
            <li><a href="openBeautifulAccount.jsp">Mở tài khoản số đẹp</a></li>
            <li><a href="javascript:void(0);" onclick="performLogout()" class="logout">Đăng xuất</a></li>
        </ul>
    </div>
</body>
</html>
