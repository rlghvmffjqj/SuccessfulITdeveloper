package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class FreeBoardComments {
	private Integer freeBoardCommentsKeyNum;
	private Integer freeBoardCommentsParentKeyNum;
	private Integer freeBoardKeyNum;
	private Integer freeBoardCommentsDepth;
	private String freeBoardCommentsContents;
	private String freeBoardCommentsName;
	private String freeBoardCommentsPassword;
	private String freeBoardCommentsDate;
	private boolean freeBoardCommentsSecret;
	private String freeBoardCommentsRegistrant;
	private String freeBoardCommentsRegistrationDate;
	private String freeBoardCommentsModifier;
	private String freeBoardCommentsModifiedDate;
	
	private String freeBoardCommentsNameDialog;
	private String freeBoardCommentsPasswordDialog;
	private String freeBoardCommentsContentsDialog;
	private boolean freeBoardCommentsSecretDialog;
}
