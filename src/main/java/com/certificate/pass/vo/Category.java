package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Category {
	private String topItemsName;
	private String middleItemsName;
	
	private String registrant;
	private String registrationDate;
	private String modifier;
	private String modifiedDate;

}
