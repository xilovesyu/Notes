package com.xixi.Test;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.junit.Test;

/**
 * Created by xijiaxiang on 2017/6/6.
 */

public class MD5Tets {
    public   static void main(String[] args) {
        String str = "123";
        String salt = "aa";
        int a=0110;

        System.out.println(a);
        String md5 = new Md5Hash(str, salt).toBase64();
        System.out.println(md5);
    }

}
