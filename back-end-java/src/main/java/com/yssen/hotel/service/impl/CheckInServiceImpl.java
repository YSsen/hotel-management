package com.yssen.hotel.service.impl;

import com.yssen.hotel.entity.CheckIn;
import com.yssen.hotel.entity.Order;
import com.yssen.hotel.entity.Room;
import com.yssen.hotel.enums.OrderStatus;
import com.yssen.hotel.enums.RoomStatus;
import com.yssen.hotel.mapper.CheckInMapper;
import com.yssen.hotel.service.CheckInService;
import com.yssen.hotel.service.OrderService;
import com.yssen.hotel.service.RoomService;
import com.yssen.hotel.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CheckInServiceImpl implements CheckInService {
    @Autowired
    private CheckInMapper checkInMapper;
    @Autowired
    private OrderService orderService;
    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private RoomService roomService;

    @Override
    public int insert(CheckIn checkIn) {
        return checkInMapper.insert(checkIn);
    }

    /**
     * 入住登记
     * @param checkIn
     * 1.获取订单
     * 2.获取房间类型
     * 3.获取房间
     * @return
     */
    @Override
    @Transactional
    public Room checkIn(CheckIn checkIn) {
        Order order = orderService.selectById(checkIn.getOrderId());
        Room r = roomService.selectById(roomService.inRoom(order.getRoomId()));
        checkIn.setRoomId(r.getRoomId());
        checkIn.setRoomNumber(r.getRoomNumber());
        order.setOrderStatus(OrderStatus.CHECK_IN.getCode());
        orderService.update(order);
        checkInMapper.insert(checkIn);
        return r;
    }

    /**
     * 退房登记
     * 1.获取房间
     * 2.获取房型
     * 3.获取checkIn
     * @param roomNumber
     * @return
     */
    @Override
    public int checkOut(String  roomNumber){
        Room r = roomService.selectByNumber(roomNumber);
//        RoomType ty = roomTypeService.selectById(r.getTypeId());
        CheckIn checkIn = checkInMapper.selectLatestByRoomNumber(roomNumber);
        r.setRoomStatus(RoomStatus.AVAILABLE.getCode());
        if(roomService.update(r) <=0 )return -3;
        return checkInMapper.checkOut(checkIn.getCheckInId());
    }

    @Override
    public int delete(int checkInId) {
        return checkInMapper.deleteByPrimaryKey(checkInId);
    }

    @Override
    public int update(CheckIn checkIn) {
        return checkInMapper.updateByPrimaryKeySelective(checkIn);
    }



    @Override
    public int updateByRoomNumber(String roomNumber) {
        return checkInMapper.updateByRoomNumber(roomNumber);
    }

    @Override
    public CheckIn selectById(int checkInId) {
        return checkInMapper.selectByPrimaryKey(checkInId);
    }

    @Override
    public List<CheckIn> selectAll() {
        return checkInMapper.selectAll();
    }
}
