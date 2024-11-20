<%@ include file="headerst.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <style>
        /* CSS cho giao diện */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #004080;
        }
        label {
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #004080;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #0066cc;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 10px;
            text-align: center;
        }
        /* CSS cho nút quay lại */
        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 1.2em;
            color: #004080;
            background: none;
            border: none;
            cursor: pointer;
            text-decoration: underline;
        }
        .back-button:hover {
            color: #0066cc;
        }
    </style>
</head>
<body>
    
    <div class="container">
        <h2>Đổi Mật Khẩu</h2>
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <p>${errorMessage}</p>
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/ChangePasswordServlet" method="POST">
            <label for="currentPassword">Mật khẩu hiện tại:</label>
            <input type="password" id="currentPassword" name="currentPassword" required>
            
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            
            <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <button type="submit">Đổi mật khẩu</button>
        </form>
    </div>
</body>
</html>
