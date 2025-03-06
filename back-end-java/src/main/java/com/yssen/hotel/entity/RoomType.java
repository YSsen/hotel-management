package com.yssen.hotel.entity;

import java.util.Date;

public class RoomType {
    private Integer typeId;

    private String typeName;

    private Integer typeNum;

    private Double price;

    private Double deposit;

    private String typeBed;

    private String area;

    private Integer tcNum;

    private String floor;

    private String picture;

    private Date createTime;

    private Date updateTime;

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

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

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
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

    public RoomType() {
    }

    public RoomType(String typeName, Integer typeNum, Double price, Double deposit, String typeBed,
                    String area, Integer tcNum, String floor, String picture) {
        this.typeName = typeName;
        this.typeNum = typeNum;
        this.price = price;
        this.deposit = deposit;
        this.typeBed = typeBed;
        this.area = area;
        this.tcNum = tcNum;
        this.floor = floor;
        this.picture = picture;
    }

    public RoomType(Integer typeId, String typeName, Integer typeNum, Double price, Double deposit,
                    String typeBed, String area, Integer tcNum, String floor, String picture, Date createTime, Date updateTime) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.typeNum = typeNum;
        this.price = price;
        this.deposit = deposit;
        this.typeBed = typeBed;
        this.area = area;
        this.tcNum = tcNum;
        this.floor = floor;
        this.picture = picture;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "RoomType{" +
                "typeId=" + typeId +
                ", typeName='" + typeName + '\'' +
                ", typeNum=" + typeNum +
                ", price=" + price +
                ", deposit=" + deposit +
                ", typeBed='" + typeBed + '\'' +
                ", area='" + area + '\'' +
                ", tcNum=" + tcNum +
                ", floor='" + floor + '\'' +
                ", picture='" + picture + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
