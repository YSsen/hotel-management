package com.yssen.hotel.controller.worker;

import com.yssen.hotel.entity.RoomType;
import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/op/room-type")
public class OpRoomTypeController {

    @Autowired
    private RoomTypeService roomTypeService;


    /**
     * 所有房型
     * @return
     */
    @RequestMapping(value = "all")
    public AjaxResult getAllRoomType(){
        List<RoomType> rooms = roomTypeService.findAllType();
        return ResponseTool.success(rooms);
    }

    /**
     * 查找有余量的房型
     * @return
     */
    @RequestMapping(value = "/rest")
    public AjaxResult findAllRestRoomType(){
        return ResponseTool.success(roomTypeService.findAllRestType());
    }

    /**
     * 根据id查找房型
     * @param typeId
     * @return
     */
    @RequestMapping(value = "/{typeId}")
    public AjaxResult getById(@PathVariable int typeId){
        return ResponseTool.success(roomTypeService.selectById(typeId));
    }


    /**
     * 添加房型
     * @param typeName
     * @param price
     * @param area
     * @return
     */
    @PostMapping("/add")
    public AjaxResult addRoomType(@RequestBody RoomType rt){
        int result = roomTypeService.insert(rt);
        if(result!=1) return ResponseTool.failed("添加失败");
        return ResponseTool.success("添加成功");
    }

    /**
     * 修改房型
     * @param typeId
     * @param roomType
     * @param price
     * @param discount
     * @param area
     * @param bedNum
     * @param bedSize
     * @param window
     * @param rest
     * @param remark
     * @return
     */
    @PostMapping("/update")
    public AjaxResult updateRoomType(@RequestBody RoomType rt){
        int result = roomTypeService.update(rt);
        if(result!=1) return ResponseTool.failed("修改失败");
        return ResponseTool.success("修改成功");
    }

    /**
     * 删除房型
     * @param typeId
     * @return
     */
    @RequestMapping("/delete/{typeId}")
    public AjaxResult deleteRoomType(@PathVariable Integer typeId){
        int result = roomTypeService.delete(typeId);
        if(result!=1) return ResponseTool.failed("删除失败");
        return ResponseTool.success("删除成功");
    }

}
