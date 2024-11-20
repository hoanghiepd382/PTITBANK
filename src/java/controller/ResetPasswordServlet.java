package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import static java.lang.System.out;
import util.DBConnection;
import util.HashUtil;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPasswordServlet"})
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String rePassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        
         if (!newPassword.equals(rePassword)) {
            out.println("<script>alert('Mật khẩu và xác nhận mật khẩu không khớp!');</script>");
            response.sendRedirect("views/resetPassword.jsp");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            String updatePasswordQuery = "UPDATE accounts SET password = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(updatePasswordQuery);
            stmt.setString(1, HashUtil.hashPin(newPassword));
            stmt.setString(2, email);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("views/login.jsp");
            } else {
                request.setAttribute("errorMessage", "Đổi mật khẩu thất bại!");
                request.getRequestDispatcher("vierws/resetPassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("views/resetPassword.jsp");
        }
    }

   
}
