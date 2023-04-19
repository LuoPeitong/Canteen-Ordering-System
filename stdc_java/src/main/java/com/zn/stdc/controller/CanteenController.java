package com.zn.stdc.controller;

import com.zn.stdc.pojo.Canteen;
import com.zn.stdc.resultEntity.Canteens;
import com.zn.stdc.result.Result;
import com.zn.stdc.service.CanteenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import java.util.List;

@Controller
public class CanteenController {

    @Autowired
    CanteenService canteenService;

    @CrossOrigin
    @PostMapping(value = "/api/getCanteen")
    @ResponseBody
    public Result getCanteen() {
        List<Canteens> canteensList = canteenService.findAll();
        return new Result(200, canteensList,"成功了");
    }

    @CrossOrigin
    @PostMapping(value = "/api/canteenLogin")
    @ResponseBody
    public Result canteenLogin(@RequestBody Canteen requestUser) {
        String username = requestUser.getUsername();
        username = HtmlUtils.htmlEscape(username);

        Canteen canteen = canteenService.get(username, requestUser.getPassword());
        if (null == canteen) {
            return new Result(400, null,"登录失败");
        } else {
            return new Result(200, canteen, "登录成功");
        }
    }

    @CrossOrigin
    @PostMapping(value = "/api/canteenRegister")
    @ResponseBody
    public Result canteenRegister(@RequestBody Canteen canteen) {
        canteenService.add(canteen);
        return new Result(200, null, "注册成功");
    }
}
