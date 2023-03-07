package com.certificate.pass.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.EmployeeDao;
import com.certificate.pass.vo.Employee;
import com.certificate.pass.vo.Users;

@Service
public class EmployeeService {
	@Autowired EmployeeDao employeeDao;
	@Autowired UsersService usersService;
	@Autowired Users users;

	public String signUp(Employee employee) {
		if(employeeDao.getEmployeeOne(employee.getEmployeeId()) != null) {	// 아이디 중복 확인
			return "idDuplicateCheck";
		}
		if(employeeDao.getEmployeeEmailOne(employee.getEmployeeEmail()) != null) {	// 아이디 중복 확인
			return "emailDuplicateCheck";
		}
		employee.setEmployeeRegistrant(employee.getEmployeeId());
		employee.setEmployeeStatus("정상");
		int sucess = employeeDao.insertEmployee(employee);
		users.setUsersId(employee.getEmployeeId());
		users.setUsersPw(employee.getUsersPw());
		users.setUsersState("WEB");
		users.setUsersRole("MEMBER");
		
		if(sucess <= 0) 
			return "FALSE";
		return usersService.save(users);
	}

	public String getFindId(String employeeEmail) {
		String employeeId = employeeDao.getEmployeeEmailOne(employeeEmail).getEmployeeId();
		if(employeeId == "") {
			return "noId";
		}
		return employeeId;
	}

	public String getFindPwd(String employeeId, String employeeEmail) {
		Employee employee = employeeDao.getEmployeeMatch(employeeId, employeeEmail);
		if(employee == null) {
			return "noMatch";
		}
		return "OK";
	}

	public String setChangePwd(String usersPw, String employeeId, String employeeEmail) {
		Employee employee = employeeDao.getEmployeeMatch(employeeId, employeeEmail);
		if(employee == null) {
			return "FALSE";
		}
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		usersPw = passwordEncoder.encode(usersPw);
		int sucess = employeeDao.setChangePwd(employeeId, usersPw);
		if(sucess > 0) {
			return "OK"; 
		}
		return "FALSE";
	}

	public int getEmployeeListCount(Employee search) {
		return employeeDao.getEmployeeListCount(search);
	}
	
	public List<Employee> getEmployeeList(Employee search) {
		List<Employee> list = new ArrayList<Employee>();
		list = employeeDao.getEmployeeList(search);
		for (Employee employee : list) {
			if(employee.getUsersRole().equals("ADMIN")) {
				employee.setUsersRole("관리자");
			} else if(employee.getUsersRole().equals("ENGINEER")) {
				employee.setUsersRole("엔지니어");
			} else if(employee.getUsersRole().equals("QA")) {
				employee.setUsersRole("QA");
			} else {
				employee.setUsersRole("일반 사용자");
			}
		}
		return list;
	}

	public String loginLimit(String[] chkList, Principal principal) {
		for (String employeeId : chkList) {
			int sucess = employeeDao.loginLimit(employeeId, principal.getName(), nowDate());
			if (sucess <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String getUsersRole(String usersId) {
		return employeeDao.getUsersRole(usersId);
	}

	public Employee getEmployeeOne(String employeeId) {
		return employeeDao.getEmployeeOne(employeeId);
	}

	public String updateEmployee(Employee employee, Principal principal) {
		int sucess = employeeDao.updateEmployee(employee);
		sucess *= employeeDao.updateUsers(employee);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String deleteEmployee(String[] chkList) {
		for (String employeeId : chkList) {
			int sucess = employeeDao.deleteEmployee(employeeId);
			sucess *= employeeDao.deleteUsers(employeeId);
			if (sucess <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}
	
}
