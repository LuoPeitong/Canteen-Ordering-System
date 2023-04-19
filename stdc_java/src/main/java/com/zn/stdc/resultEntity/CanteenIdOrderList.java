package com.zn.stdc.resultEntity;

import com.zn.stdc.pojo.Tco;

import java.io.Serializable;
import java.util.List;

public class CanteenIdOrderList implements Serializable {
    private int orderId;
    private String orderTime;
    private List<Tco> tcoList;
    private int CanteenId;

    private int addressId;
    private String orderStatus;
    private String message;
    private String consignee;
    private String tel;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public List<Tco> getTcoList() {
        return tcoList;
    }

    public void setTcoList(List<Tco> tcoList) {
        this.tcoList = tcoList;
    }

    public int getCanteenId() {
        return CanteenId;
    }

    public void setCanteenId(int canteenId) {
        CanteenId = canteenId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
}
