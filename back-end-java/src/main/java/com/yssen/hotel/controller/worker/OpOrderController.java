package com.yssen.hotel.controller.worker;

import com.yssen.hotel.entity.Order;
import com.yssen.hotel.entity.PageInfo;
import com.yssen.hotel.entity.Room;
import com.yssen.hotel.enums.OrderStatus;
import com.yssen.hotel.enums.RoomStatus;
import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.MsgType;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.OrderService;
import com.yssen.hotel.service.RoomService;
import com.yssen.hotel.utils.MyDateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * 订单接口
 */
@RestController
@RequestMapping(value = "/op/order")
public class OpOrderController {
    @Autowired
    private OrderService orderService;

    @Autowired
    private RoomService roomService;

    /**
     * 添加预订
     */
    @Transactional
    @RequestMapping(value = "/add")
    public AjaxResult addOrder(String roomNumber, String typeName, String name, String cid, String phone, int roomId,  double price,
                               int rcNum, @DateTimeFormat(pattern = "yyyy-MM-dd") Date inDate, @DateTimeFormat(pattern = "yyyy-MM-dd") Date outDate) {
        // 修改房间状态等信息
        Room room = roomService.selectById(roomId);
        room.setPhone(phone);
        room.setRoomStatus(RoomStatus.ORDERED.getCode());
        if (roomService.update(room) == 1) {
            // 计算消费金额
            Double orderCost = (MyDateTimeFormat.calculateDaysStayed(inDate, outDate)) * price;
            // 生成订单信息
            Order order = new Order(name, cid, phone, roomId,typeName, roomNumber, price, rcNum, inDate, outDate, OrderStatus.RESERVE.getCode(), orderCost);
            int re = orderService.addOrder(order);
            if (re != 1) return ResponseTool.failed(MsgType.FAILED);
        } else {
            return ResponseTool.failed(MsgType.FAILED);
        }
        return ResponseTool.success("添加成功.");
    }

    /**
     * 官网请求添加预订
     */
    @Transactional
    @RequestMapping(value = "/add2")
    public AjaxResult addOrder2(int typeId, String typeName, String name, String cid, String phone, double price,
                               int rcNum, @DateTimeFormat(pattern = "yyyy-MM-dd") Date inDate, @DateTimeFormat(pattern = "yyyy-MM-dd") Date outDate) {
        // 根据typeId随机获取roomId
        Room room = roomService.getOrderRoom(typeId);
        room.setRoomStatus(RoomStatus.ORDERED.getCode());
        room.setPhone(phone);

        Integer roomId = room.getRoomId();
        String roomNumber = room.getRoomNumber();
        // 计算消费金额
        Double orderCost = (MyDateTimeFormat.calculateDaysStayed(inDate, outDate)) * price;
        // 生成订单信息
        Order order = new Order(name, cid, phone, roomId,typeName, roomNumber, price, rcNum, inDate, outDate, OrderStatus.RESERVE.getCode(), orderCost);

        if (!(roomService.update(room) == 1 && orderService.addOrder(order)==1)) {
            return ResponseTool.failed(MsgType.FAILED);
        }
        return ResponseTool.success("添加成功.");
    }

    /**
     * 开房、入住
     */
    @Transactional
    @RequestMapping(value = "/check-in")
    public AjaxResult checkIn(String roomNumber, String typeName, String name, String cid, String phone, int roomId,  double price,
                               int rcNum, @DateTimeFormat(pattern = "yyyy-MM-dd") Date inDate) {

        // 根据roomId获取当前房间信息，根据房间状态判断是否已预定
        Room room = roomService.selectById(roomId);
        //      已预定则只需要修改房间状态为入住状态，同时根据roomId找到处于“预定单”状态的订单，修改其状态为“入住单”
        if (room.getRoomStatus() == RoomStatus.ORDERED.getCode()) {
            room.setRoomStatus(RoomStatus.IN_USE.getCode());
            Order order = orderService.selectByStatusAndRoomId(OrderStatus.RESERVE.getCode(), roomId);
            order.setOrderStatus(OrderStatus.CHECK_IN.getCode());

            if(!(roomService.update(room) == 1 && orderService.update(order) == 1)) {
                return ResponseTool.failed(MsgType.FAILED);
            }
        }
        //      未预定则需要进行预定操作，但不写入退房日期和消费金额，状态直接未入住状态和“入住单”
        else if (room.getRoomStatus() == RoomStatus.AVAILABLE.getCode()) {
            // 修改房间状态等信息
            room.setPhone(phone);
            room.setRoomStatus(RoomStatus.IN_USE.getCode());
            // 生成订单信息
            Order order = new Order(name, cid, phone, roomId,typeName, roomNumber,
                    price, rcNum, inDate, null, OrderStatus.CHECK_IN.getCode(), 0.0);
            if (!(roomService.update(room) == 1 && orderService.addOrder(order)==1)) {
                return ResponseTool.failed(MsgType.FAILED);
            }
        }
        return ResponseTool.success("添加成功.");
    }


