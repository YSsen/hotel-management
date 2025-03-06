package com.yssen.hotel.entity;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Worker {
    private Integer workerId;

    private String role;

    private String username;

    private String password;

    private String name;

    private String phone;

    private Integer department;

    private Date createTime;

    private Date updateTime;

    public Integer getWorkerId() {
        return workerId;
    }

    public void setWorkerId(Integer workerId) {
        this.workerId = workerId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role == null ? null : role.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
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

    public Integer getDepartment() {
        return department;
    }

    public void setDepartment(Integer department) {
        this.department = department;
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

    public Worker() {
    }

    public Worker(Integer workerId, String username, String password, String role, String name, String phone) {
        this.workerId = workerId;
        this.username = username;
        this.password = password;
        this.role = role;
        this.name = name;
        this.phone = phone;
    }
    public Worker(String username, String password, String role, String name, String phone) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.name = name;
        this.phone = phone;
    }

    public Worker(String username, String password, String name, String phone) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Worker{" +
                "workerId=" + workerId +
                ", role='" + role + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", department=" + department +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
