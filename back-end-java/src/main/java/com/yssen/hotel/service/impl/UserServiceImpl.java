package com.yssen.hotel.service.impl;

import com.yssen.hotel.entity.User;
import com.yssen.hotel.mapper.UserMapper;
import com.yssen.hotel.service.UserService;
import com.yssen.hotel.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectById(int userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public int addUser(User user) {
        user.setPassword(MD5Utils.MD5Encode(user.getPassword()));
        return userMapper.insertSelective(user);
    }

    @Override
    public int insertUser(User user) {
        user.setPassword(MD5Utils.MD5Encode(user.getPassword()));
        return userMapper.insert(user);
    }

    @Override
    public int deleteUser(int userId) {
        return userMapper.deleteByPrimaryKey(userId);
    }

    @Override
    public int updateUser(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public Integer getUserCount() {
        return userMapper.getUserCount();
    }

    @Override
    public User selectByUsernameAndPassword(String username, String password) {
        String pass = MD5Utils.MD5Encode(password);
        return userMapper.selectByUsernameAndPassword(username,pass);
    }

    @Override
    public User selectByUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    @Override
    public List<User> selectAll() {
        return userMapper.selectAll();
    }

    @Override
    public List<User> selectAllUser() {
        return userMapper.selectAllUser();
    }
}
