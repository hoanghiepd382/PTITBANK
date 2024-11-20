package dao;

import models.Account;
import models.Customer;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AccountDAO {
    
    // Kiểm tra tài khoản và trả về đối tượng Account nếu tồn tại
    public Account checkAccount(String username) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM accounts WHERE username = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Account(
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("customerID"),
                    rs.getDate("dateOpened").toString()
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra thông tin khách hàng và trả về đối tượng Customer nếu tồn tại
    public Customer checkCustomer(String customerID) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE customerID = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Customer(
                    rs.getString("customerID"),
                    rs.getString("fullName"),
                    rs.getString("dateOfBirth"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("address"),
                    rs.getString("city"),
                    rs.getString("country"),
                    rs.getString("gender"),
                    rs.getDouble("balance"),
                    rs.getInt("creditScore"),
                    rs.getInt("limit"),
                    rs.getDouble("total")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
