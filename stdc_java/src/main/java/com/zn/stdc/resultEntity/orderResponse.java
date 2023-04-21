package com.zn.stdc.resultEntity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties({"handler","hibernateLazyInitializer"})
public class orderResponse {
    private List<cuisineAllResult> carts;
    private int userId;
    private int canteenId;
    private int addressId;
    private String payPassword;

    public List<cuisineAllResult> getCarts() {
        return carts;
    }

    public void setCarts(List<cuisineAllResult> carts) {
        this.carts = carts;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCanteenId() {
        return canteenId;
    }

    public void setCanteenId(int canteenId) {
        this.canteenId = canteenId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getPayPassword() {
        return payPassword;
    }

    public void setPayPassword(String payPassword) {
        this.payPassword = payPassword;
    }
}
