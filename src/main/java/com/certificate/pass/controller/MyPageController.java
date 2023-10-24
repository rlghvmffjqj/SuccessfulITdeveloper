package com.certificate.pass.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.service.EmployeeService;
import com.certificate.pass.service.MyPageService;

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
}
