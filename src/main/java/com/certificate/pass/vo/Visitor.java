package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Visitor {
	private int visitorKeyNum;
	private String visitorIp;
	private String visitorDate;
}
