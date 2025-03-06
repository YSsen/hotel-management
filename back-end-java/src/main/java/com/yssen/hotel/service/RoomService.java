package com.yssen.hotel.service;

import com.yssen.hotel.entity.Room;

import java.util.List;


public interface RoomService {
    int insert(Room room);
    int delete(int roomId);
    int update(Room room);
    Room selectById(int roomId);
    int getCount(String roomStatus, String typeId, String phone);
    Room selectByNumber(String roomNumber);
    List<Room> selectByStatus(int roomStatus);
    List<Room> selectByType(int typeId);
    List<Room> selectAll();
    List<Room> selectList(String roomStatus, String typeId, int page, int limit);
    List<Room> selectList2(String roomStatus, String typeId, String phone, int page, int limit);
    Room getOrderRoom(int typeId);
    int orderRoom(int typeId);
    int inRoom(int typeId);
    int outRoom(int typeId);
}
