package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Favorites {
	private int favoritesKeyNum;
	private String usersId;
	private Integer mainContentsKeyNum;
	private String favoritesIp;
	private String favoritesRegistrant;
	private String favoritesRegistrationDate;
	private String favoritesModifier;
	private String favoritesModifiedDate;
}
