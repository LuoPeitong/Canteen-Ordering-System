package com.zn.stdc.resultEntity;

import com.zn.stdc.pojo.Tco;

import java.io.Serializable;
import java.util.List;

public class orderPro implements Serializable {
    private int orderId;
    private String location;
    private double orderPrice;
    private String orderTime;
    private String orderStatus;
    private List<Tco> tcoList;
    private String floor;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(double orderPrice) {
        this.orderPrice = orderPrice;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<Tco> getTcoList() {
        return tcoList;
    }

    public void setTcoList(List<Tco> tcoList) {
        this.tcoList = tcoList;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }
}
