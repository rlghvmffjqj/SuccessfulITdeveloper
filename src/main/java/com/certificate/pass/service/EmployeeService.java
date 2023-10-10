package com.certificate.pass.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.EmployeeDao;
import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.emtity.UsersEntity;
import com.certificate.pass.jpaDao.EmployeeJpaDao;
import com.certificate.pass.jpaDao.UsersJpaDao;
import com.certificate.pass.jpqlDao.EmployeeJPQL;
import com.certificate.pass.vo.Employee;

@Service
public class EmployeeService {
	@Autowired EmployeeDao employeeDao;
	@Autowired EmployeeJpaDao employeeJpaDao;
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired UsersService usersService;
	@Autowired UsersEntity usersEntity;
	@Autowired EmployeeJPQL employeeJPQL;
	
	@PersistenceContext
	private EntityManager entityManager;

	public String signUp(EmployeeEntity employeeEntity) {
		if(employeeJpaDao.findByEmployeeId(employeeEntity.getEmployeeId()) != null) {	// �븘�씠�뵒 以묐났 �솗�씤
			return "idDuplicateCheck";
		}
		if(employeeJpaDao.findByEmployeeEmail(employeeEntity.getEmployeeEmail()) != null) {	// �븘�씠�뵒 以묐났 �솗�씤
			return "emailDuplicateCheck";
		}
		employeeEntity.setEmployeeRegistrant(employeeEntity.getEmployeeId());
		employeeEntity.setEmployeeStatus("�젙�긽");
		try {
			EmployeeEntity sucess = employeeJpaDao.save(employeeEntity);
			if(sucess == null) return "FALSE";
		} catch (Exception e) {
			return "FALSE";
		}
		usersEntity.setUsersId(employeeEntity.getEmployeeId());
		usersEntity.setUsersPw(employeeEntity.getUsersPw());
		usersEntity.setUsersState("WEB");
		usersEntity.setUsersRole("MEMBER");
			
		return usersService.save(usersEntity);
	}

	public String getFindId(String employeeEmail) {
		String employeeId = employeeJpaDao.findByEmployeeEmail(employeeEmail).getEmployeeId();
		if(employeeId == "") {
			return "noId";
		}
		return employeeId;
	}

	public String getFindPwd(String employeeId, String employeeEmail) {
		EmployeeEntity employeeEntity = employeeJpaDao.findByEmployeeIdAndEmployeeEmail(employeeId, employeeEmail);
		if(employeeEntity == null) {
			return "noMatch";
		}
		return "OK";
	}

	public String setChangePwd(String usersPw, String employeeId, String employeeEmail) {
		EmployeeEntity employeeEntity = employeeJpaDao.findByEmployeeIdAndEmployeeEmail(employeeId, employeeEmail);
		if(employeeEntity == null) {
			return "FALSE";
		}
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		usersPw = passwordEncoder.encode(usersPw);
		UsersEntity userEntity = usersJpaDao.findByUsersId(employeeId);
		userEntity.setUsersPw(usersPw);
		try {
			userEntity = usersJpaDao.save(userEntity);
			if(userEntity == null) return "False";
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK"; 
		
	}

	public Long getEmployeeListCount(EmployeeEntity search) {
		return employeeJPQL.fideEmployeeCount(search);
	}
	
	public List<EmployeeEntity> getEmployeeList(EmployeeEntity search) {
		List<EmployeeEntity> list = employeeJPQL.findEmployeeList(search);
		
		for (EmployeeEntity employee : list) {
			UsersEntity usersEntity = usersJpaDao.findUsersRoleByUsersId(employee.getEmployeeId());
			if(usersEntity.getUsersRole().equals("ADMIN")) {
				employee.setUsersRole("관리자");
			} else if(usersEntity.getUsersRole().equals("ENGINEER")) {
				employee.setUsersRole("엔지니어");
			} else if(usersEntity.getUsersRole().equals("QA")) {
				employee.setUsersRole("QA");
			} else {
				employee.setUsersRole("일반사용자");
			}
		}
		return list;
	}
	
	public String sqlEmployee(EmployeeEntity search) {
		String jpql = "";
		jpql += "<trim prefix=\"WHERE\" suffixOverrides=\"AND\">";
		if(search.getEmployeeId() != null && search.getEmployeeId() != "") {
			jpql += " AND e.employeeId LIKE CONCAT('%', :employeeId,'%')";
		}
		if(search.getEmployeeName() != null && search.getEmployeeName() != "") {
			jpql += " AND e.employeeName LIKE CONCAT('%', :employeeName,'%')";
		}
		if(search.getEmployeeEmail() != null && search.getEmployeeEmail() != "") {
			jpql += " AND e.employeeEmail LIKE CONCAT('%', :employeeEmail,'%')";
		}
		if(search.getEmployeeStatus() != null && search.getEmployeeStatus() != "") {
			jpql += " AND e.employeeStatus LIKE CONCAT('%', :employeeStatus,'%')";
		}
		if(search.getEmployeePhone() != null && search.getEmployeePhone() != "") {
			jpql += " AND e.employeePhone LIKE CONCAT('%', :employeePhone,'%')";
		}
		jpql += "</trim>";
		return jpql;
	}

	public String loginLimit(String[] chkList, Principal principal) {
		int sucess = 0;
		for (String employeeId : chkList) {
			Employee employee = employeeDao.getEmployeeOne(employeeId);
			if(employee.getEmployeeStatus().equals("제한")) {
				sucess = employeeDao.loginUnLimit(employeeId, principal.getName(), nowDate());
			} else {
				sucess = employeeDao.loginLimit(employeeId, principal.getName(), nowDate());
			}
			
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

	public EmployeeEntity getEmployeeOne(String employeeId) {
		return employeeJpaDao.findByEmployeeId(employeeId);
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

