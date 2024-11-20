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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String phoneNumber = request.getParameter("phoneNumber");
        String issueDate = request.getParameter("issueDate"); // Ngày cấp
        String issuePlace = request.getParameter("issuePlace");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String customerID = (String) session.getAttribute("customerID");

        // Kết nối đến cơ sở dữ liệu
        
        try (Connection conn = DBConnection.getConnection()) {
                // Cập nhật thông tin người dùng
                String sql = "UPDATE customers SET phoneNumber = ?, dateID = ?, addrID = ?, address = ?, email = ? WHERE customerID = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, phoneNumber);
                    pstmt.setString(2, issueDate); // Cập nhật ngày cấp
                    pstmt.setString(3, issuePlace);
                    pstmt.setString(4, address);
                    pstmt.setString(5, email);
                    pstmt.setString(6, customerID);
                    pstmt.executeUpdate();
                }

                // Cập nhật thông tin mới vào session
                session.setAttribute("phoneNumber", phoneNumber);
                session.setAttribute("issueDate", issueDate); // Cập nhật ngày cấp vào session
                session.setAttribute("issuePlace", issuePlace);
                session.setAttribute("address", address);
                session.setAttribute("email", email);
                session.setAttribute("message", "Cập nhật thành công."); // Thông báo cho người dùng
                response.sendRedirect("views/profile.jsp");
            } catch (SQLException ex) {
                Logger.getLogger(UpdateProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
                session.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu.");
                response.sendRedirect("views/profile.jsp");

            }
        
    }
}
