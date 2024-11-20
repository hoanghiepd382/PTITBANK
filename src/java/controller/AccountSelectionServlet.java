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
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import util.DBConnection;

@WebServlet(name = "AccountSelectionServlet", urlPatterns = {"/accountSelection"})
public class AccountSelectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String phone = (String) session.getAttribute("phoneNumber");
        
        // Tạo danh sách số tài khoản (bao gồm số điện thoại người dùng)
        List<String> accountNumbers = new ArrayList<>();
        accountNumbers.add(phone);  // thêm số điện thoại của người dùng
        // thêm số tài khoản ngẫu nhiên khác
        while (accountNumbers.size() < 10) {
            String randomAccount = generateRandomAccountNumber();
            if (!accountNumbers.contains(randomAccount)) {
                accountNumbers.add(randomAccount);
            }
        }
        request.setAttribute("accountNumbers", accountNumbers);
        request.getRequestDispatcher("views/accountSelection.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedAccountNumber = request.getParameter("selectedAccount");
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerID");

        try (Connection connection = DBConnection.getConnection()){      
            String sql = "UPDATE customers SET accountNumber = ? WHERE customerID = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, selectedAccountNumber);
            preparedStatement.setString(2, customerId);
            preparedStatement.executeUpdate();

            response.sendRedirect("login");

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi lưu số tài khoản.");
            request.getRequestDispatcher("views/accountSelection.jsp").forward(request, response);
        }
    }

    private String generateRandomAccountNumber() {
        Random random = new Random();
        StringBuilder accountNumber = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            accountNumber.append(random.nextInt(10));
        }
        return accountNumber.toString();
    }
}
   
