package com.zn.stdc.dao;

import com.zn.stdc.pojo.Tco;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface tcoDAO extends JpaRepository<Tco,Integer> {
    List<Tco> findAllByOrderId(int orderId);
}
