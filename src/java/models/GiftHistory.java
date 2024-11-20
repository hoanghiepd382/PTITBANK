package models;


public class GiftHistory {
    private String giftName;
    private int pointsUsed;
    private java.sql.Timestamp exchangeDate;
    
    

    public String getGiftName() {
        return giftName;
    }

    public void setGiftName(String giftName) {
        this.giftName = giftName;
    }

    public int getPointsUsed() {
        return pointsUsed;
    }

    public void setPointsUsed(int pointsUsed) {
        this.pointsUsed = pointsUsed;
    }

    public java.sql.Timestamp getExchangeDate() {
        return exchangeDate;
    }

    public void setExchangeDate(java.sql.Timestamp exchangeDate) {
        this.exchangeDate = exchangeDate;
    }
}
