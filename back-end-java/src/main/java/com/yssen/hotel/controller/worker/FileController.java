package com.yssen.hotel.controller.worker;


import com.yssen.hotel.response.AjaxResult;
import com.yssen.hotel.response.ResponseTool;
import com.yssen.hotel.utils.UploadUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

@RestController
@RequestMapping(value = "/upload")
public class FileController {

    @PostMapping(value = "/file", consumes = "multipart/form-data")
    public AjaxResult upload(@RequestParam("file") MultipartFile imgFile){

        // 生成唯一文件名
        String uuid = UUID.randomUUID().toString().trim();
        String filename = imgFile.getOriginalFilename();
        int index=filename.indexOf(".");
        String fileNames= uuid + filename;

        // 调用UploadUtils工具类将图片存放到服务器上
        File fileDir = UploadUtils.getImgDirFile();

        try {
            // 构建真实的文件路径
            File newFile = new File(fileDir.getAbsolutePath() + File.separator + fileNames);
            System.out.println(newFile.getAbsolutePath());
            imgFile.transferTo(newFile);
            //返回图片名称
            return ResponseTool.success(fileNames);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 获取文件流
     * @param fileName
     * @return
     */
    @RequestMapping("/echo/{fileName}")
    public void getFile(@PathVariable String fileName, HttpServletResponse response, HttpServletRequest request){
        try {
            // 调用UploadUtils工具类将图片存放到服务器上
            File fileDir = UploadUtils.getImgDirFile();
            // 构建真实的文件路径
            File file = new File(fileDir.getAbsolutePath() + File.separator + fileName);
            FileInputStream fis = new FileInputStream(file);
            response.setContentType("image/jpg");

            OutputStream os = response.getOutputStream();
            int len = 0;
            byte[] bytedata = new byte[2048];
            while ((len = fis.read(bytedata)) != -1) {
                os.write(bytedata, 0, len);
            }
            fis.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
