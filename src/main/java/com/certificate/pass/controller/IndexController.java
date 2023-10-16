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
	public String indexView(@RequestParam(defaultValue = "1") int page, Model model) {
		int size = 5;
		List<MainContents> list = new ArrayList<>(integratedService.getIndexList(page, size));
		int total = integratedService.getIndexCount();
		int group = (page - 1) / size;
		int startPage = group * size + 1;
		int endPage = (startPage + size - 1 > total) ? total : startPage + size - 1;
		if(endPage>total/size+1) {
			endPage = endPage - (endPage-(total/size+1));
		}
		
		model.addAttribute("mainContentsList", list);
		model.addAttribute("mainContentsCount", total);
		model.addAttribute("page",page);
		model.addAttribute("size",size);
		model.addAttribute("total", total/size);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		return "/Index";
	}
}
