package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Announcement {
	private int announcementKeyNum;
	private String announcementTitle;
	private String announcementDetail;
	private int announcementCount;
	private String announcementRegistrant;
	private String announcementRegistrationDate;
	private String announcementModifier;
	private String announcementModifiedDate;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="announcementKeyNum";			// 정렬할 기준 데이터
	private String sord;
}
