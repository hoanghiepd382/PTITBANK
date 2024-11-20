/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Random;

/**
 *
 * @author HiepSaDoi
 */
public class TransactionID {
    public static String generateTransactionID() {
        int length = 10;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder transactionID = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            transactionID.append(characters.charAt(index));
        }
        return transactionID.toString();
    }
}
