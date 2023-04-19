package com.zn.stdc.controller;

import com.zn.stdc.pojo.Canteen;
import com.zn.stdc.pojo.Cuisine;
import com.zn.stdc.result.Result;
import com.zn.stdc.resultEntity.cuisineResult;
import com.zn.stdc.service.CuisineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CuisineController {
    @Autowired
    CuisineService cuisineService;

    @CrossOrigin
    @PostMapping(value = "/api/cuisineInit")
    @ResponseBody
    public Result cuisineInit(@RequestBody Canteen canteen){
        List<cuisineResult> list2 = cuisineService.getInit(canteen.getCanteenId());
        //按照前端页面中的rightArray重新写一个实体，在service中将结果放入
        return new Result(200,list2,"");
    }

    @CrossOrigin
    @PostMapping(value = "/api/addCuisine")
    @ResponseBody
    public Result addCuisine(@RequestBody Cuisine cuisine){

        cuisineService.addCuisine(cuisine);
        return new Result(200,null,"改动成功");
    }

    @CrossOrigin
    @PostMapping(value = "/api/delCuisine")
    @ResponseBody
    public Result delAddress(@RequestBody Cuisine cuisine){
        cuisineService.delCuisine(cuisine);
        return new Result(200,null,"删除成功");
    }
}
