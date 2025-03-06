package com.yssen.hotel.service.impl;


import com.yssen.hotel.entity.RoomType;
import com.yssen.hotel.mapper.RoomTypeMapper;
import com.yssen.hotel.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomTypeServiceImpl implements RoomTypeService {
    @Autowired
    private RoomTypeMapper roomTypeMapper;

    @Override
    public int insert(RoomType roomType) {
        return roomTypeMapper.insertSelective(roomType);
    }

    @Override
    public int delete(int typeId) {
        return roomTypeMapper.deleteByPrimaryKey(typeId);
    }

    @Override
    public int update(RoomType roomType) {
        return roomTypeMapper.updateByPrimaryKeySelective(roomType);
    }

    @Override
    public RoomType selectByName(String typeName) {
        return roomTypeMapper.selectByTypeName(typeName);
    }

    @Override
    public RoomType selectById(int typeId) {
        return roomTypeMapper.selectByPrimaryKey(typeId);
    }

    @Override
    public int getCount() {return roomTypeMapper.getCount();}

    @Override
    public List<RoomType> findAllType() {
        return roomTypeMapper.selectAll();
    }

    @Override
    public List<RoomType> findAllRestType() {
        return roomTypeMapper.selectAllWithRest();
    }
}
