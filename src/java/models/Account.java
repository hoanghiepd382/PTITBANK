/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HiepSaDoi
 */
public class Account {
    private String username;
    private String email;
    private String hashedPassword;
    private String customerID;
    private String dateOpened;

    public Account(String username, String email, String hashedPassword, String customerID, String dateOpened) {
        this.username = username;
        this.email = email;
        this.hashedPassword = hashedPassword;
        this.customerID = customerID;
        this.dateOpened = dateOpened;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public void setDateOpened(String dateOpened) {
        this.dateOpened = dateOpened;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public String getCustomerID() {
        return customerID;
    }

    public String getDateOpened() {
        return dateOpened;
    }
    
    
}
