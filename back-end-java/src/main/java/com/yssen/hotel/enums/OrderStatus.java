package com.yssen.hotel.enums;

public enum OrderStatus {
    WAS_DELETED(-3,"已删除"),
    OVERTIME(-2,"支付超时"),
    WAS_CANCELED(-1,"已取消"),
    UNPAID(0,"未付款"),
    PAID(1,"待入住"),

//    订单状态用于确定 退房日期和消费金额的更新（仅入住单需要更新）
//    预定单->入住单->换房单->退房单
//    预定单->取消单
//    入住单->换房单->退房单
//    入住单->退房单
    CHECK_IN(2,"入住单"), //只有一个，“信息查询”功能查这个
    RESERVE(3, "预定单"), //只有一个，“信息查询”功能查这个
    CHANGE(4, "换房单"), //只有一个， “信息查询”功能查这个
    CANCELED(5, "取消单"), //可以多个
    CHECK_OUT(6, "退房单"), //可以多个
    ;

    private int code;
    private String status;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    OrderStatus(int code, String status) {
        this.code = code;
        this.status = status;
    }
}
