package com.yssen.hotel.mapper;

import com.yssen.hotel.entity.RoomType;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface RoomTypeMapper {
    Integer getCount();
    int deleteByPrimaryKey(Integer typeId);

    int insert(RoomType record);

    int insertSelective(RoomType record);

    RoomType selectByPrimaryKey(Integer typeId);

    int updateByPrimaryKeySelective(RoomType record);

    int updateByPrimaryKey(RoomType record);

    List<RoomType> selectAll();

    RoomType selectByTypeName(String typeName);

    List<RoomType> selectAllWithRest();
}
