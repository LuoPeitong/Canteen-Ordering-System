package com.zn.stdc.pojo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

@Entity
@Table(name = "canteen")
@JsonIgnoreProperties({"handler","hibernateLazyInitializer"})
public class Canteen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "canteenId")
    private int canteenId;
    private String location;
    private String floor;
    private String CanteenPicUrl;
    private String username;
    private String password;

    public int getCanteenId() {
        return canteenId;
    }

    public void setCanteenId(int canteenId) {
        this.canteenId = canteenId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getCanteenPicUrl() {
        return CanteenPicUrl;
    }

    public void setCanteenPicUrl(String canteenPicUrl) {
        CanteenPicUrl = canteenPicUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
