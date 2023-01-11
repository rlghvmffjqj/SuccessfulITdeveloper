package com.certificate.pass.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.Employee;

@Repository
public class EmployeeDao {
	@Autowired SqlSessionTemplate sqlSession;

	public String getUsersPw(String usersId) {
		return sqlSession.selectOne("employee.getUsersPw", usersId);
	}

	public void lastLogin(String lastLogin, String usersId) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("lastLogin", lastLogin);
		parameters.put("usersId", usersId);
		sqlSession.update("employee.lastLogin", parameters);
	}

	public int insertEmployee(Employee employee) {
		return sqlSession.insert("employee.insertEmployee", employee);
	}

	public Employee getEmployeeOne(String employeeId) {
		return sqlSession.selectOne("employee.getEmployeeOne", employeeId);
	}

	public Employee getEmployeeEmailOne(String employeeEmail) {
		return sqlSession.selectOne("employee.getEmployeeEmailOne", employeeEmail);
	}

	public Employee getEmployeeMatch(String employeeId, String employeeEmail) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("employeeId", employeeId);
		parameters.put("employeeEmail", employeeEmail);
		return sqlSession.selectOne("employee.getEmployeeMatch", parameters);
	}

	public int setChangePwd(String employeeId, String usersPw) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("usersId", employeeId);
		parameters.put("usersPw", usersPw);
		return sqlSession.update("employee.updateUsersPw", parameters);
	}

	public String getState(String usersId) {
		return sqlSession.selectOne("employee.getState", usersId);
	}

	public int getEmployeeListCount(Employee search) {
		return sqlSession.selectOne("employee.getEmployeeCount", search);
	}
	
	public List<Employee> getEmployeeList(Employee search) {
		return sqlSession.selectList("employee.getEmployee", search);
	}

	public int loginLimit(String employeeId, String employeeModifier, String employeeModifiedDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("employeeId", employeeId);
		parameters.put("employeeModifier", employeeModifier);
		parameters.put("employeeModifiedDate", employeeModifiedDate);
		return sqlSession.update("employee.loginLimit", parameters);
	}

}
