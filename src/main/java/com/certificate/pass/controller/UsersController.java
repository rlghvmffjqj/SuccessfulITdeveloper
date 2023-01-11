package com.certificate.pass.controller;

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
	
	@GetMapping("/index")
	public String indexView() {
		return "/Index";
	}
	
	@GetMapping("/login")
	public String loginView() {
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
		String msg = "아이디 및 패스워드가 일치하지 않습니다.";

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
