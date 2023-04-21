package com.zn.stdc.service;

import com.zn.stdc.dao.*;
import com.zn.stdc.pojo.Address;
import com.zn.stdc.pojo.Torder;
import com.zn.stdc.pojo.User;
import com.zn.stdc.resultEntity.CanteenIdOrderList;
import com.zn.stdc.resultEntity.cuisineAllResult;
import com.zn.stdc.resultEntity.orderPro;
import com.zn.stdc.resultEntity.orderResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class orderService {
    @Autowired
    orderDAO orderDAO;

    @Autowired
    UserDAO userDAO;

    @Autowired
    CanteenDAO canteenDAO;

    @Autowired
    tcoDAO tcoDAO;

    @Autowired
    addressDAO addressDAO;

    public int addSettlement(orderResponse order){
        // 密码校验
        User user = userDAO.findByUserId(order.getUserId());
        if(!user.getPayPassword().equals(order.getPayPassword())){
            return -2;
        }

        List<cuisineAllResult> carts = order.getCarts();

        //计算总价
        double sum = 0;
        for(cuisineAllResult c : carts){
            sum+=c.getPrice()*c.getQuantity();
        }



        //判断余额是否够结算。总价比余额小的时候为true
        if( user.getBalance() - sum < 0){
            return -1;
        }
        else{
            user.setBalance(user.getBalance()-sum);
            userDAO.save(user);
        }

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
        Timestamp now= new Timestamp(System.currentTimeMillis());//获取系统当前时间
        String timestamp= df.format(now);

        //随机数生成检查位，用于“插入torder表后，根据检查位获取orderId”
        Random r = new Random();
        int check = r.nextInt(10000);

        Torder order1 = new Torder();
        order1.setOrderPrice(sum);
        order1.setOrderTime(timestamp);
        order1.setOrderCheck(check);
        order1.setCanteenId(order.getCanteenId());
        order1.setUserId(order.getUserId());
        order1.setAddressId(order.getAddressId());
        order1.setOrderStatus("false");
        orderDAO.save(order1);
        return check;
    }

    public void editCanteenOrder(Torder torder){
        Torder t = orderDAO.findAllByOrderId(torder.getOrderId());
        if("false".equals(torder.getOrderStatus())){
            t.setOrderStatus("true");
        }
        else{
            t.setOrderStatus("false");
        }
        orderDAO.save(t);
    }

    public List<CanteenIdOrderList> getCanteenOrderList(int canteenId){
        List<Torder> TorderList = orderDAO.findAllByCanteenId(canteenId);
        System.out.println("orderService 76:" + TorderList.size());
        List<CanteenIdOrderList> result = new ArrayList<>();
        CanteenIdOrderList o = new CanteenIdOrderList();

        for(Torder t : TorderList){
            o.setOrderId(t.getOrderId());
            o.setOrderTime(t.getOrderTime());
            //获取订单详情
            o.setTcoList(tcoDAO.findAllByOrderId(t.getOrderId()));
            o.setOrderStatus(t.getOrderStatus());
            o.setCanteenId(t.getCanteenId());
            o.setAddressId(t.getAddressId());
            //根据addressId去获取信息
            Address address = addressDAO.findAllByAddressId(t.getAddressId());
            o.setMessage(address.getMessage());
            o.setConsignee(address.getConsignee());
            o.setTel(address.getTel());
            result.add(o);
            o = new CanteenIdOrderList();
        }
        return result;
    }

    public List<orderPro> getOrderList(int userId){

        //该用户的全部订单
        List<Torder> TorderList = orderDAO.findAllByUserId(userId);
        System.out.println("orderService 83:" + TorderList.size());
        //返回的结果
        List<orderPro> result = new ArrayList<>();
        orderPro o = new orderPro();

        for (Torder t: TorderList) {
            o.setOrderId(t.getOrderId());
            o.setOrderTime(t.getOrderTime());
            o.setOrderPrice(t.getOrderPrice());

            o.setLocation(canteenDAO.findAllByCanteenId(t.getCanteenId()).getLocation());//获取地址
            o.setFloor(canteenDAO.findAllByCanteenId(t.getCanteenId()).getFloor());
            //获取订单详情
            o.setTcoList(tcoDAO.findAllByOrderId(t.getOrderId()));
            result.add(o);
            o = new orderPro();
        }
        return result;
    }
}
