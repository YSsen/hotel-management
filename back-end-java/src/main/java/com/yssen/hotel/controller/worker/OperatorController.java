package com.yssen.hotel.controller.worker;

import com.yssen.hotel.entity.PageInfo;
import com.yssen.hotel.entity.Worker;
import com.yssen.hotel.enums.Role;
import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.WorkerService;
import com.yssen.hotel.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/admin/operator")
public class OperatorController {
    @Autowired
    private WorkerService workerService;


    @RequestMapping("/delete/{workerId}")
    public AjaxResult deleteOperator(@PathVariable Integer workerId){
        int re = workerService.delete(workerId);
        if(re!=1) ResponseTool.failed();
        return ResponseTool.success("删除成功");
    }

    @RequestMapping(value = "")
    public AjaxResult getAllOperator(){
        return ResponseTool.success(workerService.selectByRole(Role.OPERATOR.getValue()));
    }

    @RequestMapping(method = RequestMethod.POST,value = "/{workerId}")
    public AjaxResult getOperator(@PathVariable Integer workerId){
        return ResponseTool.success(workerService.selectById(workerId));
    }

    @PostMapping("/add")
    public AjaxResult addOperator(@RequestBody Worker worker){
        int re = workerService.insert(worker);
        if(re!=1) return ResponseTool.failed();
        return ResponseTool.success("添加成功");
    }


    @PostMapping("/update")
    public AjaxResult updateOperator(@RequestBody Worker worker){
        int re =  workerService.updateById(worker);
        if(re!=1) return ResponseTool.failed();
        return ResponseTool.success("更新成功");
    }

    @RequestMapping(method = RequestMethod.POST,value = "/updatePassword")
    public AjaxResult updatePassword(Integer workerId, String newPassword){
        Worker worker = workerService.selectById(workerId);
        worker.setPassword(MD5Utils.MD5Encode(newPassword));
        if(workerService.updateById(worker)==1)
            return ResponseTool.success("修改成功");
        return ResponseTool.failed("修改失败");
    }

    @PostMapping("/list")
    public AjaxResult getAll(Integer page, Integer limit){
        List<Worker> list = workerService.selectList(page*limit, limit);
        Integer total = workerService.getCount();
        return ResponseTool.success(new PageInfo(total, list));
    }

}
