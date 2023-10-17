package com.xixi.realm;

import com.xixi.bean.User;
import com.xixi.service.UserService;
import com.xixi.service.impl.UserServiceIml;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;

import static org.apache.shiro.util.ByteSource.*;

/**
 * Created by xijiaxiang on 2017/6/6.
 */
public class UserRealm extends AuthorizingRealm {
    //@Resource
    UserService userService=new UserServiceIml();

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        // TODO Auto-generated method stub
        String username = (String) token.getPrincipal();

        // 调用userService查询是否有此用户
        User user = userService.findUserbyName(username);
        System.out.println(user.getPassword());

        if (user == null) {
            // 抛出 帐号找不到异常
            throw new UnknownAccountException();
        }
        // 判断帐号是否锁定
       /* if (Boolean.TRUE.equals(user.getLocked())) {
            // 抛出 帐号锁定异常
            throw new LockedAccountException();
        }*/

        // 交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                user.getName(), // 用户名
                user.getPassword(), // 密码
                Util.bytes(user.getSalt()),//
                getName() // realm name
        );

        //authenticationInfo.
        return authenticationInfo;
    }
}
