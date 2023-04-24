package com.zn.stdc.dao;

import com.zn.stdc.pojo.Cuisine;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CuisineDAO extends JpaRepository<Cuisine,Integer> {

    //获取菜单
    List<Cuisine> findByCanteenIdOrderByClasses(int canteenId);

    Cuisine findAllByCuisineId(int cuisineId);
}
