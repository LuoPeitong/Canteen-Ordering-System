package com.zn.stdc.service;

import com.zn.stdc.dao.CuisineDAO;
import com.zn.stdc.pojo.Cuisine;
import com.zn.stdc.resultEntity.cuisineAllResult;
import com.zn.stdc.resultEntity.cuisineResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CuisineService {
    @Autowired
    CuisineDAO cuisineDAO;

    public void addCuisine(Cuisine cuisine){
        cuisineDAO.save(cuisine);
    }

    public Cuisine findAllByCuisineId(Cuisine cuisine){

        return cuisineDAO.findAllByCuisineId(cuisine.getCuisineId());
    }

    public List<cuisineResult> getInit(int canteenId){
        //该餐厅的全部菜品
        List<Cuisine> allList = cuisineDAO.findByCanteenIdOrderByClasses(canteenId);
        //返回的列表
        List<cuisineResult> list2 = new ArrayList<>();
        //
        List<cuisineAllResult> list3=new ArrayList<>();
        cuisineAllResult cuisineAllResult = new cuisineAllResult();

        cuisineResult cuisineResult = new cuisineResult();
        Cuisine cuisine = new Cuisine();
        for (int i = 0; i < allList.size(); i++){
            cuisine = allList.get(i);
            if(cuisineResult.getClasses()==null){
                cuisineResult.setClasses(cuisine.getClasses());
            }
            if (!cuisine.getClasses().equals(cuisineResult.getClasses())) {
                cuisineResult.setList(list3);
                list2.add(cuisineResult);
                cuisineResult = new cuisineResult();
                list3 = new ArrayList<>();
                cuisineResult.setClasses(cuisine.getClasses());

            }
            cuisineAllResult.setName(cuisine.getCuisineName());
            cuisineAllResult.setPicUrl(cuisine.getCuisinePicUrl());
            cuisineAllResult.setPrice(cuisine.getCuisinePrice());
            cuisineAllResult.setCuisineId(cuisine.getCuisineId());
            cuisineAllResult.setQuantity(0);
            cuisineAllResult.setStatus(cuisine.getStatus());
            list3.add(cuisineAllResult);
            cuisineAllResult = new cuisineAllResult();
            if(i==allList.size()-1) {
                cuisineResult.setList(list3);
                list2.add(cuisineResult);
            }
        }
        return list2;
    }
}
