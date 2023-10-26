package com.certificate.pass.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.service.EmployeeService;
import com.certificate.pass.service.MyPageService;
import com.certificate.pass.vo.Employee;

@Controller
public class MyPageController {
	@Autowired MyPageService myPageService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping("/myPage")
	public String MyPage() {
		return "/myPage/MyPage";
	}
	
	@GetMapping("/myPage/employeeUpdateView")
	public String EmployeeUpdateView(Principal principal, Model model) {
		EmployeeEntity employee = employeeService.getEmployeeOne(principal.getName());
		model.addAttribute("employee", employee);
		return "/myPage/EmployeeUpdateView";
	}
	
	@ResponseBody
	@PostMapping(value = "/myPage/employeeUpdate")
	public String EmployeeUpdate(Employee employee, MultipartFile employeeImgFile, Principal principal) {
		return myPageService.employeeUpdate(employee,employeeImgFile,principal.getName());
	}
}
