package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class FreeBoard {
	private Integer freeBoardKeyNum;
	private String freeBoardTitle;
	private String freeBoardDetail;
	private Integer freeBoardCount;
	private String freeBoardUserId;
	private String freeBoardDate;
	private String freeBoardRegistrant;
	private String freeBoardRegistrationDate;
	private String freeBoardModifier;
	private String freeBoardModifiedDate;
	
	private int page=1;							
	private int rows=25;						
	private String sidx="freeBoardKeyNum";			
	private String sord;
}
