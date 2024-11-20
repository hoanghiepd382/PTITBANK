<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thiết lập mã PIN</title>
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
        .pin-container {
            width: 300px;
            background: #fff;
            padding: 20px;
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
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }
        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="pin-container">
        <h2>Thiết lập mã PIN</h2>
        <form action="${pageContext.request.contextPath}/setupPin" method="post">
            <label>Nhập mã PIN (6 chữ số):</label>
            <input type="text" name="pin" pattern="\d{6}" required>
            <button type="submit">Thiết lập mã PIN</button>
        </form>
    </div>
</body>
</html>
