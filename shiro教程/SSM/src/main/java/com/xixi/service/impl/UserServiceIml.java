package com.xixi.service.impl;

import com.xixi.bean.User;
import com.xixi.dao.UserMapper;
import com.xixi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Created by xijiaxiang on 2017/6/6.
 */
@Service
public class UserServiceIml  implements UserService{
    @Autowired
    UserMapper userMapper;

    @Override
    public User findUserbyName(String name) {
        return userMapper.selectByName(name);
    }
}
