<%@ include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Transaction" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Giao Dịch</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #333;
        }
        
        h2 {
            color: #004080;
            margin-top: 20px;
            text-align: center;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Nút Quay lại Trang Chính */
        .back-button {
            display: inline-block;
            margin: 20px 0;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #0066cc;
        }

        /* Form Tìm Kiếm */
        .search-form {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .search-form label {
            margin-right: 10px;
            font-weight: bold;
            color: #333;
        }

        .search-form input {
            padding: 8px 12px;
            margin: 8px 0;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px;
        }

        .search-form button {
            padding: 10px 20px;
            background-color: #004080;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-form button:hover {
            background-color: #0066cc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background-color: #004080;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f0f8ff;
        }

        td {
            font-size: 0.95em;
            color: #555;
        }

        .amount-positive {
            color: green;
        }

        .amount-negative {
            color: red;
        }
    </style>
</head>
<body>

    <!-- Form Tìm Kiếm Cải Tiến -->
    <form action="TransactionHistoryServlet" method="GET" class="search-form">
        <div>
            <label for="startDate">Ngày bắt đầu:</label>
            <input type="date" id="startDate" name="startDate">
        </div>
        <div>
            <label for="endDate">Ngày kết thúc:</label>
            <input type="date" id="endDate" name="endDate">
        </div>
        <div>
            <label for="transactionID">Mã giao dịch:</label>
            <input type="text" id="transactionID" name="transactionID" placeholder="Nhập mã giao dịch">
        </div>
        <div>
            <button type="submit">Tìm kiếm</button>
        </div>
    </form>

    <h1>Lịch Sử Giao Dịch</h1>
    

    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Mã Giao Dịch</th>
                    <th>Ngày Giao Dịch</th>
                    <th>TK Gửi</th>
                    <th>TK Nhận</th>
                    <th>Tên người nhận</th>
                    <th>Số Tiền (VND)</th>
                    <th>Nội Dung</th>
                </tr>
            </thead>
            <tbody>
                <%             
                    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                    String accountNumber = (String) session.getAttribute("accountNumber");

                    if (transactions != null && !transactions.isEmpty()) {
                        for (Transaction transaction : transactions) {
                            boolean isRecipient = transaction.getRecipientAccount().equals(accountNumber);
                %>
                            <tr>
                                <td><%= transaction.getTransactionID() %></td>
                                <td><%= transaction.getTransactionDate() %></td>
                                <td><%= transaction.getSenderAccount() %></td>
                                <td><%= transaction.getRecipientAccount() %></td>
                                <td><%= transaction.getRecipientName() != null && !transaction.getRecipientName().isEmpty() ? transaction.getRecipientName() : "" %></td>

                                <td>
                                    <span class="<%= isRecipient ? "amount-positive" : "amount-negative" %>">
                                        <%= isRecipient ? "+" : "-" %><%= String.format("%,d", (long) transaction.getAmount()) %> VND
                                    </span>
                                </td>
                                <td><%= transaction.getMessage() %></td>
                            </tr>
                <% 
                        }
                    } else { 
                %>
                        <tr>
                            <td colspan="7">Không có giao dịch nào</td>
                        </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
