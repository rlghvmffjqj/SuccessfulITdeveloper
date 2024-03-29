package com.certificate.pass.core;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;


@Configuration
public class XssConfig implements WebMvcConfigurer {
	@Bean
	public FilterRegistrationBean<XssEscapeServletFilter> filterRegistrationBean() {
		FilterRegistrationBean<XssEscapeServletFilter> filterRegistration = new FilterRegistrationBean<>();
		filterRegistration.setFilter(new XssEscapeServletFilter());
		filterRegistration.setOrder(1);
		//filterRegistration.addUrlPatterns("/*");
		List<String> urls = new ArrayList<>();
		urls.add("/index");
		//urls.add("/category/mainContentsView");
		filterRegistration.setUrlPatterns(urls);
		return filterRegistration;
	}
	
}