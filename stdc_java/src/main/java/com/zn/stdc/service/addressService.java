package com.zn.stdc.service;

import com.zn.stdc.dao.addressDAO;
import com.zn.stdc.pojo.Address;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class addressService {
    @Autowired
    addressDAO addressDAO;

    public List<Address> findByUserId(int userId){
        return addressDAO.findByUserId(userId);
    }


    public List<Address> findByUserId2(int userId){
        List<Address> result = new ArrayList<>();

        return addressDAO.findByUserId(userId);
    }
    public void addAddress(Address address){
        addressDAO.save(address);
    }

    public void delAddress(Address address){
        addressDAO.deleteById(address.getAddressId());
    }

    public Address findByAddressId(int addressId){
        return addressDAO.findAllByAddressId(addressId);
    }
}
