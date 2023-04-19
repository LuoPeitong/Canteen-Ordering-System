package com.zn.stdc.resultEntity;

import com.zn.stdc.pojo.Canteen;

import java.util.List;

public class Canteens {
    private int id;
    private String location;
    private List<Canteen> canteenList;
    private Boolean listStare;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public List<Canteen> getCanteenList() {
        return canteenList;
    }

    public void setCanteenList(List<Canteen> canteenList) {
        this.canteenList = canteenList;
    }

    public Boolean getListStare() {
        return listStare;
    }

    public void setListStare(Boolean listStare) {
        this.listStare = listStare;
    }
}
