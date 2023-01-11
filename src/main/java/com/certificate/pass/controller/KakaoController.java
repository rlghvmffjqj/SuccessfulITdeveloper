package com.certificate.pass.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.certificate.pass.service.UsersService;
import com.certificate.pass.vo.Users;

@Controller
public class KakaoController {
	
	@Autowired Users users;
	@Autowired UsersService usersService;
	
	/**
	 * KAKAO 로그인
	 * @param code
	 * @return
	 */
	@GetMapping("/login/kakao")
    public String kakaoLogin(String code) {
        // authorizedCode: 카카오 서버로부터 받은 인가 코드
        usersService.kakaoLogin(code);

        return "redirect:/";
    }

	/**
	 * KAKAO 설정 등록
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login/getKakaoAuthUrl")
	public @ResponseBody String getKakaoAuthUrl(HttpServletRequest request) throws Exception {
		String reqUrl = 
				"https://kauth.kakao.com/oauth/authorize"
				+ "?client_id=a7798e143bff6a362744770e8ad774e0"
				+ "&redirect_uri=https://172.16.100.90:8443/successfulITdeveloper/login/kakao"
				+ "&response_type=code";
		
		return reqUrl;
	}
	
	@GetMapping(value = "/kakaologout")
	public String kakaologout(String usersId) {
		if(usersService.getState(usersId).equals("KAKAO")) {
			String reqUrl = 
					"https://kauth.kakao.com/oauth/logout"
					+ "?client_id=a7798e143bff6a362744770e8ad774e0"
					+ "&logout_redirect_uri=https://172.16.100.90:8443/successfulITdeveloper/login";
			return "redirect:"+reqUrl;
		} else {
			return "redirect:/logout";
		}
		
	}
}