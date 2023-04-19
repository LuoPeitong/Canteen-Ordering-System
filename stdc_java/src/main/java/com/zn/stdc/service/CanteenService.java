package com.zn.stdc.service;

import com.zn.stdc.dao.CanteenDAO;
import com.zn.stdc.pojo.Canteen;
import com.zn.stdc.resultEntity.Canteens;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CanteenService {
    @Autowired
    CanteenDAO canteenDAO;

    public List<Canteens> findAll(){
        List<Canteen> canteenList = canteenDAO.findAllByOrderByLocation();
        List<Canteens> canteensList =  new ArrayList<>();
        Canteens canteens = new Canteens();
        List<Canteen> canteenList1 =  new ArrayList<>();
        int count=0;
        //int count1=0;
        for (int i = 0; i < canteenList.size(); i++) {
            //true: 此时是第一次进入循环,或上一次循环把canteens添加到canteensList中了
            //canteenList.get(i).setCanteenId(count1);
            if(canteens.getLocation()==null){
                canteens.setId(count);
                canteens.setLocation(canteenList.get(i).getLocation());
                canteens.setListStare(false);
            }
            //true: canteens中存放location相同的餐厅
            if(canteenList.get(i).getLocation().equals(canteens.getLocation())){
                canteenList1.add(canteenList.get(i));
                //count1++;
            }
            else{
                //将canteens添加到canteensList中
                canteens.setCanteenList(canteenList1);
                canteensList.add(canteens);
                //回收变量
                canteenList1= new ArrayList<>();
                canteens=new Canteens();
                count++;
                //跳过这次循环
                i--;
                continue;
            }
            if(i == canteenList.size()-1){
                canteens.setCanteenList(canteenList1);
                canteensList.add(canteens);
            }
        }
        return canteensList;
    }

    public Canteen get(String username, String password){
        return canteenDAO.getByUsernameAndPassword(username, password);
    }

    public void add(Canteen canteen){
        canteen.setCanteenPicUrl("/static/logo.png");
        canteenDAO.save(canteen);
    }
}
