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
	
	private int page=1;							
	private int rows=25;						
	private String sidx="mainContentsKeyNum";			
	private String sord;
}
