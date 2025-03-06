package com.yssen.hotel.controller.worker;

import com.yssen.hotel.entity.PageInfo;
import com.yssen.hotel.entity.Room;
import com.yssen.hotel.entity.RoomType;
import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.RoomService;
import com.yssen.hotel.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/op/room")
public class OpRoomController {

    @Autowired
    private RoomService roomService;
    @Autowired
    private RoomTypeService roomTypeService;

    @PostMapping("/add")
    public AjaxResult addRoom(@RequestBody Room room){
        if(roomService.selectByNumber(room.getRoomNumber())!=null) return ResponseTool.failed("房间号码重复");
        RoomType rt = new RoomType();
        Integer typeId = room.getTypeId();
        if (roomTypeService.selectById(typeId).getTypeNum() <= roomService.selectByType(typeId).size()) {
            return ResponseTool.failed("当前类型的房间已满，不能添加");
        } else if (roomService.insert(room) != 1){
            return ResponseTool.failed("添加失败");
        }
        return ResponseTool.success("添加成功");
    }

    @RequestMapping("/delete/{roomId}")
    public AjaxResult deleteRoom(@PathVariable Integer roomId){
        if(roomService.delete(roomId)!=1) return ResponseTool.failed("删除失败");
        return ResponseTool.success("删除成功");
    }

    @PostMapping("/update")
    public AjaxResult updateRoom(@RequestBody Room room){
        if(roomService.update(room)!=1) return ResponseTool.failed("更新失败");
        return ResponseTool.success("更新成功");
    }

    @RequestMapping(value = "/{id}")
    public AjaxResult getById(@PathVariable Integer id){
        return ResponseTool.success(roomService.selectById(id));
    }

    @RequestMapping(value = "/type/{typeId}")
    public AjaxResult getByType(@PathVariable Integer typeId){
        return ResponseTool.success(roomService.selectByType(typeId));
    }

    @RequestMapping(value = "/status/{statusId}")
    public AjaxResult getByStatus(@PathVariable Integer statusId){
        return ResponseTool.success(roomService.selectByStatus(statusId));
    }

    @RequestMapping(value = "all")
    public AjaxResult getAll(){
        return ResponseTool.success(roomService.selectAll());
    }

    @PostMapping("/list")
    public AjaxResult getAll(String roomStatus, String typeId, Integer page, Integer limit){
//        Integer status=null, id=null;
//        if (StringUtils.isNotEmpty(roomStatus)) status = new Integer(roomStatus);
//        if (StringUtils.isNotEmpty(typeId)) id = new Integer(typeId);
        List<Room> list = roomService.selectList(roomStatus, typeId, page*limit, limit);
//        Integer total = list.size();
        Integer total = roomService.getCount(roomStatus, typeId, null);
//        Integer fromIndex = page*limit;
//        Integer toIndex = (page+1)*limit;
//        if (fromIndex >= total) {
//            return ResponseTool.success(new PageInfo(total, null));
//        }
//        if (toIndex > total) {
//            toIndex = total;
//        }
//        list = list.subList(fromIndex, toIndex);
        return ResponseTool.success(new PageInfo(total, list));
    }


    @PostMapping("/list2")
    public AjaxResult getList(String roomStatus, String typeId, String phone, Integer page, Integer limit){
//        Integer status=null, id=null;
//        if (StringUtils.isNotEmpty(roomStatus)) status = new Integer(roomStatus);
//        if (StringUtils.isNotEmpty(typeId)) id = new Integer(typeId);
        List<Room> list = roomService.selectList2(roomStatus, typeId, phone, page*limit, limit);
//        Integer total = list.size();
        Integer total = roomService.getCount(roomStatus, typeId, phone);
//        Integer fromIndex = page*limit;
//        Integer toIndex = (page+1)*limit;
//        if (fromIndex >= total) {
//            return ResponseTool.success(new PageInfo(total, null));
//        }
//        if (toIndex > total) {
//            toIndex = total;
//        }
//        list = list.subList(fromIndex, toIndex);
        return ResponseTool.success(new PageInfo(total, list));
    }

}