    /**
     * 退房
     */
    @Transactional
    @RequestMapping(value = "/check-out/{roomId}")
    public AjaxResult checkOut(@PathVariable int roomId){
        // 修改房间状态，删除手机号
        Room room = roomService.selectById(roomId);
        room.setRoomStatus(RoomStatus.AVAILABLE.getCode());
        room.setPhone("");

        // 修改订单状态
        // 根据有无退房时间，进行操作：
        Order order = orderService.selectByStatusAndRoomId(OrderStatus.CHECK_IN.getCode(), roomId);
        order.setOrderStatus(OrderStatus.CHECK_OUT.getCode());
        // 有，结束
        // 没有，则写入当前时间，并计算消费金额
        if (order.getOutDate() == null) {
            Date inDate = order.getInDate();
            Date outDate = new Date();
            order.setOutDate(outDate);
            double price = order.getPrice();
            // 计算消费金额
            int days = MyDateTimeFormat.calculateDaysStayed(inDate, outDate);
            if (days <= 0) {
                days = 1;
            }
            Double orderCost = (days * price);
            order.setOrderCost(orderCost);
        }
        if (!(roomService.update(room) == 1 && orderService.update(order)==1)) {
            return ResponseTool.failed(MsgType.FAILED);
        }
        return ResponseTool.success("退房成功");
    }


    /**
     * 换房，修改订单的roomId和状态
     * 在空闲中更换，
     * 原有roomId的房间信息要：修改状态、清除手机号
     * 根据原roomId找到订单信息：修改roomId、roomNumber、typeName、price、orderCost（要看是否有退房日期）
     * 修改新roomId的房间信息：状态、手机号
     */
    @Transactional
    @RequestMapping(value = "/change")
    public AjaxResult changeRoom(int oldRoomId, int roomId, String roomNumber, String typeName, double price) {

        // 原有roomId的房间信息要：修改状态、清除手机号
        Room oldRoom = roomService.selectById(oldRoomId);
        oldRoom.setPhone("");
        oldRoom.setRoomStatus(RoomStatus.AVAILABLE.getCode());

        // 根据原roomId找到订单信息：修改roomId、roomNumber、typeName、price、orderCost（要看是否有退房日期）
        Order order;
        order = orderService.selectByStatusAndRoomId(OrderStatus.CHECK_IN.getCode(), oldRoomId);
        if (order == null) {
            order = orderService.selectByStatusAndRoomId(OrderStatus.CHANGE.getCode(), oldRoomId);
        }
        order.setRoomId(roomId);
        order.setRoomNumber(roomNumber);
        order.setTypeName(typeName);
        order.setPrice(price);
        order.setOrderStatus(OrderStatus.CHANGE.getCode());
        //消费金额，只有预定进入的需要重新计算，直接开房的因为没有退房日期不需要计算（退房时计算即可）
        if (order.getOutDate() != null) {
            Date inDate = order.getInDate();
            Date outDate = order.getOutDate();
            // 计算消费金额
            int days = MyDateTimeFormat.calculateDaysStayed(inDate, outDate);
            if (days <= 0) {
                days = 1;
            }
            Double orderCost = (days * price);
            order.setOrderCost(orderCost);
        }

        // 修改新roomId的房间信息：状态、手机号
        Room room = roomService.selectById(roomId);
        String phone = order.getPhone();
        room.setPhone(phone);
        room.setRoomStatus(RoomStatus.IN_USE.getCode());

        if (!(roomService.update(oldRoom) == 1 && orderService.update(order)==1 && roomService.update(room)==1)) {
            return ResponseTool.failed(MsgType.FAILED);
        }
        return ResponseTool.success("换房成功.");
    }


