package com.zn.stdc.controller;

import com.zn.stdc.pojo.Canteen;
import com.zn.stdc.pojo.Torder;
import com.zn.stdc.pojo.User;
import com.zn.stdc.result.Result;
import com.zn.stdc.resultEntity.CanteenIdOrderList;
import com.zn.stdc.resultEntity.cuisineAllResult;
import com.zn.stdc.resultEntity.orderPro;
import com.zn.stdc.resultEntity.orderResponse;
import com.zn.stdc.service.UserService;
import com.zn.stdc.service.orderService;
import com.zn.stdc.service.tcoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class orderController {

    @Autowired
    orderService orderService;

    @Autowired
    tcoService tcoService;

    @Autowired
    UserService userService;

    //<结算>操作，数据库中增加一条数据。
    @CrossOrigin
    @PostMapping(value = "/api/Settlement")
    @ResponseBody
    public Result Settlement(@RequestBody orderResponse order) {

        List<cuisineAllResult> carts = order.getCarts();
        int check = orderService.addSettlement(order);
        if(check==-1){
            return new Result(205,null,"余额不足");
        }
        tcoService.add(carts, check);

        User user = userService.getByUserId(order.getUserId());
        return new Result(200,user,"支付成功");
    }

    //<获取个人订单>,根据userId获取list
    @CrossOrigin
    @PostMapping(value = "/api/getPersonalOrder")
    @ResponseBody
    public Result getPersonalOrder(@RequestBody User user) {

        List<orderPro> orderPros = orderService.getOrderList(user.getUserId());
        return new Result(200,orderPros,"获取成功");
    }

    //<获取餐厅订单>,根据CanteenId获取list
    @CrossOrigin
    @PostMapping(value = "/api/getCanteenOrder")
    @ResponseBody
    public Result getCanteenOrder(@RequestBody Canteen canteen) {

        List<CanteenIdOrderList> result = orderService.getCanteenOrderList(canteen.getCanteenId());
        return new Result(200,result,"获取成功");
    }

    //<修改餐厅订单状态>,
    @CrossOrigin
    @PostMapping(value = "/api/editCanteenOrder")
    @ResponseBody
    public Result editCanteenOrder(@RequestBody Torder torder) {

        orderService.editCanteenOrder(torder);
        return new Result(200,null,"修改成功");
    }
}
