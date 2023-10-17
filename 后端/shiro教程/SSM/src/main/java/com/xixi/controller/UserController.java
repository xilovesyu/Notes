package com.xixi.controller;

import com.xixi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by xijiaxiang on 2017/6/6.
 */
@Controller
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("/test/user/{name}")
    @ResponseBody
    public String findUser(@PathVariable String name){
        return userService.findUserbyName(name).toString();
    }
}
