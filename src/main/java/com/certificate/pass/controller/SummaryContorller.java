package com.certificate.pass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.service.SummaryService;

@Controller
public class SummaryContorller {
	@Autowired SummaryService summaryService;
	
	@GetMapping("/informationProcessing/summary")
	public String summary() {
		return "/informationProcessing/summary/SummaryList";
	}
}
