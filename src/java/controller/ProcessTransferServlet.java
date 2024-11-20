package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.EmailTransaction;
import util.HashUtil;
import static util.TransactionID.generateTransactionID;

@WebServlet(name = "ProcessTransferServlet", urlPatterns = {"/ProcessTransferServlet"})
public class ProcessTransferServlet extends HttpServlet {
   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin giao dịch từ request
        HttpSession session = request.getSession();
        String pin = request.getParameter("pin");
        String senderAccount = (String) session.getAttribute("accountNumber");
        String recipientAccount = (String) session.getAttribute("recipientAccount"); 
        Double amount = (Double) session.getAttribute("amount");
        String content = (String) session.getAttribute("message");
        String pinStored = (String) session.getAttribute("pin");

        try {
            if (!pinStored.equals(HashUtil.hashPin(pin)) ) {
                request.setAttribute("errorMessage", "Mã PIN không chính xác.");
                request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
                return;
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(ProcessTransferServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        try (Connection conn = DBConnection.getConnection()) {
                // Cập nhật số dư cho người gửi và người nhận
                String updateSenderBalance = "UPDATE customers SET balance = balance - ? WHERE accountNumber = ?";
                String updateRecipientBalance = "UPDATE customers SET balance = balance + ? WHERE accountNumber = ?";
                
                try (PreparedStatement senderStmt = conn.prepareStatement(updateSenderBalance);
                     PreparedStatement recipientStmt = conn.prepareStatement(updateRecipientBalance)) {
                    
                    senderStmt.setDouble(1, amount);
                    senderStmt.setString(2, senderAccount);
                    recipientStmt.setDouble(1, amount);
                    recipientStmt.setString(2, recipientAccount);

                    int senderUpdated = senderStmt.executeUpdate();
                    int recipientUpdated = recipientStmt.executeUpdate();

                    // Kiểm tra xem số dư có cập nhật thành công không
                    if (senderUpdated > 0 && recipientUpdated > 0) {
                        int creditPoints = (int) (amount / 1000);
                        String updateCreditScore = "UPDATE customers SET creditScore = creditScore + ? WHERE accountNumber = ?";
                        try (PreparedStatement creditStmt = conn.prepareStatement(updateCreditScore)) {
                            creditStmt.setInt(1, creditPoints);
                            creditStmt.setString(2, senderAccount); // Cập nhật cho người gửi
                            creditStmt.executeUpdate();
                        }
                        
                        // Lấy số dư hiện tại của người gửi và lưu vào session
                        String getBC = "SELECT balance, creditScore FROM customers WHERE accountNumber = ?";
                        try (PreparedStatement balancecreditStmt = conn.prepareStatement(getBC)) {
                        balancecreditStmt.setString(1, senderAccount);
                        try (ResultSet rs = balancecreditStmt.executeQuery()) {
                            if (rs.next()) {
                                double balance = rs.getDouble("balance");
                                int creditScore = rs.getInt("creditScore");
                                session.setAttribute("balance", balance);
                                session.setAttribute("creditScore", creditScore);
                            }
                        }
                       }
                        // Tạo mã giao dịch và lưu thông tin giao dịch vào bảng Transaction
                        String transactionID = generateTransactionID();
                        LocalDateTime transactionDate = LocalDateTime.now();  // Tạo biến transactionDate với thời gian hiện tại
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        String formattedDateTime = transactionDate.format(formatter); // Định dạng thời gian
                        String insertTransaction = "INSERT INTO transactions (transactionID, transaction_date, sender_account, recipient_account, amount, message) VALUES (?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement transactionStmt = conn.prepareStatement(insertTransaction)){
                            transactionStmt.setString(1, transactionID);
                            transactionStmt.setString(2, formattedDateTime );
                            transactionStmt.setString(3, senderAccount);
                            transactionStmt.setString(4, recipientAccount);
                            transactionStmt.setDouble(5, amount);
                            transactionStmt.setString(6, content);

                            transactionStmt.executeUpdate();
                        }                      
                        String recipientEmail = (String) session.getAttribute("email"); // Giả sử email người dùng đã lưu trong session
                        EmailTransaction.sendTransactionEmail(recipientEmail, transactionID, senderAccount, recipientAccount, amount, content, formattedDateTime);
                        String updateTotalQuery = "UPDATE customers SET `total` = total + ? WHERE accountNumber = ?";
                        try (PreparedStatement updateTotalStmt = conn.prepareStatement(updateTotalQuery)) {
                            updateTotalStmt.setDouble(1, amount); // Cộng thêm số tiền vừa chuyển
                            updateTotalStmt.setString(2, senderAccount); // Áp dụng cho tài khoản người gửi
                            updateTotalStmt.executeUpdate();
                        }                                 
                        request.setAttribute("formattedDateTime", formattedDateTime);              
                        session.setAttribute("transactionID", transactionID);
                        // Chuyển hướng đến trang biên lai
                        request.getRequestDispatcher("views/receipt.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Giao dịch không thành công.");
                        request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProcessTransferServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
            }
        
    }
}
