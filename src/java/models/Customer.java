/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HiepSaDoi
 */
public class Customer {
    private String customerID;
    private String fullName;
    private String dateOfBirth;
    private String email;
    private String phoneNumber;
    private String address;
    private String city;
    private String country;
    private String gender;
    private double balance;
    private String pinCode;
    private int creditScore;
    private int limit;
    private double total;
    

    public Customer(String customerID, String fullName, String dateOfBirth, String email, String phoneNumber, String address, String city, String country, String gender, double balance, int creditScore, int limit, double total) {
        this.customerID = customerID;
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.city = city;
        this.country = country;
        this.gender = gender;
        this.balance = balance;
        this.creditScore = creditScore;
        this.limit = limit;
        this.total = total;
    }

    public String getCustomerID() {
        return customerID;
    }

    public String getFullName() {
        return fullName;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getCountry() {
        return country;
    }

    public String getGender() {
        return gender;
    }

    public double getBalance() {
        return balance;
    }

    public int getCreditScore() {
        return creditScore;
    }

    public int getLimit() {
        return limit;
    }

    public double getTotal() {
        return total;
    }

    public String getPinCode() {
        return pinCode;
    }
    
    
    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public void setCreditScore(int creditScore) {
        this.creditScore = creditScore;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setPinCode(String pinCode) {
        this.pinCode = pinCode;
    }
    
    
}
