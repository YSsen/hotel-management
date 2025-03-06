package com.yssen.hotel.mapper;

import com.yssen.hotel.entity.Worker;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface WorkerMapper {
    Integer getCount();
    int deleteByPrimaryKey(Integer workerId);

    int insert(Worker record);

    int insertSelective(Worker record);

    Worker selectByPrimaryKey(Integer workerId);

    int updateByPrimaryKeySelective(Worker record);

    int updateByPrimaryKey(Worker record);

    Worker selectByUsernameAndPassword(@Param("username") String username, @Param("password") String password, @Param("role") String role);

    List<Worker> selectList(int page, int limit);

    Worker selectByUsernamePassword(@Param("username") String username, @Param("password") String password);

    List<Worker> selectByRole(String role);

    Worker selectByUsername(String username);

    List<Worker> selectAll();
}