    /**
     * 已预定的房间进行入住操作，需要先获取相关预定信息
     */
    @RequestMapping(value = "/reserve-info/{roomId}")
    public AjaxResult getReservation(@PathVariable int roomId){
        return ResponseTool.success(orderService.selectByStatusAndRoomId(OrderStatus.RESERVE.getCode(), roomId));
    }

    /**
     * 退房（取消预定）
     * @param roomId
     * @return
     */
    @RequestMapping(value = "/cancel/{roomId}")
    public AjaxResult cancelOrder(@PathVariable int roomId){
        // 修改房间状态，删除手机号
        Room room = roomService.selectById(roomId);
        room.setRoomStatus(RoomStatus.AVAILABLE.getCode());
        room.setPhone("");

        // 修改订单状态
        Order order = orderService.selectByStatusAndRoomId(OrderStatus.RESERVE.getCode(), roomId);
        order.setOrderStatus(OrderStatus.CANCELED.getCode());

        if (!(roomService.update(room) == 1 && orderService.update(order)==1)) {
            return ResponseTool.failed(MsgType.FAILED);
        }

        return ResponseTool.success("取消成功.");
    }

    /**
     * 根据手机号查询预定信息（官网）
     */
    @RequestMapping(value = "/info/{phone}")
    public AjaxResult getReservation(@PathVariable String phone){
        return ResponseTool.success(orderService.selectByNameAndPhone2(null, phone));
    }

    /**
     * 列表查询，门牌号、手机号
     */
    @PostMapping("/list")
    public AjaxResult getAll(String roomNumber, String phone, Integer page, Integer limit){
        List<Order> list = orderService.selectList(roomNumber, phone, page*limit, limit);
        Integer total = orderService.getCount(roomNumber, phone);
        return ResponseTool.success(new PageInfo(total, list));
    }

    @RequestMapping(value = "/delete/{orderId}")
    public AjaxResult deleteOrder(@PathVariable int orderId){
        int re = orderService.delete(orderId);
        if(re!=1) return ResponseTool.failed(MsgType.FAILED);
        return ResponseTool.success("删除成功.");
    }


    @RequestMapping(value = "/update")
    public AjaxResult updateOrder(String roomNumber, String typeName, int orderId,String name, String cid, String phone, int roomId, double price,
                                  int rcNum, @DateTimeFormat(pattern = "yyyy-MM-dd") Date inDate, @DateTimeFormat(pattern = "yyyy-MM-dd") Date outDate,
                                  Double orderCost){
        Order order = new Order(name, cid, phone, roomId, typeName, roomNumber, price, rcNum, inDate, outDate, OrderStatus.UNPAID.getCode(), orderCost);
        order.setOrderId(orderId);
        int re =  orderService.update(order);
        if(re!=1) return ResponseTool.failed(MsgType.FAILED);
        return ResponseTool.success("修改成功.");
    }

    /**
     * 订单支付
     * @param orderId
     * @return
     */
    @RequestMapping(method = RequestMethod.POST,value = "/pay")
    public AjaxResult payOrder(int orderId){
        int re = orderService.payOrder(orderId);
        if(re!=1) return ResponseTool.failed(MsgType.FAILED);
        return ResponseTool.success("支付成功.");
    }

    /**
     * 订单超时
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/overtime")
    public int orderOver(int orderId){
        Order order = new Order(orderId,OrderStatus.OVERTIME.getCode());
        return orderService.update(order);
    }


    @RequestMapping(value = "")
    public AjaxResult getAllOrder(){
        return ResponseTool.success(orderService.AllOrders());
    }

    @RequestMapping(value = "/count")
    public AjaxResult getOrderCount(){
        return ResponseTool.success(orderService.getOrderCount());
    }

    /**
     * 根据userID查询所有订单
     * @param userId
     * @return
     */
    @RequestMapping(value = "/user/{userId}")
    public AjaxResult getByUser(@PathVariable  int userId){
        return ResponseTool.success(orderService.selectByUserId(userId));
    }


    /**
     * 根据订单号查询订单
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/{orderId}")
    public AjaxResult getById(@PathVariable Integer orderId){
        return ResponseTool.success(orderService.selectById(orderId));
    }

    /**
     * 根据姓名、预留手机号查找订单
     * 主要用于客户入住
     * @param name
     * @param phone
     * @return
     */
    @RequestMapping(value = "/withNameAndPhone")
    public AjaxResult getByNameAndPhone(String name,String phone){
        return ResponseTool.success(orderService.selectByNameAndPhone(name,phone));
    }

}
