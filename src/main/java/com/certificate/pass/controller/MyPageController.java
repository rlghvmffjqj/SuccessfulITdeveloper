package com.certificate.pass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.certificate.pass.service.MyPageService;

@Controller
public class MyPageController {
	@Autowired MyPageService myPageService;
}
