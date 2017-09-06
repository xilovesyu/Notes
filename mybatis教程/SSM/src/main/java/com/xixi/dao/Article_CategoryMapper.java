package com.xixi.dao;

import com.xixi.bean.Article_Category;

public interface Article_CategoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Article_Category record);

    int insertSelective(Article_Category record);

    Article_Category selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Article_Category record);

    int updateByPrimaryKey(Article_Category record);
}