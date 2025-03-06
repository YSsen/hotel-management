package com.yssen.hotel.entity;

import java.util.Date;

public class Room {
    private Integer roomId;

    private String roomNumber;

    private Integer typeId;

    private Integer roomStatus;

    private String floor;

    private String phone;

    private Integer rcNum;

    private Date inDate;

    private Date outDate;

    private Date createTime;

    private Date updateTime;



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
        this.roomNumber = roomNumber == null ? null : roomNumber.trim();
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(Integer roomStatus) {
        this.roomStatus = roomStatus;
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

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public Room() {
    }

    public Room(String roomNumber, Integer typeId, Integer roomStatus, String floor) {
        this.roomNumber = roomNumber;
        this.typeId = typeId;
        this.roomStatus = roomStatus;
        this.floor = floor;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomId=" + roomId +
                ", roomNumber='" + roomNumber + '\'' +
                ", typeId=" + typeId +
                ", roomStatus=" + roomStatus +
                ", remark='" + floor + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }


//    其他实体

    private String typeName;

    private Integer typeNum;

    private Double price;

    private Double deposit;

    private String typeBed;

    private String area;

    private Integer tcNum;

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getTypeNum() {
        return typeNum;
    }

    public void setTypeNum(Integer typeNum) {
        this.typeNum = typeNum;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getDeposit() {
        return deposit;
    }

    public void setDeposit(Double deposit) {
        this.deposit = deposit;
    }

    public String getTypeBed() {
        return typeBed;
    }

    public void setTypeBed(String typeBed) {
        this.typeBed = typeBed;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Integer getTcNum() {
        return tcNum;
    }

    public void setTcNum(Integer tcNum) {
        this.tcNum = tcNum;
    }
}