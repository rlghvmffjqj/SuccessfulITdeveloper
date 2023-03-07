package com.certificate.pass.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.service.EmployeeService;
import com.certificate.pass.service.RequestsService;
import com.certificate.pass.vo.Requests;
import com.certificate.pass.vo.Requestscomment;

@Controller
public class RequestsController {
	@Autowired RequestsService requestsService;
	@Autowired EmployeeService employeeService;

	@GetMapping("/requestsWrite")
	public String requestsWrite() {
		return "/requests/RequestsWrite";
	}
	
	@GetMapping("/requestsList")
	public String requestsList() {
		return "/requests/RequestsList";
	}
	
	@PostMapping("/requestsView")
	public String requestsView(Model model, int requestsKeyNum) {
		Requests requests = requestsService.getRequestsOne(requestsKeyNum);
		ArrayList<Requestscomment> requestscomment = new ArrayList<>(requestsService.getRequestscomment(requestsKeyNum));
		model.addAttribute("requests", requests);
		model.addAttribute("requestscomment", requestscomment);
		return "/requests/RequestsView";
	}
	
	@ResponseBody
	@PostMapping(value = "/requests")
	public Map<String, Object> requests(@ModelAttribute("search") Requests search, Principal principal) {
		String role = employeeService.getUsersRole(principal.getName());
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(!role.equals("ADMIN")) {
			search.setUsersId(principal.getName());
		} 
		ArrayList<Requests> list = new ArrayList<>(requestsService.getRequestsList(search));
		int totalCount = requestsService.getRequestsListCount();
		
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/requestsWrite")
	public int insertRequests(Requests requests, Principal principal) {
		requests.setEmployeeId(principal.getName());
		requests.setRequestsRegistrant(principal.getName());
		requests.setRequestsDate(requestsService.nowDate());
		requests.setRequestsRegistrationDate(requestsService.nowDate());
		requests.setRequestsState("답변대기");
		return requestsService.insertRequests(requests);
	}
	
	@ResponseBody
	@PostMapping(value = "/requestsComment/insert")
	public String insertRequestsComment(Requestscomment requestsComment, Principal principal) {
		requestsComment.setRequestsCommentRegistrant(principal.getName());
		requestsComment.setRequestsCommentDate(requestsService.nowDate());
		requestsComment.setRequestsCommentRegistrationDate(requestsService.nowDate());
		return requestsService.insertRequestsComment(requestsComment);
	}
	
	@ResponseBody
	@PostMapping(value = "/requests/delete")
	public Map<String, String> deleteRequests(@RequestParam int[] chkList) {
		Map<String, String> map = new HashMap<String, String>();
		String result = requestsService.deleteRequests(chkList);
		map.put("result", result);
		return map;
	}
	
}
