package com.yssen.hotel.mapper;

import com.yssen.hotel.entity.Room;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public interface RoomMapper {
    Integer getCount(@Param("roomStatus") String roomStatus, @Param("typeId") String typeId, @Param("phone") String phone);
    int deleteByPrimaryKey(Integer roomId);

    int insert(Room record);

    int insertSelective(Room record);

    Room selectByPrimaryKey(Integer roomId);

    Room selectByNumber(String roomNumber);

    int updateByPrimaryKeySelective(Room record);

    int updateByPrimaryKey(Room record);

    List<Room> selectByType(Integer typeId);

    List<Room> selectByStatus(Integer roomStatus);

    List<Room> selectAll();

    List<Room> selectList(@Param("roomStatus") String roomStatus, @Param("typeId") String typeId, int page, int limit);

    List<Room> selectList2(@Param("roomStatus") String roomStatus, @Param("typeId") String typeId, @Param("phone") String phone, int page, int limit);

    Room randomSelectByTypeAndStatus(@Param("typeId") Integer typeId,@Param("roomStatus") Integer roomStatus);
}
