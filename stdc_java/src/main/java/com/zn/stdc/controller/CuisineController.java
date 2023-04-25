package com.zn.stdc.controller;

import com.zn.stdc.pojo.Canteen;
import com.zn.stdc.pojo.Cuisine;
import com.zn.stdc.result.Result;
import com.zn.stdc.resultEntity.cuisineResult;
import com.zn.stdc.service.CuisineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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

    //下架菜品
    @CrossOrigin
    @PostMapping(value = "/api/delCuisine")
    @ResponseBody
    public Result delAddress(@RequestBody Cuisine cuisine){

        Cuisine c = cuisineService.findAllByCuisineId(cuisine);
        c.setStatus((c.getStatus()==1?0:1));
        if(c!=null){
            cuisineService.addCuisine(c);
            return new Result(200,c,"操作成功");
        }
        else{
            return new Result(201,null,"操作失败");
        }
    }

    //上传图片
    @CrossOrigin
    @PostMapping(value = "/api/upload")
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file){

        try {
            String fileName = file.getOriginalFilename();
            // TODO: 根据需要生成新的文件名
            String filePath = "D:\\workspace\\Canteen-Ordering-System\\admin_stdc\\static\\cuisinePic\\" + fileName;
            File dest = new File(filePath);
            file.transferTo(dest);
            return "/static/cuisinePic/"+fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return "error";
        }
    }
}
