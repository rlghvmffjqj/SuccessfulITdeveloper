package com.certificate.pass.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.certificate.pass.service.IntegratedService;
import com.certificate.pass.vo.MainContents;

@Controller
public class IndexController {
	@Autowired IntegratedService integratedService;
	
	@GetMapping("/index")
	public String indexView(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int size, Model model) {
		List<MainContents> list = new ArrayList<>(integratedService.getIndexList(page, size));
		model.addAttribute("mainContentsList", list);
		model.addAttribute("mainContentsCount", integratedService.getIndexCount());
		model.addAttribute("page",page);
		model.addAttribute("size",size);
		return "/Index";
	}
}
