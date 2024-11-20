package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import dao.CustomerDAO;

@WebServlet(name = "RegisterStep2Servlet", urlPatterns = {"/RegisterStep2Servlet"})
public class RegisterStep2Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/registerStep2.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String email = (String) session.getAttribute("email");
        String hashedPassword = (String) session.getAttribute("password");
        String dateOpened = (String) session.getAttribute("dateOpened");

        // Thông tin bổ sung từ bước 2
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String idNumber = request.getParameter("idNumber");
        String gender = request.getParameter("gender");
        String birthDate = request.getParameter("birthDate");
        double balance = 50000.00;
        int creditScore = 0;
        int limit = 50000000;
        double total = 0.0;

        try {
            boolean customerInserted = CustomerDAO.addCustomer(idNumber, fullName, birthDate, email, phone, address, city, country, gender, balance, creditScore, limit, total);
            
            if (customerInserted) {
                boolean accountInserted = CustomerDAO.addAccount(username, email, hashedPassword, idNumber, dateOpened);
                
                if (accountInserted) {
                    response.sendRedirect("accountSelection");
                } else {
                    request.setAttribute("errorMessage", "Lỗi khi lưu vào bảng accounts.");
                    request.getRequestDispatcher("views/registerStep2.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Lỗi khi lưu vào bảng customers.");
                request.getRequestDispatcher("views/registerStep2.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Chi tiết lỗi: " + e.getMessage());
            request.getRequestDispatcher("views/registerStep2.jsp").forward(request, response);
        }
    }
}
