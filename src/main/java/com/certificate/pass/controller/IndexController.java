package com.certificate.pass.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.service.EmployeeService;
import com.certificate.pass.service.IntegratedService;
import com.certificate.pass.vo.MainContents;

@Controller
public class IndexController {
	@Autowired IntegratedService integratedService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping("/index")
	public String indexView(@RequestParam(defaultValue = "1") int page, Model model) {
		int size = 5;
		List<MainContents> list = new ArrayList<>(integratedService.getIndexList(page, size));
		int total = integratedService.getIndexCount();
		int group = (page - 1) / size;
		int startPage = group * size + 1;
		int endPage = (startPage + size - 1 > total) ? total : startPage + size - 1;
		if(endPage>total/size+1) {
			endPage = endPage - (endPage-(total/size+1));
		}
		
		model.addAttribute("mainContentsList", list);
		model.addAttribute("mainContentsCount", total);
		model.addAttribute("page",page);
		model.addAttribute("size",size);
		model.addAttribute("total", total/size);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		return "/Index";
	}
	
	@GetMapping("/images/profile")
	public void profile(HttpServletRequest request, HttpServletResponse response, Principal principal) throws ServletException, IOException {
		try {
			EmployeeEntity employee = employeeService.getEmployeeOne(principal.getName());
			String osName = System.getProperty("os.name");
			String imagePath = "";
			if(employee.getEmployeeImg() != null && employee.getEmployeeImg() != "") {
				String imgName = principal.getName()+"_"+employee.getEmployeeImg();
				// 이미지 파일의 경로를 설정
				if (osName.toLowerCase().contains("windows")) {
					imagePath = "C:\\ITDeveloper\\profile\\"+imgName; // 이미지 파일의 실제 경로
	            } else if (osName.toLowerCase().contains("linux")) {
	            	imagePath = "/sw/profile/"+imgName; // 이미지 파일의 실제 경로
	            } 
			} else {
				// 이미지 파일의 경로를 설정
				if (osName.toLowerCase().contains("windows")) {
					imagePath = "C:\\ITDeveloper\\profile\\profile.png"; // 이미지 파일의 실제 경로
	            } else if (osName.toLowerCase().contains("linux")) {
	            	imagePath = "/sw/profile/profile.png"; // 이미지 파일의 실제 경로
	            } 
			}
			File imageFile = new File(imagePath);
			
	        // 이미지 파일을 읽어서 응답에 출력
	        byte[] imageBytes = Files.readAllBytes(imageFile.toPath());
	        response.setContentType("image/jpeg"); // 이미지 타입에 따라 변경
	        response.setContentLength(imageBytes.length);
	        response.getOutputStream().write(imageBytes);
		} catch (Exception e) {
			
		}
	}
	
}
