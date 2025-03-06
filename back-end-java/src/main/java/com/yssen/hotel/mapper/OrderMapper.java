package com.yssen.hotel.mapper;

import com.yssen.hotel.entity.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface OrderMapper {

    int deleteByPrimaryKey(Integer orderId);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Integer orderId);

    Order selectByStatusAndRoomId(Integer orderStatus, Integer roomId);

    Order selectByNameAndPhone(Order record);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    Integer getOrderCount();

    List<Order> selectAll();

    List<Order> selectList(@Param("roomNumber") String roomNumber, @Param("phone") String phone, Integer page, Integer limit);

    Integer getCount(@Param("roomNumber") String roomNumber, @Param("phone") String phone);

    List<Order> selectByUserId(Integer userId);

    List<Order> selectAllByUser(@Param("userId") Integer userId,@Param("orderStatus") Integer orderStatus);


}
