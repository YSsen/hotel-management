package com.yssen.hotel.service;


import com.yssen.hotel.entity.User;

import java.util.List;

public interface UserService {

    User selectById(int userId);

    int addUser(User user);

    int insertUser(User user);

    int deleteUser(int userId);

    int updateUser(User user);

    Integer getUserCount();

    User selectByUsernameAndPassword(String username, String password);

    User selectByUsername(String username);

    List<User> selectAll();

    List<User> selectAllUser();

}
