package com.certificate.pass.core;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(securedEnabled = true)
public class Securityconfig extends WebSecurityConfigurerAdapter{
	
	private final AuthenticationSuccessHandler authenticationSuccessHandler;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		// 접속 권한
		http.authorizeRequests()
			.antMatchers("/employeeList").hasRole("ADMIN")
			.antMatchers("/employee/**").hasRole("ADMIN")
			.antMatchers("/announcementWrite").hasRole("ADMIN")
			.antMatchers("/category/categorySetting").hasRole("ADMIN")
			.antMatchers("/category/categorySettingSave").hasRole("ADMIN")
			.antMatchers("/").permitAll();
		
		// 로그인 설정
		http.formLogin()
			.loginPage("/login")
			.usernameParameter("usersId")
			.passwordParameter("usersPw")
			.defaultSuccessUrl("/index")
			.failureUrl("/loginFail")
			.successHandler(authenticationSuccessHandler)
			.permitAll();
			
		
		// 로그아웃 설정
		http.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			.logoutSuccessUrl("/login")
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			.permitAll();
		
		// 권한이 없는 사용자가 접속한 경우
		http.exceptionHandling()
			.accessDeniedPage("/denied");
		
		http.headers().frameOptions().sameOrigin();
		
		http.csrf().disable();
		
		http.sessionManagement()
	     .maximumSessions(1)	// 동시 접속 가능 세션수
	     .expiredUrl("/duplicateLogin")	// 세션 만료 시 이동 URL
	     .maxSessionsPreventsLogin(false);	// false 일경우 기존 로그인 로그 아웃 후 새로그인
	}
	
	@Bean 
	public BCryptPasswordEncoder bCryptPasswordEncoder() { 
		return new BCryptPasswordEncoder(); 
	}
	
	@Bean
	public SessionRegistry sessionRegistry() {
	  SessionRegistry sessionRegistry = new SessionRegistryImpl();
	  return sessionRegistry;
	}
	
	// KAKAO 추가시 등록 빈생성
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
	    return super.authenticationManagerBean();
	}
	
}