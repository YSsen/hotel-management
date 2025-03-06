package com.yssen.hotel.entity;

public class PageInfo {
    private Integer total;

    private Object content;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Object getContent() {
        return content;
    }

    public void setContent(Object content) {
        this.content = content;
    }

    public PageInfo() {
    }

    public PageInfo(Integer total, Object content) {
        this.total = total;
        this.content = content;
    }
}

