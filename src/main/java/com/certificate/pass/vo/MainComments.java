package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class MainComments {
	private Integer mainCommentsKeyNum;
	private Integer mainCommentsParentKeyNum;
	private Integer mainContentsKeyNum;
	private Integer mainCommentsDepth;
	private String mainCommentsFullPath;
	private String mainCommentsContents;
	private String mainCommentsId;
	private String mainCommentsName;
	private String mainCommentsPassword;
	private String mainCommentsDate;
	private boolean mainCommentsSecret;
	private String mainCommentsRegistrant;
	private String mainCommentsRegistrationDate;
	private String mainCommentsModifier;
	private String mainCommentsModifiedDate;
	
	private String mainCommentsNameDialog;
	private String mainCommentsPasswordDialog;
	private String mainCommentsContentsDialog;
	private boolean mainCommentsSecretDialog;
	private String mainCommentsIdDialog;
}

