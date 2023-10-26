package com.certificate.pass.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.certificate.pass.dao.EmployeeDao;
import com.certificate.pass.dao.MyPageDao;
import com.certificate.pass.vo.Employee;

@Service
public class MyPageService {
	@Autowired MyPageDao myPageDao;
	@Autowired EmployeeDao employeeDao;

	public String employeeUpdate(Employee employee, MultipartFile employeeImgFile, String employeeId) {
		if (employeeImgFile != null) {
            String fileName = employeeImgFile.getOriginalFilename();
            String fileExtension = "";

            int lastIndex = fileName.lastIndexOf(".");
            if (lastIndex > 0) {
                fileExtension = fileName.substring(lastIndex + 1);
            }
            
            if(!fileExtension.equals("jpg") && !fileExtension.equals("png")) {
            	return "NotExtension";
            }
            
            String osName = System.getProperty("os.name");
    		String uploadDir = "";
    		if (osName.toLowerCase().contains("windows")) {
    			uploadDir = "C:\\ITDeveloper\\profile\\";
            } else if (osName.toLowerCase().contains("linux")) {
            	uploadDir = "/sw/profile/";
            } 
    		fileName = employeeId+"_"+employeeImgFile.getOriginalFilename();
            String filePath = uploadDir + fileName;
    		try {
    			FileCopyUtils.copy(employeeImgFile.getBytes(), new File(filePath));
    		} catch (IOException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    		employee.setEmployeeImg(employeeImgFile.getOriginalFilename());
        } 
		
		
		employee.setEmployeeId(employeeId);
		int sucess = employeeDao.myPageEmployeeUpdate(employee);
		if (sucess <= 0)
			return "FALSE";
		
		return "OK";
	}
}
