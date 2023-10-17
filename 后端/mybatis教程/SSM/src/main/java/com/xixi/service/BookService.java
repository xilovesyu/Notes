package com.xixi.service;

import com.xixi.bean.Book;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by xijiaxiang on 2017/5/18.
 */
public interface BookService {
    List<Book> selectAll();

    List<Book> selectByPageNumSize(
            @Param("pageNum") int pageNum,
            @Param("pageSize") int pageSize

    );

    String insertABook(Book book);
}
