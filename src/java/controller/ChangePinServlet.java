package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.HashUtil;

@WebServlet(name = "ChangePinServlet", urlPatterns = {"/changePin"})
public class ChangePinServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldPin = request.getParameter("oldPin");
        String newPin = request.getParameter("newPin");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        String customerID = (String) session.getAttribute("customerID");

       
        try (Connection conn = DBConnection.getConnection()) {
                String pinCheckQuery = """
                    SELECT c.pinCode, a.password 
                    FROM customers c 
                    JOIN accounts a ON c.customerID = a.customerID
                    WHERE c.customerID = ?
                    """;
                PreparedStatement pinCheckStmt = conn.prepareStatement(pinCheckQuery);
                pinCheckStmt.setString(1, customerID);
                ResultSet pinCheckRs = pinCheckStmt.executeQuery();

                if (pinCheckRs.next()) {
                    String storedPinHash = pinCheckRs.getString("pinCode");
                    String storedPasswordHash = pinCheckRs.getString("password");

                    if (storedPinHash.equals(HashUtil.hashPin(oldPin)) && storedPasswordHash.equals(HashUtil.hashPin(password))) {
                        String newPinHash = HashUtil.hashPin(newPin);
                        String updatePinQuery = "UPDATE customers SET pinCode = ? WHERE accountNumber = ?";
                        PreparedStatement updatePinStmt = conn.prepareStatement(updatePinQuery);
                        updatePinStmt.setString(1, newPinHash);
                        updatePinStmt.setString(2, accountNumber);
                        int rowsAffected = updatePinStmt.executeUpdate();
                        if (rowsAffected > 0) {                        
                            session.setAttribute("pin", newPinHash);        
                            String message = "Đổi mã PIN thành công!";
                            String encodedMessage = URLEncoder.encode(message, "UTF-8");
                            response.sendRedirect("authentication.jsp?message=" + encodedMessage);
                        } else {
                            request.setAttribute("errorMessage", "Không thể cập nhật mã PIN.");
                            request.getRequestDispatcher("authentication.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("errorMessage", "Mã PIN cũ hoặc mật khẩu không đúng.");
                        request.getRequestDispatcher("authentication.jsp").forward(request, response);
                    }
                }
            } catch (Exception ex) {
                Logger.getLogger(ChangePinServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
            }
        } 
    }

