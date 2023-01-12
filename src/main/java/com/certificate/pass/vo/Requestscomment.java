package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Requestscomment {
	private int requestsCommentKeyNum;
	private int requestsKeyNum;
	private String requestsCommentDetail;
	private String requestsCommentDate;
	private String requestsCommentRegistrant;
	private String requestsCommentRegistrationDate;
	private String requestsCommentModifier;
	private String requestsCommentModifiedDate;
}
