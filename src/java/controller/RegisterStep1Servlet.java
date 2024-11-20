/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.EmailTransaction;
import util.HashUtil;

/**
 *
 * @author HiepSaDoi
 */
@WebServlet(name = "RegisterStep1Servlet", urlPatterns = {"/RegisterStep1Servlet"})
public class RegisterStep1Servlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển tiếp người dùng tới form đăng ký nếu truy cập URL với phương thức GET
        request.getRequestDispatcher("views/registerStep1.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String dateOpened = currentDateTime.format(formatter);
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");     
     

        // Mã hóa mật khẩu
         String hashedPassword = null;
        try {
            hashedPassword = HashUtil.hashPin(password);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(RegisterStep1Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        

        // Kết nối cơ sở dữ liệu và xử lý đăng ký
          try (Connection conn = DBConnection.getConnection()) {            
            // Kiểm tra trùng lặp username hoặc email
            String checkQuery = "SELECT * FROM accounts WHERE username = ? OR email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("errorMessage", "Tên đăng nhập hoặc email đã tồn tại!");
                request.getRequestDispatcher("views/registerStep1.jsp").forward(request, response);
                return;
            }
             String verificationCode = String.format("%06d", new Random().nextInt(999999));
            try {
                EmailTransaction.sendVerifyCodeEmail(email, verificationCode);
            } catch (Exception e) {
                out.println("<script>alert('Không thể gửi email xác thực.');</script>");
                response.sendRedirect("views/registerStep1.jsp");
                return;
            }
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("password", hashedPassword); // Lưu mật khẩu đã mã hóa vào session
            session.setAttribute("dateOpened",dateOpened );
            session.setAttribute("verificationCode", verificationCode);
            
            
            response.sendRedirect("views/enterCodeEmail.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi kết nối cơ sở dữ liệu.");
            request.getRequestDispatcher("views/registerStep1.jsp").forward(request, response);
        }
    }

}
