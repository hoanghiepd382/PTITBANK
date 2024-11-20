<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="headerst.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thay đổi hạn mức giao dịch</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .container {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
        }

        select, button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .message {
            color: red;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .note {
            font-size: 14px;
            color: #555;
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
    </style>

</head>
<body>

<div class="container">
    <h2>Thay đổi hạn mức giao dịch</h2>

    <!-- Hiển thị thông báo từ servlet -->
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        }

        // Lấy hạn mức hiện tại từ session
        Integer currentLimit = (Integer) session.getAttribute("currentLimit");
        if (currentLimit == null) {
            currentLimit = 50000000; // Mặc định là 50,000,000 nếu chưa có giá trị
        }
    %>

    <form action="${pageContext.request.contextPath}/updateLimit" method="POST">
        <div class="form-group">
            <label for="limit">Chọn hạn mức giao dịch</label>
            <select name="limit" id="limit">
                <option value="50000000" <%= currentLimit == 50000000 ? "selected" : "" %>>50,000,000 VND/ngày</option>
                
                <%
                    // Lấy giá trị creditScore từ session
                    Integer creditScore = (Integer) session.getAttribute("creditScore");

                    // Hiển thị các mức hạn mức giao dịch tùy thuộc vào creditScore
                    if (creditScore != null) {
                        if (creditScore >= 50000) {
                %>
                            <option value="200000000" <%= currentLimit == 200000000 ? "selected" : "" %>>200,000,000 VND/ngày</option>
                <%
                        }
                        if (creditScore >= 200000) {
                %>
                            <option value="500000000" <%= currentLimit == 500000000 ? "selected" : "" %>>500,000,000 VND/ngày</option>
                <%
                        }
                        if (creditScore > 500000) {
                %>
                            <option value="2000000000" <%= currentLimit == 2000000000 ? "selected" : "" %>>2,000,000,000 VND/ngày</option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        
        <div class="form-group">
            <button type="submit">Cập nhật hạn mức</button>
        </div>

        <!-- Thông báo lỗi nếu không đủ điều kiện -->
        <%
            if (creditScore == null || creditScore < 50000) {
        %>
            <div class="message">Bạn không đủ điều kiện để chọn mức hạn mức cao hơn 50,000,000 VND/ngày.</div>
        <%
            }
        %>
    </form>

    <!-- Ghi chú về cách thức nâng hạn mức -->
    <div class="note">
        <p><strong>Điều kiện nâng hạn mức giao dịch:</strong></p>
        <ul>
            <li>Đạt <strong>50000 điểm</strong> tín dụng để có thể nâng hạn mức lên <strong>200,000,000 VND/ngày</strong>.</li>
            <li>Đạt <strong>200000 điểm</strong> tín dụng để có thể nâng hạn mức lên <strong>500,000,000 VND/ngày</strong>.</li>
            <li>Đạt <strong>500000 điểm</strong> tín dụng để có thể nâng hạn mức lên <strong>2,000,000,000 VND/ngày</strong>.</li>
        </ul>
    </div>
</div>

</body>
</html>
