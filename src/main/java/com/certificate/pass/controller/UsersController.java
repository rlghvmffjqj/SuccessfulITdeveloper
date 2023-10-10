package com.certificate.pass.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.service.UsersService;

@Controller
public class UsersController {
	@Autowired UsersService usersService;
	
	@GetMapping("/")
	public String View() {
		return "/Index";
	}
	
	@GetMapping("/login")
	public String loginView(HttpServletRequest request, Model model) {
		String uri = request.getHeader("Referer");
	    if (uri != null && !uri.contains("/login")) {
	        request.getSession().setAttribute("prevPage", uri);
	    }
		return "/Login";
	}
	
	@GetMapping("/signUp")
	public String signUpView() {
		return "/SignUp";
	}
	
	@GetMapping("/findId")
	public String findIdView() {
		return "/FindId";
	}
	
	@GetMapping("/findPwd")
	public String findPwdView() {
		return "/FindPwd";
	}
	
	@GetMapping("/denied")
	public String deniedView() {
		return "/Denied";
	}
	
	@GetMapping("/loginFail")
	public String loginFail(Model model) {
		String loc = "/login";
		String msg = "�븘�씠�뵒 諛� �뙣�뒪�썙�뱶媛� �씪移섑븯吏� �븡�뒿�땲�떎.";

		model.addAttribute("loc", loc).addAttribute("msg", msg);
		return "/common/msg";
	}
	
	@ResponseBody
	@PostMapping(value = "/users/pwdCheck")
	public String PwdCheck(String usersId, String usersPw) {
		String result = usersService.loginIdPwd(usersId, usersPw); 
		return result;
	}
}
