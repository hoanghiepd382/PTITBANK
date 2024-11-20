/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class HashUtil {

    // Hàm băm mã PIN
    public static String hashPin(String pin) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(pin.getBytes());
        // Chuyển đổi mảng byte thành chuỗi Base64
        return Base64.getEncoder().encodeToString(hash);
    }
     public static boolean checkPin(String enteredPin, String storedHash) throws NoSuchAlgorithmException {
        String hashedEnteredPin = hashPin(enteredPin);
        return hashedEnteredPin.equals(storedHash);
    }
}
