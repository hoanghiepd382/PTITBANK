/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Thông tin kết nối cơ sở dữ liệu
    private static final String URL = "jdbc:mysql://localhost:3306/weboop"; 
    private static final String USERNAME = "root";                         
    private static final String PASSWORD = "159753";                     

    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {        
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Lỗi: Không tìm thấy driver MySQL JDBC");
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối tới cơ sở dữ liệu");
            throw e;
        }
        return connection;
    }
}
