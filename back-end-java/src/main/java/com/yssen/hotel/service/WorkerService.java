package com.yssen.hotel.service;

import com.yssen.hotel.entity.Worker;

import java.util.List;

public interface WorkerService {
    int insert(Worker worker);
    int delete(int workerId);
    int updateById(Worker worker);
    Worker selectById(int workerId);
    Worker selectByUsername(String username);
    List<Worker> findAll();
    List<Worker> selectByRole(String role);
    Worker login(String username,String password,String role);
    Worker login(String username,String password);

    int getCount();
    List<Worker> selectList(int page, int limit);

}
