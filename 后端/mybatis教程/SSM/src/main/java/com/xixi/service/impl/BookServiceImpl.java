package com.xixi.service.impl;

import com.github.pagehelper.PageHelper;
import com.xixi.bean.Book;
import com.xixi.service.BookService;
import com.xixi.dao.BookMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by xijiaxiang on 2017/5/18.
 */

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;
    @Override
    public List<Book> selectAll() {
        return bookMapper.selectAll();
    }

    @Override
    public List<Book> selectByPageNumSize(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Book> list=bookMapper.selectPage();
        return list;
    }


    //事务管理
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public String insertABook( Book book){
        bookMapper.insert(book);
        System.out.println("插入一本书："+book.toString());
        /*bookMapper.deleteByPrimaryKey(1111l);
        System.out.println("删除了一本书");*/
        return "success";
    }
}
