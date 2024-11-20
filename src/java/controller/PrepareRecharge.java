package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;



@WebServlet(name = "PrepareRecharge", urlPatterns = {"/PrepareRecharge"})
public class PrepareRecharge extends HttpServlet {
   
    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Double balance = (Double) session.getAttribute("balance");
        String phone = request.getParameter("phone");
        String amountStr = request.getParameter("amount");
        
        if (amountStr == null || phone == null) {
            request.setAttribute("errorMessage", "Vui lòng chọn mệnh giá và nhập số điện thoại.");
            request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
            return;
        }
        
        double amount = Double.parseDouble(amountStr);

        // Kiểm tra số điện thoại hợp lệ
        if (!phone.matches("^0\\d{9}$")) {
            request.setAttribute("errorMessage", "Số điện thoại không hợp lệ");
            request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra số dư
        if (balance < amount) {
            request.setAttribute("errorMessage", "Số dư không đủ để thực hiện giao dịch này.");
            request.getRequestDispatcher("views/recharge.jsp").forward(request, response);
            return;
        }
        session.setAttribute("phone", phone);
        session.setAttribute("amount", amount);
        
        request.getRequestDispatcher("views/enterPin.jsp?action=RechargeServlet").forward(request, response);
    }
}
