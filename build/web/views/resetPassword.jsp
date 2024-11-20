<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f2f5;
        }
        .container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .container h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
            text-align: left;
        }
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        .button {
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 45%;
        }
        .cancel-button {
            background-color: #e4e6eb;
            color: #333;
            text-decoration: none;
            text-align: center;
        }
        .confirm-button {
            background-color: #1877f2;
            color: #fff;
        }
        .cancel-button:hover {
            background-color: #d3d6da;
        }
        .confirm-button:hover {
            background-color: #166fe5;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Đặt lại mật khẩu</h2>
    <form action="${pageContext.request.contextPath}/ResetPasswordServlet" method="post">
        <div class="form-group">
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Nhập lại mật khẩu:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <div class="button-container">
            <a href="views/home.jsp" class="button cancel-button">Hủy</a>
            <button type="submit" class="button confirm-button">Xác nhận</button>
        </div>
    </form>
</div>

</body>
</html>
