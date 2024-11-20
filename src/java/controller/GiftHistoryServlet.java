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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.GiftHistory;
import util.DBConnection;

@WebServlet(name = "GiftHistoryServlet", urlPatterns = {"/giftHistory"})
public class GiftHistoryServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        List<GiftHistory> historyList = new ArrayList<>();
        
      
        try (Connection conn = DBConnection.getConnection()) {
                String query = "SELECT * FROM gifthistory WHERE accountNumber = ? ORDER BY exchangeDate DESC";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, accountNumber);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    GiftHistory history = new GiftHistory();
                    history.setGiftName(rs.getString("giftName"));
                    history.setPointsUsed(rs.getInt("pointsUsed"));
                    history.setExchangeDate(rs.getTimestamp("exchangeDate"));
                    historyList.add(history);
                }
            } catch (SQLException ex) {
                 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
            } 
        request.setAttribute("historyList", historyList);
        request.getRequestDispatcher("views/giftHistory.jsp").forward(request, response);
    }
}
