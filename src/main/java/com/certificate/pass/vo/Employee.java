package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Employee {
	private String employeeId;
	private String employeeName;
	private String employeePhone;
	private String employeeEmail;
	private String employeeImg;
	private String employeeStatus;
	private String lastLogin;
	private String employeeRegistrant;
	private String employeeRegistrationDate;
	private String employeeModifier;
	private String employeeModifiedDate;
	
	private String usersRole;
	private String usersPw;	
	
	private int page=1;							
	private int rows=25;						
	private String sidx="employeeId";			
	private String sord;
}
