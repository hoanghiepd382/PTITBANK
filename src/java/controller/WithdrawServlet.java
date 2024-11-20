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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.EmailTransaction;
import util.HashUtil;
import static util.TransactionID.generateTransactionID;

@WebServlet(name = "WithdrawServlet", urlPatterns = {"/WithdrawServlet"})
public class WithdrawServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/withdraw.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        Double balance = (Double) session.getAttribute("balance");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String inputPin = request.getParameter("pin");

        // Set content type for response
        response.setContentType("text/html;charset=UTF-8");

            if (accountNumber == null || balance == null) {
            request.setAttribute("message", "Không tìm thấy tài khoản hoặc số dư!");
            request.getRequestDispatcher("views/withdraw.jsp").forward(request, response);
            return;
        }

           
            try (Connection conn = DBConnection.getConnection()) {
                // Kiểm tra mã PIN
                String pinQuery = "SELECT pinCode FROM customers WHERE accountNumber = ?";
                PreparedStatement pinStmt = conn.prepareStatement(pinQuery);
                pinStmt.setString(1, accountNumber);
                ResultSet pinResult = pinStmt.executeQuery();

                if (pinResult.next()) {
                    String storedPin = pinResult.getString("pinCode");
                    if (!HashUtil.checkPin(inputPin, storedPin)) {
                        request.setAttribute("message", "Mã PIN không đúng!");
                        request.getRequestDispatcher("views/withdraw.jsp").forward(request, response);
                        return;
                    }
                } else {
                    request.setAttribute("message", "Tài khoản không tồn tại!");
                    request.getRequestDispatcher("views/withdraw.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra số dư và thực hiện rút tiền
                if (amount > balance) {
                    request.setAttribute("message", "Số dư không đủ để thực hiện giao dịch!");
                    request.getRequestDispatcher("views/withdraw.jsp").forward(request, response);
                } else {
                    String transactionID = generateTransactionID();
                    LocalDateTime transactionDate = LocalDateTime.now();  // Tạo biến transactionDate với thời gian hiện tại
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String formattedDateTime = transactionDate.format(formatter); // Định dạng thời gian
                    String insertTransaction = "INSERT INTO transactions (transactionID, transaction_date, sender_account, recipient_account, amount, message) VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement transactionStmt = conn.prepareStatement(insertTransaction)) {
                        transactionStmt.setString(1, transactionID);
                        transactionStmt.setString(2, formattedDateTime);
                        transactionStmt.setString(3, accountNumber);
                        transactionStmt.setString(4, "");
                        transactionStmt.setDouble(5, amount);
                        transactionStmt.setString(6, "Rút tiền");

                        transactionStmt.executeUpdate();
                    }
                    String recipientEmail = (String) session.getAttribute("email"); // Giả sử email người dùng đã lưu trong session
                    EmailTransaction.sendWithdrawEmail(recipientEmail, transactionID, accountNumber, amount, formattedDateTime);
                    String updateBalanceQuery = "UPDATE customers SET balance = balance - ? WHERE accountNumber = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateBalanceQuery);
                    updateStmt.setDouble(1, amount);
                    updateStmt.setString(2, accountNumber);

                    int rowsUpdated = updateStmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        // Cập nhật lại số dư trong session
                        session.setAttribute("balance", balance - amount);
                        request.setAttribute("message", "Rút tiền thành công! Vui lòng đến nhận số tiền mặt tại trung tâm");
                        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
                        String formattedAmount = currencyFormat.format(amount) + " VND";
                        session.setAttribute("formattedWithdrawAmount", formattedAmount);

                        // Định dạng thời gian rút tiền
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        String transactionTime = dateFormat.format(new java.util.Date());
                        session.setAttribute("transactionTime", transactionTime);
                        response.sendRedirect("views/receipt_withdraw.jsp");
                    } else {
                        request.setAttribute("message", "Giao dịch thất bại! Vui lòng thử lại sau.");
                        request.getRequestDispatcher("views/withdraw.jsp").forward(request, response);
                    }
                }
            } catch (SQLException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi kết nối cơ sở dữ liệu.");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(WithdrawServlet.class.getName()).log(Level.SEVERE, null, ex);
            }      
    }
}
