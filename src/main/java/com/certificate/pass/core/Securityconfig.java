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
		
		http.authorizeRequests()
			.antMatchers("/employeeList").hasRole("ADMIN")
			.antMatchers("/employee/**").hasRole("ADMIN")
			.antMatchers("/announcementWrite").hasRole("ADMIN")
			.antMatchers("/category/categorySetting").hasRole("ADMIN")
			.antMatchers("/category/categorySettingSave").hasRole("ADMIN")
			.antMatchers("/").permitAll();
		
		http.formLogin()
			.loginPage("/login")
			.usernameParameter("usersId")
			.passwordParameter("usersPw")
			.defaultSuccessUrl("/index")
			.failureUrl("/loginFail")
			.successHandler(authenticationSuccessHandler)
			.permitAll();
			
		
		http.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			.logoutSuccessUrl("/login")
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			.permitAll();
		
		http.exceptionHandling()
			.accessDeniedPage("/denied");
		
		http.headers().frameOptions().sameOrigin();
		
		http.csrf().disable();
		
		http.sessionManagement()
	     .maximumSessions(1)	
	     .expiredUrl("/duplicateLogin")	
	     .maxSessionsPreventsLogin(false);	
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
	
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
	    return super.authenticationManagerBean();
	}
	
}