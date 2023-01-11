package com.certificate.pass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.service.PastQuestionService;

@Controller
public class PastQuestionController {
	@Autowired PastQuestionService pastQuestionService;
	
	@GetMapping("/informationProcessing/pastQuestion")
	public String pastQuestion() {
		return "/informationProcessing/pastQuestion/PastQuestionList";
	}
	
	@GetMapping("/informationProcessing/pastQuestion/20223")
	public String pastQuestion20223() {
		return "/informationProcessing/pastQuestion/PastQuestion20223";
	}
}
