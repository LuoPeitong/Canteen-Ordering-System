package com.zn.stdc.controller;

import com.zn.stdc.pojo.User;
import com.zn.stdc.result.Result;
import com.zn.stdc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

@Controller
public class LoginController {

    @Autowired
    UserService userService;

    @CrossOrigin
    @PostMapping(value = "/api/login")
    @ResponseBody
    public Result login(@RequestBody User requestUser) {
        String username = requestUser.getUsername();
        username = HtmlUtils.htmlEscape(username);

        User user = userService.get(username, requestUser.getPassword());
        if (null == user) {
            return new Result(400, null,"登录失败");
        } else {
            return new Result(200, user, "登录成功");
        }
    }

    @CrossOrigin
    @PostMapping(value = "/api/register")
    @ResponseBody
    public Result register(@RequestBody User requestUser){

        if(userService.isExist(requestUser.getUsername())){

            return new Result(205,null,"用户名已存在");
        } else {
            userService.add(requestUser);
            if(userService.isExist(requestUser.getUsername()))
                return new Result(200,null,"注册成功");
            else
                return new Result(500,null,"出错啦");
        }
    }

    @CrossOrigin
    @PostMapping(value = "/api/recharge")
    @ResponseBody
    public Result Recharge(@RequestBody User requestUser){
        User user1 = userService.getByUserId(requestUser.getUserId());

        user1.setBalance(requestUser.getBalance());
        userService.add(user1);
        return new Result(200,user1,"成功");
    }
}
