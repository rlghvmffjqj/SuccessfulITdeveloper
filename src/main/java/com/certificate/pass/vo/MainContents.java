package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class MainContents {
	private Integer mainContentsKeyNum;
	private String topItemsName;
	private String middleItemsName;
	private String mainContentsTitle;
	private String mainContentsDetail;
	private Integer mainContentsCount;
	private String mainContentsDate;
	private String mainContentsRegistrant;
	private String mainContentsRegistrationDate;
	private String mainContentsModifier;
	private String mainContentsModifiedDate;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="mainContentsKeyNum";			// 정렬할 기준 데이터
	private String sord;
}
