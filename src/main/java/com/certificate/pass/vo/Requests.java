package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Requests {
	private int requestsKeyNum;
	private String employeeId;
	private String requestsTitle;
	private String requestsDetail;
	private String requestsState;
	private String requestsDate;
	private String requestsRegistrant;
	private String requestsRegistrationDate;
	private String requestsModifier;
	private String requestsModifiedDate;
	
	private String employeeName = "";
	private String usersId;
	
	private int page=1;							
	private int rows=25;						
	private String sidx="requestsKeyNum";			
	private String sord;
}
