package com.yssen.hotel.controller.common;

import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/hotel")
public class HotelController {
    @Autowired
    private HotelService hotelService;

    @RequestMapping(value = "")
    public AjaxResult getAllHotel(){
        return ResponseTool.success(hotelService.selectAll());
    }
}
