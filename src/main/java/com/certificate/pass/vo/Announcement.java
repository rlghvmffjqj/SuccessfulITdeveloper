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
	
	private int page=1;							
	private int rows=25;						
	private String sidx="announcementKeyNum";			
	private String sord;
}
