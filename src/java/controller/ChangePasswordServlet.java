package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.HashUtil;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/ChangePasswordServlet"})
public class ChangePasswordServlet extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Kiểm tra nếu mật khẩu mới và xác nhận mật khẩu mới khớp nhau
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("views/changePassword.jsp").forward(request, response);
            return;
        }     

        try (Connection conn = DBConnection.getConnection()) {
                // Kiểm tra mật khẩu hiện tại có đúng không
                String sql = "SELECT password FROM accounts WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String storedPassword = rs.getString("password");

                    // Nếu mật khẩu hiện tại không đúng
                    if (!storedPassword.equals(HashUtil.hashPin(currentPassword))) {
                        request.setAttribute("errorMessage", "Mật khẩu hiện tại không chính xác.");
                        request.getRequestDispatcher("views/changePassword.jsp").forward(request, response);
                        return;
                    }

                    // Cập nhật mật khẩu mới
                    String updateSql = "UPDATE accounts SET password = ? WHERE username = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setString(1, HashUtil.hashPin(newPassword));
                    updateStmt.setString(2, username);
                    int rowsUpdated = updateStmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        session.setAttribute("successMessage", "Mật khẩu đã được thay đổi thành công.");
                        session.setAttribute("password", newPassword);
                        response.sendRedirect("views//dashboard.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật mật khẩu.");
                        request.getRequestDispatcher("views/changePassword.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy tài khoản.");
                    request.getRequestDispatcher("views/changePassword.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi kết nối cơ sở dữ liệu.");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(ChangePasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } 
    }
