package com.certificate.pass.jpaDao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.certificate.pass.emtity.EmployeeEntity;

@Repository
public interface EmployeeJpaDao extends JpaRepository<EmployeeEntity, String> {
	EmployeeEntity findByEmployeeId(String employeeId);
	EmployeeEntity findByEmployeeEmail(String employeeEmail);
	EmployeeEntity findByEmployeeIdAndEmployeeEmail(String employeeId, String employeeEmail);
}
