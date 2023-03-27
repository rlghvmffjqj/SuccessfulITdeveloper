package com.certificate.pass.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ConnectUser {
	private int connectUserKeyNum;
	private String connectUserIp;
	private Integer connectUserPort;
}
