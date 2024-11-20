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
import java.text.SimpleDateFormat;
import java.util.Date;
import util.DBConnection;
import util.HashUtil;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");   

        try (Connection conn = DBConnection.getConnection()){               
                String sql = "SELECT * FROM accounts WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);           
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String storePassword = rs.getString("password");
                    if (!HashUtil.hashPin(password).equals(storePassword)){
                        request.setAttribute("errorMessage", "Mật khẩu không đúng");
                        request.getRequestDispatcher("views/login.jsp").forward(request, response);
                        return;
                    }

                    String customerID = rs.getString("customerID");

                    // Truy vấn thêm từ bảng customers
                    String sqlc = "SELECT * FROM customers WHERE customerID = ?";
                    PreparedStatement pstmtc = conn.prepareStatement(sqlc);
                    pstmtc.setString(1, customerID);
                    ResultSet rsc = pstmtc.executeQuery();
                    
                    if (rsc.next()) {
                        // Đăng nhập thành công: tạo session và chuyển hướng đến trang dashboard
                   
                        HttpSession session = request.getSession();
                     
                        Date dateOpened = rs.getDate("dateOpened");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
                        String formattedDate = sdf.format(dateOpened);
                        session.setAttribute("dateOpened", formattedDate);
                        session.setAttribute("username", username);
                        session.setAttribute("email", rs.getString("email"));  
                        session.setAttribute("customerID", customerID);  
                        session.setAttribute("balance", rsc.getDouble("balance")); 
                        session.setAttribute("accountNumber", rsc.getString("accountNumber")); 
                        session.setAttribute("fullName", rsc.getString("fullName"));
                        session.setAttribute("phone", rsc.getString("phoneNumber"));
                        session.setAttribute("address", rsc.getString("address"));
                        session.setAttribute("pin", rsc.getString("pinCode"));
                        session.setAttribute("issueDate", rsc.getString("dateID"));
                        session.setAttribute("issuePlace", rsc.getString("addrID"));
                        session.setAttribute("creditScore", rsc.getInt("creditScore"));
                        session.setAttribute("currentLimit", rsc.getInt("limit"));
                        
                        
                        response.sendRedirect("views/dashboard.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Không tìm thấy tài khoản khách hàng.");
                        request.getRequestDispatcher("views/login.jsp").forward(request, response);
                    }
                } else {
                    // Đăng nhập thất bại: gửi thông báo lỗi và chuyển về trang login.jsp
                    request.setAttribute("errorMessage", "Tên đăng nhập không đúng!");
                    request.getRequestDispatcher("views/login.jsp").forward(request, response);
                }
            } catch (Exception e) {
                 request.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
            }
        }        
    }

