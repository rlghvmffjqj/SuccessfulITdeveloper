package com.certificate.pass.core;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 사용자 권한
 * @author rlghv
 *
 */
@AllArgsConstructor
@Getter
public enum Role {
	ADMIN("ROLE_ADMIN"),
	MEMBER("ROLE_MEMBER");
	
	private String value;
}