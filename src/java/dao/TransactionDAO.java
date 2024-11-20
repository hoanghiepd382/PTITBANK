package dao;

import models.Transaction;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TransactionDAO {
    public boolean saveTransaction(Transaction transaction) {
        String query = "INSERT INTO transactions (transactionID, transaction_date, sender_account, recipient_account, amount, message) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, transaction.getTransactionID());
            pstmt.setTimestamp(2, java.sql.Timestamp.valueOf(transaction.getTransactionDate()));
            pstmt.setString(3, transaction.getSenderAccount());
            pstmt.setString(4, transaction.getRecipientAccount());
            pstmt.setDouble(5, transaction.getAmount());
            pstmt.setString(6, transaction.getMessage());

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi
        }
    }
}
