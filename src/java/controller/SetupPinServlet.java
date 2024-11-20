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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBConnection;
import util.HashUtil;

@WebServlet(name = "SetupPinServlet", urlPatterns = {"/setupPin"})
public class SetupPinServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/setPin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        String pin = request.getParameter("pin");

        if (pin == null || pin.length() != 6 || !pin.matches("\\d{6}")) {
            request.setAttribute("errorMessage", "Mã PIN phải có 6 chữ số.");
            request.getRequestDispatcher("views/setPin.jsp").forward(request, response);
            return;
        }
        String hashedPin = null;
        try {
            hashedPin = HashUtil.hashPin(pin);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(SetupPinServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        session.setAttribute("pin", hashedPin);
    
        try (Connection conn = DBConnection.getConnection()) {
                String updatePin = "UPDATE customers SET pinCode = ? WHERE accountNumber = ?";
                PreparedStatement stmt = conn.prepareStatement(updatePin);
                stmt.setString(1, hashedPin);
                stmt.setString(2, accountNumber);
                stmt.executeUpdate();
                response.sendRedirect("views/dashboard.jsp");
            } catch (SQLException ex) {
                Logger.getLogger(SetupPinServlet.class.getName()).log(Level.SEVERE, null, ex);
            }      
    }
}
