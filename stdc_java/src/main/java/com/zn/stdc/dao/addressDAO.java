package com.zn.stdc.dao;

import com.zn.stdc.pojo.Address;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface addressDAO extends JpaRepository<Address,Integer> {

    //根据userId字段获取该用户的所有地址
    List<Address> findByUserId(int userId);

    Address findAllByAddressId(int addressId);
}
