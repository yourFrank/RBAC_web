package com.ty.crowdfunding.controller;

import com.ty.crowdfunding.bean.User;
import com.ty.crowdfunding.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Description 测试三大框架集合
 * @Author 71042
 * @Date 2019/9/19 19:51
 */

@Controller
@RequestMapping("/test")
public class testController {
    @Autowired
    private TestService testService;


    @RequestMapping("/index")
    public String index(){
        return "index";
    }

    @RequestMapping("/getUser")
    @ResponseBody
    public Object getUser(){
        List<User> allUser = testService.getAllUser();
        return  allUser;
    }
}
