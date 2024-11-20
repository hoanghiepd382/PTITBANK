package models;

public class Transaction {
    private String transactionID;
    private String transactionDate;
    private String senderAccount;
    private String recipientAccount;
    private double amount;
    private String message;
    private String recipientName;

    public Transaction(String transactionID, String transactionDate, String senderAccount, String recipientAccount, double amount, String message, String recipientName) {
        this.transactionID = transactionID;
        this.transactionDate = transactionDate;
        this.senderAccount = senderAccount;
        this.recipientAccount = recipientAccount;
        this.amount = amount;
        this.message = message;
        this.recipientName = recipientName; 
    }

    public String getTransactionID() {
        return transactionID;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public String getSenderAccount() {
        return senderAccount;
    }

    public String getRecipientAccount() {
        return recipientAccount;
    }

    public double getAmount() {
        return amount;
    }

    public String getMessage() {
        return message;
    }

    public String getRecipientName() {
        return recipientName;
    }

    
}
