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
	private int freeBoardKeyNum;
	private String freeBoardTitle;
	private String freeBoardDetail;
	private Integer freeBoardCount;
	private String freeBoardUserId;
	private String freeBoardDate;
	private String freeBoardRegistrant;
	private String freeBoardRegistrationDate;
	private String freeBoardModifier;
	private String freeBoardModifiedDate;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="freeBoardKeyNum";			// 정렬할 기준 데이터
	private String sord;
}
