/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

public class EmailTransaction {
    public static void sendTransactionEmail(String recipientEmail, String transactionID, String senderAccount, String recipientAccount, Double amount, String content, String dateTime) {
        String subject = "PTIT BANK cảm ơn quý khách";
        String emailContent = String.format("""
                                            Giao d\u1ecbch th\u00e0nh c\u00f4ng!

                                            M\u00e3 giao d\u1ecbch: %s
                                            T\u00e0i kho\u1ea3n g\u1eedi: %s
                                            T\u00e0i kho\u1ea3n nh\u1eadn: %s
                                            S\u1ed1 ti\u1ec1n: %,.2f VND
                                            N\u1ed9i dung: %s
                                            Th\u1eddi gian giao d\u1ecbch: %s

                                            C\u1ea3m \u01a1n b\u1ea1n \u0111\u00e3 s\u1eed d\u1ee5ng d\u1ecbch v\u1ee5.""",
            transactionID, senderAccount, recipientAccount, amount, content, dateTime
        );

        String smtpUser = "hhtrinh2505@gmail.com";
        String smtpPassword = "gslj zyxq baxt ekqg";


        // Gửi email bằng lớp EmailSender
        boolean emailSent = EmailSender.send(recipientEmail, subject, emailContent, smtpUser, smtpPassword);

        if (emailSent) {
            System.out.println("Email sent successfully!");
        } else {
            System.out.println("Failed to send email.");
        }
    }
    public static void sendWithdrawEmail(String recipientEmail, String transactionID, String senderAccount, Double amount, String dateTime) {
        String subject = "PTIT BANK cảm ơn quý khách";
       String emailContent = String.format("""
                                           Giao d\u1ecbch th\u00e0nh c\u00f4ng!
                                           
                                           M\u00e3 giao d\u1ecbch: %s
                                           T\u00e0i kho\u1ea3n r\u00fat ti\u1ec1n: %s
                                           S\u1ed1 ti\u1ec1n r\u00fat: %,.2f VND
                                           Th\u1eddi gian giao d\u1ecbch: %s
                                           
                                           C\u1ea3m \u01a1n b\u1ea1n \u0111\u00e3 s\u1eed d\u1ee5ng d\u1ecbch v\u1ee5.""",
        transactionID, senderAccount, amount, dateTime
    );

        String smtpUser = "hhtrinh2505@gmail.com";
        String smtpPassword = "gslj zyxq baxt ekqg";


        // Gửi email bằng lớp EmailSender
        boolean emailSent = EmailSender.send(recipientEmail, subject, emailContent, smtpUser, smtpPassword);

        if (emailSent) {
            System.out.println("Email sent successfully!");
        } else {
            System.out.println("Failed to send email.");
        }
    }
    public static void sendVerifyCodeEmail(String recipientEmail, String verificationCode) {
        String subject = "PTIT BANK - Mã xác thực của bạn";
        String emailContent = String.format("""
                                            Mã xác thực của bạn là: %s
                                            
                                            Vui lòng nhập mã này để hoàn tất quá trình xác thực.
                                            
                                            Cảm ơn bạn đã sử dụng dịch vụ.""",
            verificationCode
        );

        String smtpUser = "hhtrinh2505@gmail.com";
        String smtpPassword = "gslj zyxq baxt ekqg";

        boolean emailSent = EmailSender.send(recipientEmail, subject, emailContent, smtpUser, smtpPassword);

        if (emailSent) {
            System.out.println("Verification email sent successfully!");
        } else {
            System.out.println("Failed to send verification email.");
        }
    }
}