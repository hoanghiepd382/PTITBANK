<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Học Phí</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            padding: 20px;
        }

        .table-container {
            width: 100%;
            max-width: 1200px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        td {
            font-size: 14px;
            color: #333;
        }

        .status-paid {
            color: #28a745;
            font-weight: bold;
        }

        .amount {
            font-weight: bold;
            color: #333;
        }

        .action-icon {
            font-size: 18px;
            color: #333;
            cursor: pointer;
        }

        .action-icon:hover {
            color: #007bff;
        }
    </style>
</head>
<body>

<div class="table-container">
    <h1>Thông Tin Học Phí</h1>
    <table>
        <thead>
            <tr>
                <th>TT</th>
                <th>Mã HĐ</th>
                <th>Đợt thu</th>
                <th>Khoản thu</th>
                <th>Trạng thái</th>
                <th>Số tiền phải nộp</th>
                <th>Số tiền đã nộp</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <!-- Dòng mẫu 1 -->
            <tr>
                <td>1</td>
                <td>BIEOQGJAAQU</td>
                <td>Đợt thu học phí học kỳ 1 năm học 2024 - 2025</td>
                <td>- Học phí Học kỳ I (2024-2025)</td>
                <td><span class="status-paid">Đã thanh toán đủ</span></td>
                <td class="amount">13,680,000 VND</td>
                <td class="amount">13,680,000 VND</td>
                <td><span class="action-icon">📋</span></td>
            </tr>
            <!-- Dòng mẫu 2 -->
            <tr>
                <td>2</td>
                <td>047975840</td>
                <td>Đợt thu chung</td>
                <td>- YÊU CẦU CẤP GIẤY XÁC NHẬN TÌNH TRẠNG HỌC TẬP</td>
                <td><span class="status-paid">Đã thanh toán đủ</span></td>
                <td class="amount">25,000 VND</td>
                <td class="amount">25,000 VND</td>
                <td><span class="action-icon">📋</span></td>
            </tr>
            <!-- Dòng mẫu 3 -->
            <tr>
                <td>3</td>
                <td>120926811</td>
                <td>Đợt thu chung</td>
                <td>- TOEIC OLPC</td>
                <td><span class="status-paid">Đã thanh toán đủ</span></td>
                <td class="amount">1,120,000 VND</td>
                <td class="amount">1,120,000 VND</td>
                <td><span class="action-icon">📋</span></td>
            </tr>
            <!-- Dòng mẫu 4 -->
            <tr>
                <td>4</td>
                <td>120640914</td>
                <td>Đợt thu chung</td>
                <td>- Sách ED Course 1<br>- 6thang</td>
                <td><span class="status-paid">Đã thanh toán đủ</span></td>
                <td class="amount">898,000 VND</td>
                <td class="amount">898,000 VND</td>
                <td><span class="action-icon">📋</span></td>
            </tr>
            <!-- Dòng mẫu 5 -->
            <tr>
                <td>5</td>
                <td>030978707</td>
                <td>Đợt thu chung</td>
                <td>- Kinh phí làm thủ tục nhập học<br>- Bảo hiểm Y tế bắt buộc<br>- Học phí học kỳ I năm học 2022 - 2023</td>
                <td><span class="status-paid">Đã thanh toán đủ</span></td>
                <td class="amount">14,834,590 VND</td>
                <td class="amount">14,834,590 VND</td>
                <td><span class="action-icon">📋</span></td>
            </tr>
        </tbody>
    </table>
</div>

</body>
</html>
