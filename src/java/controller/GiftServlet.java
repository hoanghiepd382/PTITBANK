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
import models.Gift;
import util.DBConnection;


@WebServlet(name = "GiftServlet", urlPatterns = {"/gifts"})
public class GiftServlet extends HttpServlet {
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Gift> gifts = new ArrayList<>();
      
        try (Connection conn = DBConnection.getConnection()) {
                String query = "SELECT * FROM gifts";
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    Gift gift = new Gift();                  
                    gift.setGiftID(rs.getInt("giftID"));
                    gift.setGiftName(rs.getString("giftName"));
                    gift.setCost(rs.getInt("cost"));
                    gift.setImageURL(rs.getString("imageURL"));
                    
                    gifts.add(gift);
                }
            } catch (SQLException ex) {
                 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải quà lên!");
            }
           
        request.setAttribute("gifts", gifts);
        request.getRequestDispatcher("views/gifts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userPoints = (int) session.getAttribute("creditScore");
        String giftIdParam = request.getParameter("giftId");
        int giftId = Integer.parseInt(giftIdParam);

        Gift selectedGift = null;
  
        try (Connection conn = DBConnection.getConnection()) {
                String giftQuery = "SELECT * FROM gifts WHERE giftID = ?";
                PreparedStatement giftStmt = conn.prepareStatement(giftQuery);
                giftStmt.setInt(1, giftId);
                ResultSet rs = giftStmt.executeQuery();

                if (rs.next()) {
                    selectedGift = new Gift();
                    selectedGift.setGiftID(rs.getInt("giftID"));
                    selectedGift.setGiftName(rs.getString("giftName"));
                    selectedGift.setCost(rs.getInt("cost"));
                }

                if (selectedGift != null && userPoints >= selectedGift.getCost()) {
                    String updatePointsQuery = "UPDATE customers SET creditScore = creditScore - ? WHERE accountNumber = ?";
                    PreparedStatement updatePointsStmt = conn.prepareStatement(updatePointsQuery);
                    updatePointsStmt.setInt(1, selectedGift.getCost());
                    updatePointsStmt.setString(2, (String) session.getAttribute("accountNumber"));
                    int rowsUpdated = updatePointsStmt.executeUpdate();

                    if (rowsUpdated > 0) {                  
                         // Lưu lịch sử đổi quà
                        String insertHistoryQuery = "INSERT INTO gifthistory (accountNumber, giftName, pointsUsed, exchangeDate) VALUES (?, ?, ?, NOW())";
                        PreparedStatement historyStmt = conn.prepareStatement(insertHistoryQuery);
                        historyStmt.setString(1, (String) session.getAttribute("accountNumber"));
                        historyStmt.setString(2, selectedGift.getGiftName());
                        historyStmt.setInt(3, selectedGift.getCost());
                        historyStmt.executeUpdate();
                        request.setAttribute("message", "Đổi quà thành công: " + selectedGift.getGiftName());
                        session.setAttribute("creditScore", userPoints - selectedGift.getCost());
                    } else {
                        request.setAttribute("message", "Đổi quà thất bại. Vui lòng thử lại.");
                    }
                } else {
                    request.setAttribute("message", "Không đủ điểm để đổi quà.");
                }
            } catch (SQLException ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
            }       

        doGet(request, response);
    }
}
