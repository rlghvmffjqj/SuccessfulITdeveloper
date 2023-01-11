package com.certificate.pass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.service.AlgorithmService;

@Controller
public class AlgorithmContoller {
	@Autowired AlgorithmService algorithmService;
	
	@GetMapping("/informationProcessing/algorithm")
	public String algorithm() {
		return "/informationProcessing/algorithm/AlgorithmList";
	}
}
