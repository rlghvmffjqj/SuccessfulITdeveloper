package com.certificate.pass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.service.IngangService;

@Controller
public class IngangController {
	@Autowired IngangService ingangService;
	
	@GetMapping("/informationProcessing/ingang")
	public String ingang() {
		return "/informationProcessing/ingang/IngangList";
	}
}
