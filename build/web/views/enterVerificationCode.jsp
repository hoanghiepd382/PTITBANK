<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập mã bảo mật</title>
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
        }
        .container h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }
        .container p {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .input-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .input-container input[type="text"] {
            width: 60%;
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
        }
        .button {
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .cancel-button {
            background-color: #e4e6eb;
            color: #333;
        }
        .continue-button {
            background-color: #1877f2;
            color: #fff;
        }
        .cancel-button:hover {
            background-color: #d3d6da;
        }
        .continue-button:hover {
            background-color: #166fe5;
        }
        .link {
            font-size: 14px;
            color: #1877f2;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Nhập mã bảo mật</h2>
    <p>Vui lòng kiểm tra mã trong email của bạn. Mã này gồm 6 số.</p>
    <form action="VerifyCodeServlet" method="post">
        <div class="input-container">
            <input type="text" name="verificationCode" placeholder="Nhập mã" required>
            <span>Chúng tôi đã gửi mã cho bạn đến email của bạn<br></span>
        </div>
        <div class="button-container">
            <a href="home.jsp" class="button cancel-button">Hủy</a>
            <button type="submit" class="button continue-button">Tiếp tục</button>
        </div>
        <a href="VerifyCodeServlet?action=resend" class="link">Chưa nhận được mã?</a>
    </form>
    
    <% if (request.getAttribute("message") != null) { %>
        <p style="color: green;"><%= request.getAttribute("message") %></p>
    <% } else if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>
</div>

</body>
</html>
