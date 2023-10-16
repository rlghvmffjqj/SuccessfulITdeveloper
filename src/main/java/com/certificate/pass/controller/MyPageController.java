package com.certificate.pass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.service.MyPageService;

@Controller
public class MyPageController {
	@Autowired MyPageService myPageService;
	
	@GetMapping("/myPage")
	public String MyPage() {
		return "/myPage/MyPage";
	}
}
