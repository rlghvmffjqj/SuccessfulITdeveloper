package com.certificate.pass.vo;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class LoginSession extends User{
	public LoginSession(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities, String loginId, String loginIp, String loginTime) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.loginId = loginId;
		this.loginIp = loginIp;
		this.loginTime = loginTime;
	}
	
	public static LoginSession getLoginUser() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			if (auth.getPrincipal() instanceof LoginSession) {
				return (LoginSession) auth.getPrincipal();
			}
		}

		return null;
	}
	
	private String loginId = "";
	private String roleName = "";
	private int isSysAdmin = 0;

	private String loginIp = "";
	private String loginTime = "";
	private String logoutTime = "";
	private String sessionId = "";

	private String empNum = "";
	private String empName = "";

	private String encodingSalt;
	private String encodingType;

	private String allowIp = "";
	private String lastRequestTime = "";
	private String lastRequestURL = "";

}
