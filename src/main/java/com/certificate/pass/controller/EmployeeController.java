package com.certificate.pass.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.service.EmailService;
import com.certificate.pass.service.EmployeeService;
import com.certificate.pass.vo.Employee;

@Controller
public class EmployeeController {
	@Autowired EmployeeService employeeService;
	@Autowired EmailService emailService;
	
	@ResponseBody
	@PostMapping(value = "/signUp")
	public Map<String,String> signUp(EmployeeEntity employeeEntity, Principal principal) {
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		employeeEntity.setEmployeeRegistrationDate(formatter.format(now));

		Map<String,String> map = new HashMap<String,String>();
		String result = employeeService.signUp(employeeEntity);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/findId")
	public String findId(String employeeEmail) {
		return employeeService.getFindId(employeeEmail);
	}
	
	@ResponseBody
	@PostMapping(value = "/findPwd")
	public String findPwd(String employeeId, String employeeEmail) {
		return employeeService.getFindPwd(employeeId, employeeEmail);
	}
	
	@GetMapping("/loginCheck")
	public String loginCheckView(String employeeId, Model model) {
		model.addAttribute("usersId",employeeId);
		return "/Login";
	}
	
	@ResponseBody
	@PostMapping(value = "/changePwd")
	public String changePwd(String usersPw, String employeeId, String employeeEmail) {
		return employeeService.setChangePwd(usersPw, employeeId, employeeEmail);
	}
	
	@ResponseBody
	@PostMapping("/emailConfirm")
	public String emailConfirm(@RequestParam String employeeEmail) throws Exception {
	  String confirm = emailService.sendSimpleMessage(employeeEmail);
	  return confirm;
	}
	
	@GetMapping("/employeeList")
	public String employeeList() {
		return "/employee/EmployeeList";
	}
	
	@ResponseBody
	@PostMapping(value = "/employee")
	public Map<String, Object> Employee(@ModelAttribute("search") EmployeeEntity search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<EmployeeEntity> list = new ArrayList<>(employeeService.getEmployeeList(search));
		Long totalCount = employeeService.getEmployeeListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/employee/loginLimit")
	public Map<String, String> loginLimit(@RequestParam String[] chkList, Principal principal) {
		Map<String, String> map = new HashMap<String, String>();
		String result = employeeService.loginLimit(chkList, principal);
		map.put("result", result);
		return map;
	}
	
	@PostMapping("/employeeView")
	public String employeeView(Model model, String employeeId) {
		EmployeeEntity employeeEntity = employeeService.getEmployeeOne(employeeId);
		String role = employeeService.getUsersRole(employeeId);
		model.addAttribute("employee", employeeEntity);
		model.addAttribute("role", role);
		return "/employee/EmployeeView";
	}
	
	@ResponseBody
	@PostMapping(value = "/employee/update")
	public String UpdateEmployee(Employee employee, Principal principal) {
		employee.setEmployeeModifier(principal.getName());
		employee.setEmployeeModifiedDate(employeeService.nowDate());

		return employeeService.updateEmployee(employee, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/employee/delete")
	public Map<String, String> deleteEmployee(@RequestParam String[] chkList) {
		Map<String, String> map = new HashMap<String, String>();
		String result = employeeService.deleteEmployee(chkList);
		map.put("result", result);
		return map;
	}
	
}
