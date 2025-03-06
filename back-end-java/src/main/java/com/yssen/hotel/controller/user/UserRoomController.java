package com.yssen.hotel.controller.user;

import com.yssen.hotel.entity.RoomType;
import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(value = "/hotel/room")
public class UserRoomController {

    @Autowired
    private RoomTypeService roomTypeService;

    /**
     * 所有房型
     * @return
     */
    @RequestMapping(value = "")
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


}
