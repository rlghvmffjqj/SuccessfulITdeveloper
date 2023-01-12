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
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="requestsKeyNum";			// 정렬할 기준 데이터
	private String sord;
}
