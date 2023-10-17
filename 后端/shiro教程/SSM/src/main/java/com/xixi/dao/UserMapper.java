package com.xixi.dao;

import com.xixi.bean.User;

/**
 * Created by xijiaxiang on 2017/6/6.
 */
public interface UserMapper {

    User selectByName(String name);
}
