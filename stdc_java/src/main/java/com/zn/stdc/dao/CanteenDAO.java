package com.zn.stdc.dao;

import com.zn.stdc.pojo.Canteen;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CanteenDAO extends JpaRepository<Canteen,Integer> {
    List<Canteen> findAllByOrderByLocation();

    Canteen findAllByCanteenId(int canteenId);

    Canteen getByUsernameAndPassword(String username, String password);
}
