package com.xixi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartResolver;

import java.io.File;

/**
 * Created by xijiaxiang on 2017/6/3.
 */
@Controller
public class FileUploadController {

    @RequestMapping(value="upload")
    public String toUpload(){
        return "upload";
    }

    @ResponseBody
    @RequestMapping(value = "/uploadfile", method = RequestMethod.POST)
    public String upload(MultipartFile file) {
        try {
            org.apache.commons.io.FileUtils.writeByteArrayToFile(new File("e:/"+file.getOriginalFilename()),file.getBytes());
            return "ok";
        } catch (Exception e) {
            return "wrong";
        }
    }
}
