package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import util.EmailTransaction;

@WebServlet(name = "VerifyCodeServlet", urlPatterns = {"/VerifyCodeServlet"})
public class VerifyCodeServlet extends HttpServlet {

    // Phương thức doGet để xử lý yêu cầu gửi lại mã qua liên kết GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email != null) {
            // Tạo mã xác thực mới
            String newVerificationCode = String.format("%06d", new Random().nextInt(999999));
            // Gửi mã xác thực qua email
            EmailTransaction.sendVerifyCodeEmail(email, newVerificationCode);           
            session.setAttribute("verificationCode", newVerificationCode);
    
            request.setAttribute("message", "Mã xác thực đã được gửi lại!");
        } else {
            request.setAttribute("errorMessage", "Không thể gửi lại mã. Vui lòng thử lại sau.");
        }
        // Quay lại trang nhập mã
        request.getRequestDispatcher("views/enterVerificationCode.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String email = (String) session.getAttribute("email");

        if ("resend".equals(action) && email != null) {
            // Gửi lại mã qua phương thức POST
            String newVerificationCode = String.format("%06d", new Random().nextInt(999999));
            EmailTransaction.sendVerifyCodeEmail(email, newVerificationCode);
            session.setAttribute("verificationCode", newVerificationCode);

            request.setAttribute("message", "Mã xác thực đã được gửi lại!");
            request.getRequestDispatcher("views/enterVerificationCode.jsp").forward(request, response);

        } else {
            // Xử lý xác thực mã người dùng nhập
            String enteredCode = request.getParameter("verificationCode");
            String verificationCode = (String) session.getAttribute("verificationCode");

            if (enteredCode != null && enteredCode.equals(verificationCode)) {
                response.sendRedirect("views/resetPassword.jsp");
            } else {
                request.setAttribute("errorMessage", "Mã xác thực không đúng!");
                request.getRequestDispatcher("views/enterVerificationCode.jsp").forward(request, response);
            }
        }
    }
}
