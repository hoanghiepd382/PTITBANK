<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đổi quà</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin-top: 50px;
        }
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            text-align: center;
        }
        .table thead {
            background-color: #007bff;
            color: white;
        }
        .btn-back {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-back:hover {
            background-color: #0056b3;
        }
        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 30px;
        }
        .message {
            text-align: center;
            font-size: 18px;
            color: #28a745;
            margin-bottom: 20px;
        }
        /* Chỉnh sửa vị trí nút quay lại */
        .btn-back-container {
            position: absolute;
            top: 20px;
            left: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Nút quay lại ở trên cùng bên trái -->
    <div class="btn-back-container">
        <a href="gifts" class="btn-back">Quay lại</a>
    </div>
    
    <h2>Lịch sử đổi quà</h2>
    
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Tên Quà Tặng</th>
                <th>Số Điểm Đã Dùng</th>
                <th>Thời Gian Đổi</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="gift" items="${historyList}">
                <tr>
                    <td>${gift.giftName}</td>
                    <td>${gift.pointsUsed}</td>
                    <td>${gift.exchangeDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
