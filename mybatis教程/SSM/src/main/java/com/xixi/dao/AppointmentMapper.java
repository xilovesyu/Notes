package com.xixi.dao;

import com.xixi.bean.Appointment;
import com.xixi.bean.AppointmentKey;

public interface AppointmentMapper {
    int deleteByPrimaryKey(AppointmentKey key);

    int insert(Appointment record);

    int insertSelective(Appointment record);

    Appointment selectByPrimaryKey(AppointmentKey key);

    int updateByPrimaryKeySelective(Appointment record);

    int updateByPrimaryKey(Appointment record);
}