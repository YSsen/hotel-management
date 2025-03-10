package com.yssen.hotel.controller.common;

import com.yssen.hotel.entity.User;
import com.yssen.hotel.entity.Worker;
import com.yssen.hotel.enums.Role;
import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.UserService;
import com.yssen.hotel.service.WorkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/register")
public class RegisterController {

    @Autowired
    UserService userService;
    @Autowired
    WorkerService workerService;

    @RequestMapping(method = RequestMethod.POST,value = "/user")
    public AjaxResult userRegister(String username,String password,String name,String gender,String phone,String email,String address,String idcard){
        User user = new User(username,password,name,gender,phone,email,address,idcard);
        int result = userService.insertUser(user);
        if(result==1){
            return ResponseTool.success(result);
        }
        else return ResponseTool.failed("注册失败,请稍后再试");
    }

    @RequestMapping(method = RequestMethod.POST,value = "/admin")
    public AjaxResult adminRegister(String username, String password, String name, String phone){
        Worker worker = new Worker(username,password,name,phone);
        worker.setRole(Role.ADMIN.getValue());
        int result = workerService.insert(worker);
        if(result==1){
            return ResponseTool.success(result);
        }
        else return ResponseTool.failed("注册失败,请稍后再试");
    }

    @RequestMapping(method = RequestMethod.POST,value = "/operator")
    public AjaxResult operatorRegister(String username,String password,String name,String phone){
        Worker worker = new Worker(username,password,name,phone);
        worker.setRole(Role.OPERATOR.getValue());
        int result = workerService.insert(worker);
        if(result==1){
            return ResponseTool.success(result);
        }
        else return ResponseTool.failed("注册失败,请稍后再试");
    }

}
