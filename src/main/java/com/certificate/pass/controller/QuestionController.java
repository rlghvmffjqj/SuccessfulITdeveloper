package com.certificate.pass.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class QuestionController {

	@GetMapping("/questionView")
	public String questionView() {
		return "/question/QuestionView";
	}
}
