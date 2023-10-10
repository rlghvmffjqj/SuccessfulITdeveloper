package com.certificate.pass.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.certificate.pass.service.IntegratedService;
import com.certificate.pass.vo.MainContents;

@Controller
public class IndexController {
	@Autowired IntegratedService integratedService;
	
	@GetMapping("/index")
	public String indexView(Model model) {
		ArrayList<MainContents> list = new ArrayList<>(integratedService.getIndexList());
		model.addAttribute("mainContentsList", list);
		model.addAttribute("mainContentsCount", integratedService.getIndexCount());
		return "/Index";
	}
}
