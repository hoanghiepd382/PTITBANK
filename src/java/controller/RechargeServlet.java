package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.HashUtil;
import static util.TransactionID.generateTransactionID;


@WebServlet(name = "RechargeServlet", urlPatterns = {"/RechargeServlet"})
public class RechargeServlet extends HttpServlet {
    
    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String pin = request.getParameter("pin");
        String accountNumber = (String) session.getAttribute("accountNumber");
        Double balance = (Double) session.getAttribute("balance");
        Double amount = (Double) session.getAttribute("amount");
        String phone = (String) session.getAttribute("phone");
        String pinStored = (String) session.getAttribute("pin");
        
     
        try {
            if (!pinStored.equals(HashUtil.hashPin(pin)) ) {
                request.setAttribute("errorMessage", "Mã PIN không chính xác.");
                request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(RechargeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Trừ tiền và cập nhật số dư
       
        try (Connection conn = DBConnection.getConnection()) {
                
                String transactionID = generateTransactionID();
                String rechargeContent = "Nạp điện thoại trả trước - " + phone;
                String insertTransaction = "INSERT INTO transactions (transactionID, transaction_date, sender_account, recipient_account, amount, message) VALUES (?, NOW(), ?, ?, ?, ?)";
                try (PreparedStatement transactionStmt = conn.prepareStatement(insertTransaction)){
                        transactionStmt.setString(1, transactionID);
                        transactionStmt.setString(2, accountNumber);
                        transactionStmt.setString(3, "");
                        transactionStmt.setDouble(4, amount);
                        transactionStmt.setString(5, rechargeContent);
                        transactionStmt.executeUpdate();
                        } 
                        
                String updateBalanceQuery = "UPDATE customers SET balance = balance - ? WHERE accountNumber = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateBalanceQuery)) {
                    stmt.setDouble(1, amount);
                    stmt.setString(2, accountNumber);
                    
                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        balance -= amount;  // Trừ số tiền nạp từ số dư
                        session.setAttribute("balance", balance);
                        session.setAttribute("rechargeContent", rechargeContent);
                        session.setAttribute("transactionID", transactionID);
                        // Gửi thông báo thành công
                        request.getRequestDispatcher("views/receipt_recharge.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Lỗi hệ thống. Không thể thực hiện giao dịch.");
                    }
                }
            }
         catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống. Không thể thực hiện giao dịch.");
        }
        
        // Quay lại trang nạp tiền với thông báo
        request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
    }
}
