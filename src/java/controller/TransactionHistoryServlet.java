package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Transaction;
import util.DBConnection;

@WebServlet(name = "TransactionHistoryServlet", urlPatterns = {"/TransactionHistoryServlet"})
public class TransactionHistoryServlet extends HttpServlet {
  

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");

        if (accountNumber == null) {
            response.sendRedirect("views/login.jsp");
            return;
        }

        List<Transaction> transactions = new ArrayList<>();
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String transactionID = request.getParameter("transactionID");

        try (Connection conn = DBConnection.getConnection()){
                // Câu truy vấn SQL với điều kiện lọc theo ngày và mã giao dịch
                StringBuilder sql = new StringBuilder(
                        "SELECT t.transactionID, t.transaction_date, t.sender_account, t.recipient_account, t.amount, t.message, " +
                                "c.fullName AS recipient_name " +
                                "FROM transactions t " +
                                "LEFT JOIN customers c ON t.recipient_account = c.accountNumber " +
                                "WHERE (t.sender_account = ? OR t.recipient_account = ?)"
                );

                // Thêm điều kiện lọc theo ngày 
                if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                    sql.append(" AND t.transaction_date BETWEEN ? AND ?");
                }

                // Thêm điều kiện tìm kiếm theo mã giao dịch 
                if (transactionID != null && !transactionID.isEmpty()) {
                    sql.append(" AND t.transactionID LIKE ?");
                }

                sql.append(" ORDER BY t.transaction_date DESC");

                try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                    stmt.setString(1, accountNumber);
                    stmt.setString(2, accountNumber);

                    // Gán tham số cho ngày bắt đầu và ngày kết thúc 
                    int index = 3;
                    if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                        stmt.setString(index++, startDate);
                        stmt.setString(index++, endDate);
                    }

                    // Gán tham số cho mã giao dịch 
                    if (transactionID != null && !transactionID.isEmpty()) {
                        stmt.setString(index, "%" + transactionID + "%");
                    }

                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            String transactionIDFromDb = rs.getString("transactionID");
                            String transactionDate = rs.getString("transaction_date");
                            String senderAccount = rs.getString("sender_account");
                            String recipientAccount = rs.getString("recipient_account");
                            double amount = rs.getDouble("amount");
                            String message = rs.getString("message");
                            String recipientName = rs.getString("recipient_name");

                            // Tạo đối tượng Transaction và thêm vào danh sách
                            Transaction transaction = new Transaction(transactionIDFromDb, transactionDate, senderAccount, recipientAccount, amount, message, recipientName);
                            transactions.add(transaction);
                        }
                    }
                }
            }
         catch (SQLException e) {
            Logger.getLogger(TransactionHistoryServlet.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
            return;
        }

        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("views/transactionHistory.jsp").forward(request, response);
    }
}
