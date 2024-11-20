<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %> <!-- Import List ở đây -->
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn số tài khoản</title>
    <style>
        /* CSS styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            width: 100%;
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        form {
            margin-top: 20px;
        }
        .account-option {
            margin: 10px 0;
            display: flex;
            align-items: center;
            font-size: 16px;
        }
        .account-option input[type="radio"] {
            margin-right: 10px;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
        .no-accounts {
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chọn số tài khoản:</h2>
        <form action="accountSelection" method="post">
            <%
                // Lấy danh sách số tài khoản từ attribute
                List<String> accountNumbers = (List<String>) request.getAttribute("accountNumbers");

                // Kiểm tra nếu danh sách không rỗng
                if (accountNumbers != null) {
                    // Duyệt qua danh sách và tạo các radio button
                    for (String account : accountNumbers) {
            %>
                        <div class="account-option">
                            <input type="radio" name="selectedAccount" value="<%= account %>" required>
                            <%= account %>
                        </div>
            <%
                    }
                } else {
            %>
                <p class="no-accounts">Không có số tài khoản nào để hiển thị.</p>
            <%
                }
            %>
            <button type="submit">Xác nhận</button>
        </form>
    </div>
</body>
</html>
