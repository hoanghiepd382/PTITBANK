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
import util.DBConnection;

@WebServlet(name = "UpdateLimitServlet", urlPatterns = {"/updateLimit"})

public class UpdateLimitServlet extends HttpServlet {
   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int creditScore = (int) session.getAttribute("creditScore");

        String selectedLimit = request.getParameter("limit");
        int limit;

        if ("unlimited".equals(selectedLimit)) {
            limit = Integer.MAX_VALUE;
        } else {
            try {
                limit = Integer.parseInt(selectedLimit);
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Lựa chọn hạn mức không hợp lệ.");
                request.getRequestDispatcher("views/changeLimit.jsp").forward(request, response);
                return;
            }
        }

        if ("200000000".equals(selectedLimit) && creditScore < 50000) {
            request.setAttribute("message", "Bạn không đủ điều kiện để chọn mức hạn mức 200,000,000 VND/ngày.");
        } else if ("500000000".equals(selectedLimit) && creditScore < 200000) {
            request.setAttribute("message", "Bạn không đủ điều kiện để chọn mức hạn mức 500,000,000 VND/ngày.");
        } else if ("2000000000".equals(selectedLimit) && creditScore <= 500000) {
            request.setAttribute("message", "Bạn không đủ điều kiện để chọn mức hạn mức không giới hạn.");
        } else {
            String accountNumber = (String) session.getAttribute("accountNumber");
           
         try (Connection conn = DBConnection.getConnection()) {
                    String updateLimit = "UPDATE customers SET `limit` = ? WHERE accountNumber = ?";
                    PreparedStatement stmt = conn.prepareStatement(updateLimit);
                    stmt.setInt(1, limit);
                    stmt.setString(2, accountNumber);
                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        request.setAttribute("message", "Cập nhật hạn mức thành công!");
                        session.setAttribute("currentLimit", limit);
                    } else {
                        request.setAttribute("message", "Cập nhật hạn mức thất bại. Vui lòng thử lại.");
                    }
                } catch (SQLException ex) {                   
                }
            
        }

        request.getRequestDispatcher("views/changeLimit.jsp").forward(request, response);
    }
}
