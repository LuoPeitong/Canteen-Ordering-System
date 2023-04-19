package com.zn.stdc.service;

import com.zn.stdc.dao.CuisineDAO;
import com.zn.stdc.dao.orderDAO;
import com.zn.stdc.dao.tcoDAO;
import com.zn.stdc.pojo.Tco;
import com.zn.stdc.pojo.Torder;
import com.zn.stdc.resultEntity.cuisineAllResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class tcoService {
    @Autowired
    tcoDAO tcoDAO;

    @Autowired
    orderDAO orderDAO;

    @Autowired
    CuisineDAO cuisineDAO;

    public void add(List<cuisineAllResult> carts, int check){
        Torder order = orderDAO.findByOrderCheck(check);
        int orderId = order.getOrderId();
        Tco t = new Tco();
        for(cuisineAllResult c : carts){
            t.setOrderId(orderId);
            t.setCuisineId(c.getCuisineId());
            t.setQuantity(c.getQuantity());
            t.setCuisineName(cuisineDAO.findAllByCuisineId(c.getCuisineId()).getCuisineName());
            tcoDAO.save(t);
            t = new Tco();
        }
    }
}
