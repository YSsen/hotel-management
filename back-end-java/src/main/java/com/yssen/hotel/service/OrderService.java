package com.yssen.hotel.service;

import com.yssen.hotel.entity.Order;

import java.util.List;

public interface OrderService {

    int insert(Order order);

    int addOrder(Order order);

    int delete(Integer orderId);

    Order selectById(Integer orderId);
    Order selectByStatusAndRoomId(Integer orderStatus, Integer roomId);

    Order selectByNameAndPhone(String name,String phone);

    Order selectByNameAndPhone2(String name,String phone);

    List<Order> selectList(String roomNumber, String phone, Integer page, Integer limit);

    int getCount(String roomNumber, String phone);

    int update(Order record);

    int payOrder(int orderId);

    int cancelOrder(int orderId);

    Integer getOrderCount();

    List<Order> selectByUserId(int userId);

    List<Order> AllOrders();

    List<Order> UsersAllOrders(int userId);
}
