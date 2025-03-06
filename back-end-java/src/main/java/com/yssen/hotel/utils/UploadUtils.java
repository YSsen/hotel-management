package com.yssen.hotel.utils;

import java.io.File;

public class UploadUtils {
    //静态资源路径
    public final static String IMG_PATH_PREFIX = "D:\\image";

    public static File getImgDirFile() {
        //dome是项目名
        String fileDirPath = new String(IMG_PATH_PREFIX);

        File fileDir = new File(fileDirPath);
        if (!fileDir.exists()) {

            fileDir.mkdirs();
        }
        return fileDir;
    }
}
