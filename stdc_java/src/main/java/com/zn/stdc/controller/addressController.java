package com.zn.stdc.controller;

import com.zn.stdc.pojo.Address;
import com.zn.stdc.pojo.User;
import com.zn.stdc.result.Result;
import com.zn.stdc.service.addressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class addressController {
    @Autowired
    addressService addressService;

    @CrossOrigin
    @PostMapping(value = "/api/getAddress")
    @ResponseBody
    public Result getAddress(@RequestBody User user){
        List<Address> list = addressService.findByUserId(user.getUserId());
        return new Result(200,list,"ok");
    }

    @CrossOrigin
    @PostMapping(value = "/api/getAddress2")
    @ResponseBody
    public Result getAddress2(@RequestBody User user){
        List<Address> list = addressService.findByUserId2(user.getUserId());
        return new Result(200,list,"ok");
    }

    @CrossOrigin
    @PostMapping(value = "/api/addAddress")
    @ResponseBody
    public Result addAddress(@RequestBody Address address){
        addressService.addAddress(address);
        return new Result(200,null,"编辑成功");
    }

    @CrossOrigin
    @PostMapping(value = "/api/delAddress")
    @ResponseBody
    public Result delAddress(@RequestBody Address address){
        addressService.delAddress(address);
        return new Result(200,null,"删除成功");
    }
}
