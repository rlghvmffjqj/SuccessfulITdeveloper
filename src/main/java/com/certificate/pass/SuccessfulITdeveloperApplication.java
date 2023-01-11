package com.certificate.pass;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@MapperScan(basePackageClasses = SuccessfulITdeveloperApplication.class)
@SpringBootApplication
@EnableScheduling
public class SuccessfulITdeveloperApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(SuccessfulITdeveloperApplication.class, args);
	}
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(SuccessfulITdeveloperApplication.class);
	}
}
