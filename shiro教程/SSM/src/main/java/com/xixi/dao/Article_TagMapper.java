package com.xixi.dao;

import com.xixi.bean.Article_Tag;

public interface Article_TagMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Article_Tag record);

    int insertSelective(Article_Tag record);

    Article_Tag selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Article_Tag record);

    int updateByPrimaryKey(Article_Tag record);
}