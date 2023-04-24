package com.zn.stdc.pojo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

@Entity
@Table(name = "cuisine")
@JsonIgnoreProperties({"handler","hibernateLazyInitializer"})
public class Cuisine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cuisineId")
    private int cuisineId;
    private int canteenId;
    private double cuisinePrice;
    private String classes;
    private String cuisinePicUrl;
    private String cuisineName;
    private int status;

    public int getCuisineId() {
        return cuisineId;
    }

    public void setCuisineId(int cuisineId) {
        this.cuisineId = cuisineId;
    }

    public int getCanteenId() {
        return canteenId;
    }

    public void setCanteenId(int canteenId) {
        this.canteenId = canteenId;
    }

    public double getCuisinePrice() {
        return cuisinePrice;
    }

    public void setCuisinePrice(double cuisinePrice) {
        this.cuisinePrice = cuisinePrice;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getCuisinePicUrl() {
        return cuisinePicUrl;
    }

    public void setCuisinePicUrl(String cuisinePicUrl) {
        this.cuisinePicUrl = cuisinePicUrl;
    }

    public String getCuisineName() {
        return cuisineName;
    }

    public void setCuisineName(String cuisineName) {
        this.cuisineName = cuisineName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
