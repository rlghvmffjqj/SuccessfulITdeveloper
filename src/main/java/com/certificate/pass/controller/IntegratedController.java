package com.certificate.pass.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.service.CategoryService;
import com.certificate.pass.service.IntegratedService;
import com.certificate.pass.vo.MainContents;

@Controller
public class IntegratedController {
	@Autowired IntegratedService integratedService;
	@Autowired CategoryService categoryService;
	
	@GetMapping("/integrated/integratedList")
	public String integratedList() {
		return "/integrated/IntegratedList";
	}
	
	@ResponseBody
	@PostMapping(value = "/integrated")
	public Map<String, Object> integrated(@ModelAttribute("search") MainContents search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<MainContents> list = new ArrayList<>(integratedService.getIntegratedList(search));
		int totalCount = integratedService.getIntegratedListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
}
