package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;

@WebServlet(name = "TransferServlet", urlPatterns = {"/transfer"})

public class TransferServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String senderAccount = (String) session.getAttribute("accountNumber");
        String recipientAccount = request.getParameter("recipientAccount");
        String amountStr = request.getParameter("amount");
        String content = request.getParameter("message");
        double amount;
        
        if (senderAccount.equals(recipientAccount)){
             request.setAttribute("errorMessage", "Tài khoản người nhận không hợp lệ.");
            request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
            return;
        }
        try {
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Số tiền không hợp lệ.");
            request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
            return;
        }
        
       
        try (Connection conn = DBConnection.getConnection()) {
                String recipientCheckQuery = "SELECT accountNumber, fullName FROM customers WHERE accountNumber = ?";
                PreparedStatement recipientCheckStmt = conn.prepareStatement(recipientCheckQuery);
                recipientCheckStmt.setString(1, recipientAccount);
                ResultSet recipientCheckRs = recipientCheckStmt.executeQuery();

                String recipientName;
                if (recipientCheckRs.next()) {
                    recipientName = recipientCheckRs.getString("fullName");
                } else {
                    request.setAttribute("errorMessage", "Tài khoản người nhận không tồn tại.");
                    request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
                    return;
                }

                // Lấy hạn mức và tổng số tiền chuyển trong ngày
                String limitCheckQuery = "SELECT `limit`, `total`, lastDate, balance FROM customers WHERE accountNumber = ?";
                PreparedStatement limitCheckStmt = conn.prepareStatement(limitCheckQuery);
                limitCheckStmt.setString(1, senderAccount);
                ResultSet limitCheckRs = limitCheckStmt.executeQuery();

                if (limitCheckRs.next()) {
                    int limit = limitCheckRs.getInt("limit");
                    double total = limitCheckRs.getDouble("total");
                    String lastDate = limitCheckRs.getString("lastDate");
                    double balance = limitCheckRs.getDouble("balance");
                    
                    String currentDate = java.time.LocalDate.now().toString();
                    if (lastDate == null || !currentDate.equals(lastDate)) {
                        total = 0; // Reset số tiền
                        String updateQuery = "UPDATE customers SET total = 0, lastDate = ? WHERE accountNumber = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, currentDate);
                            updateStmt.setString(2, senderAccount);
                            updateStmt.executeUpdate();
                        }
                    }

                    // Kiểm tra hạn mức
                    if (total + amount > limit) {
                        request.setAttribute("errorMessage", "Giao dịch vượt quá hạn mức cho phép trong ngày.");
                        request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
                        return;
                    }

                    // Kiểm tra số dư tài khoản
                    if (balance >= amount) {
                        session.setAttribute("recipientName", recipientName);
                        session.setAttribute("recipientAccount", recipientAccount);
                        session.setAttribute("amount", amount);
                        session.setAttribute("message", content);
                        response.sendRedirect("views/confirmTransfer.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Số dư không đủ để thực hiện giao dịch.");
                        request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy thông tin tài khoản.");
                    request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(TransferServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi kết nối cơ sở dữ liệu.");
                request.getRequestDispatcher("views/transfer.jsp").forward(request, response);
            }      
    }
}
