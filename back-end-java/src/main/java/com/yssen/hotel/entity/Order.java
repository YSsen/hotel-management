package com.yssen.hotel.entity;

import java.util.Date;

public class Order {
    private Integer orderId;

    private String name;

    private String cid;

    private String phone;
    private Integer roomId;
    private String roomNumber;
    private String typeName;
    private double price;
    private Integer rcNum;
    private Date inDate;
    private Date outDate;
    private Integer orderStatus;

    private Double orderCost;

    private Date createTime;

    private Date updateTime;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Double getOrderCost() {
        return orderCost;
    }

    public void setOrderCost(Double orderCost) {
        this.orderCost = orderCost;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getRcNum() {
        return rcNum;
    }

    public void setRcNum(Integer rcNum) {
        this.rcNum = rcNum;
    }

    public Date getInDate() {
        return inDate;
    }

    public void setInDate(Date inDate) {
        this.inDate = inDate;
    }

    public Date getOutDate() {
        return outDate;
    }

    public void setOutDate(Date outDate) {
        this.outDate = outDate;
    }

    public Order() {
    }

    public Order(String name, String cid, String phone, Integer roomId,String typeName, String roomNumber,
                 double price, Integer rcNum, Date inDate, Date outDate, Integer orderStatus, Double orderCost) {
        this.name = name;
        this.cid = cid;
        this.phone = phone;
        this.roomId = roomId;
        this.typeName = typeName;
        this.roomNumber = roomNumber;
        this.price = price;
        this.rcNum = rcNum;
        this.inDate = inDate;
        this.outDate = outDate;
        this.orderStatus = orderStatus;
        this.orderCost = orderCost;
    }

    public Order(Integer orderId, Integer orderStatus) {
        this.orderId = orderId;
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", name='" + name + '\'' +
                ", cid='" + cid + '\'' +
                ", phone='" + phone + '\'' +
                ", roomId=" + roomId +
                ", typeName='" + typeName + '\'' +
                ", roomNumber='" + roomNumber + '\'' +
                ", price=" + price +
                ", rcNum=" + rcNum +
                ", inDate=" + inDate +
                ", outDate=" + outDate +
                ", orderStatus=" + orderStatus +
                ", orderCost=" + orderCost +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
