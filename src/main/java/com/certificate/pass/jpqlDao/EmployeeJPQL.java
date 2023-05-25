package com.certificate.pass.jpqlDao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import com.certificate.pass.emtity.EmployeeEntity;

@Repository
public class EmployeeJPQL {
	@PersistenceContext
    private EntityManager entityManager;
	
	public List<EmployeeEntity> findEmployeeList(EmployeeEntity search) {
		String jpql = "SELECT e "
	            + "FROM EmployeeEntity e INNER JOIN UsersEntity u "
	            + "ON e.employeeId = u.usersId ";
		jpql += sqlEmployee(search);
	    jpql += "ORDER BY " + search.getSidx() + " " + search.getSord();

		
		TypedQuery<EmployeeEntity> query = entityManager.createQuery(jpql, EmployeeEntity .class);
		
		if(search.getEmployeeId() != null && search.getEmployeeId() != "") {
			query.setParameter("employeeId", search.getEmployeeId());
		}
		if(search.getEmployeeName() != null && search.getEmployeeName() != "") {
			query.setParameter("employeeName", search.getEmployeeName());
		}
		if(search.getEmployeeEmail() != null && search.getEmployeeEmail() != "") {
			query.setParameter("employeeEmail", search.getEmployeeEmail());
		}
		if(search.getEmployeeStatus() != null && search.getEmployeeStatus() != "") {
			query.setParameter("employeeStatus", search.getEmployeeStatus());
		}
		if(search.getEmployeePhone() != null && search.getEmployeePhone() != "") {
			query.setParameter("employeePhone", search.getEmployeePhone());
		}
		
		query.setFirstResult((search.getPage() - 1) * search.getRows()); // OFFSET 설정
		query.setMaxResults(search.getRows()); // LIMIT 설정
		
		List<EmployeeEntity> list = query.getResultList();
		
		return list;
	}
	
	public Long fideEmployeeCount(EmployeeEntity search) {
		String jpql = "SELECT COUNT(*) FROM EmployeeEntity e INNER JOIN UsersEntity u ON e.employeeId = u.usersId";
		jpql += sqlEmployee(search);
		
		TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
		
		if(search.getEmployeeId() != null && search.getEmployeeId() != "") {
			query.setParameter("employeeId", search.getEmployeeId());
		}
		if(search.getEmployeeName() != null && search.getEmployeeName() != "") {
			query.setParameter("employeeName", search.getEmployeeName());
		}
		if(search.getEmployeeEmail() != null && search.getEmployeeEmail() != "") {
			query.setParameter("employeeEmail", search.getEmployeeEmail());
		}
		if(search.getEmployeeStatus() != null && search.getEmployeeStatus() != "") {
			query.setParameter("employeeStatus", search.getEmployeeStatus());
		}
		if(search.getEmployeePhone() != null && search.getEmployeePhone() != "") {
			query.setParameter("employeePhone", search.getEmployeePhone());
		}
		
		return query.getSingleResult();
	}
	
	public String sqlEmployee(EmployeeEntity search) {
		String jpql = "";
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
		return jpql;
	}
}
