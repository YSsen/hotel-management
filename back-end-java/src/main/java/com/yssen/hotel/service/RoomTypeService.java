package com.yssen.hotel.service;

import com.yssen.hotel.entity.RoomType;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface RoomTypeService {

    int insert(RoomType roomType);

    int delete(int typeId);

    int update(RoomType roomType);

    RoomType selectByName(String roomType);

    int getCount();

    RoomType selectById(int typeId);

    List<RoomType> findAllType();

    List<RoomType> findAllRestType();
}
