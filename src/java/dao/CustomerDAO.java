package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import util.DBConnection;

public class CustomerDAO {

    // Phương thức thêm thông tin vào bảng `customers`
    public static boolean addCustomer(String customerID, String fullName, String birthDate, String email, String phone,
                                       String address, String city, String country, String gender, double balance, 
                                       int creditScore, int limit, double total) throws Exception {
        String sql = "INSERT INTO customers (customerID, fullName, dateOfBirth, email, phoneNumber, address, city, country, gender, balance, creditScore, `limit`, total) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, customerID);
            stmt.setString(2, fullName);
            stmt.setString(3, birthDate);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, address);
            stmt.setString(7, city);
            stmt.setString(8, country);
            stmt.setString(9, gender);
            stmt.setDouble(10, balance);
            stmt.setInt(11, creditScore);
            stmt.setInt(12, limit);
            stmt.setDouble(13, total);
            return stmt.executeUpdate() > 0;
        }
    }

    // Phương thức thêm thông tin vào bảng `accounts`
    public static boolean addAccount(String username, String email, String hashedPassword, String customerID, String dateOpened) throws Exception {
        String sql = "INSERT INTO accounts (username, email, password, customerID, dateOpened) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, hashedPassword);
            stmt.setString(4, customerID);
            stmt.setString(5, dateOpened);
            return stmt.executeUpdate() > 0;
        }
    }
}
