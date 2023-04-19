package com.zn.stdc.dao;

import com.zn.stdc.pojo.Torder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface orderDAO extends JpaRepository<Torder,Integer> {

    Torder findByOrderCheck(int check);

    List<Torder> findAllByUserId(int userId);

    Torder findAllByOrderId(int orderId);

    List<Torder> findAllByCanteenId(int canteenId);
}
