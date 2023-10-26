package com.certificate.pass.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.Employee;
import com.certificate.pass.vo.Visitor;

@Repository
public class EmployeeDao {
	@Autowired SqlSessionTemplate sqlSession;


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

	public String getUsersRole(String usersId) {
		return sqlSession.selectOne("employee.getUsersRole", usersId);
	}

	public int updateEmployee(Employee employee) {
		return sqlSession.update("employee.updateEmployee", employee);
	}

	public int updateUsers(Employee employee) {
		return sqlSession.update("employee.updateUsers", employee);
	}

	public int deleteEmployee(String employeeId) {
		return sqlSession.delete("employee.deleteEmployee", employeeId);
	}

	public int deleteUsers(String usersId) {
		return sqlSession.delete("employee.deleteUsers", usersId);
	}

	public Employee getEmployeeOne(String employeeId) {
		return sqlSession.selectOne("employee.getEmployeeOne", employeeId);
	}

	public int loginUnLimit(String employeeId, String employeeModifier, String employeeModifiedDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("employeeId", employeeId);
		parameters.put("employeeModifier", employeeModifier);
		parameters.put("employeeModifiedDate", employeeModifiedDate);
		return sqlSession.update("employee.loginUnLimit", parameters);
	}

	public Visitor getVisitor(Visitor visitor) {
		return sqlSession.selectOne("employee.getVisitor", visitor);
	}

	public void insertVisitor(Visitor visitor) {
		sqlSession.insert("employee.insertVisitor", visitor);
	}

	public int myPageEmployeeUpdate(Employee employee) {
		return sqlSession.update("employee.myPageEmployeeUpdate", employee);
	}
	
}
