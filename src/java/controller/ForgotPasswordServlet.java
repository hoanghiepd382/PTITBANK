package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import util.DBConnection;
import util.EmailTransaction;


@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/ForgotPasswordServlet"})
public class ForgotPasswordServlet extends HttpServlet {  
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");

        // Kiểm tra email có tồn tại       
        try (Connection conn = DBConnection.getConnection()) {
                String emailCheckQuery = "SELECT email FROM customers WHERE email = ?";
                PreparedStatement emailCheckStmt = conn.prepareStatement(emailCheckQuery);
                emailCheckStmt.setString(1, email);
                ResultSet emailCheckRs = emailCheckStmt.executeQuery();

                if (emailCheckRs.next()) {
                    // Email tồn tại, tiếp tục xử lý (ví dụ: gửi mã xác thực qua email)
                    // Ví dụ:
                    String verificationCode = generateVerificationCode();
                    EmailTransaction.sendVerifyCodeEmail(email, verificationCode);
                    session.setAttribute("email", email);
                    session.setAttribute("verificationCode", verificationCode);
                    // Điều hướng đến trang nhập mã xác thực
                    request.setAttribute("successMessage", "Mã xác thực đã được gửi qua email của bạn.");
                    request.getRequestDispatcher("views/enterVerificationCode.jsp").forward(request, response);
                } else {
                    // Email không tồn tại
                    request.setAttribute("message", "Email không tồn tại trong hệ thống.");
                    request.getRequestDispatcher("views/forgotPassword.jsp").forward(request, response);
                }
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
        }
    }
    private String generateVerificationCode() {
        // Mã giả lập để tạo mã xác thực
        int code = 100000 + new Random().nextInt(900000);
        return String.valueOf(code);
    }
}
   

