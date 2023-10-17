package com.xixi.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by xijiaxiang on 2017/6/6.
 */
@Controller
public class LoginController {

    @RequestMapping("/tologin")
    public String loginmethod( ){
        //用request接收参数
        return "LoginPage";
    }

    @RequestMapping("/login")
    @ResponseBody
    public String loginmethod(HttpServletRequest request){
        //用request接收参数
        String name=(String)request.getParameter("name");
        String password=(String)request.getParameter("password");
        System.out.println(name+","+password);
        Subject subject= SecurityUtils.getSubject();
        UsernamePasswordToken token=new UsernamePasswordToken(name
        ,password);
        String error = null;
        try {
            subject.login(token);
        } catch (UnknownAccountException e) {
            error = "用户名/密码错误";
        } catch (IncorrectCredentialsException e) {
            error = "用户名/密码错误";
        } catch (ExcessiveAttemptsException e) {
            // TODO: handle exception
            error = "登录失败多次，账户锁定10分钟";
        } catch (AuthenticationException e) {
            // 其他错误，比如锁定，如果想单独处理请单独catch处理
            error = "其他错误：" + e.getMessage();
        }
        if (error != null) {// 出错了，返回登录页面
            request.setAttribute("error", error);
            return "failure"+error;
        } else {// 登录成功
            return "success";
        }
    }

}
