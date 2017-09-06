package com.xixi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by xijiaxiang on 2017/5/18.
 */
@Controller
public class IndexController {
    @RequestMapping("/")
    public String helloworld(){
        return "Index";
    }
}
