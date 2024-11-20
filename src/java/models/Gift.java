package models;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author HiepSaDoi
 */
public class Gift {
    private int giftID;
    private String giftName;
    private int cost;
    private String imageURL;

    public Gift(int giftID, String giftName, int cost) {
        this.giftID = giftID;
        this.giftName = giftName;
        this.cost = cost;
    }

    public Gift() {
    }
    
    public int getGiftID() {
        return giftID;
    }

    public String getGiftName() {
        return giftName;
    }

    public int getCost() {
        return cost;
    }

    public String getImageURL() {
        return imageURL;
    }
    
    
    public void setGiftID(int giftID) {
        this.giftID = giftID;
    }

    public void setGiftName(String giftName) {
        this.giftName = giftName;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
    
}
