package com.certificate.pass.core;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.certificate.pass.vo.Kakao;

@Component
public class KakaoOAuth2 {
    public Kakao getUserInfo(String authorizedCode) {
        String accessToken = getAccessToken(authorizedCode);
        Kakao userInfo = getUserInfoByToken(accessToken);

        return userInfo;
    }

    private String getAccessToken(String authorizedCode) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", "a7798e143bff6a362744770e8ad774e0");
        params.add("redirect_uri", "https://khkim.itdeveloper.kro.kr//ITDeveloper/login/kakao");
        params.add("code", authorizedCode);

        RestTemplate rt = new RestTemplate();
        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest =
                new HttpEntity<>(params, headers);

        ResponseEntity<String> response = rt.exchange(
                "https://kauth.kakao.com/oauth/token",
                HttpMethod.POST,
                kakaoTokenRequest,
                String.class
        );

        JSONParser parser = new JSONParser();
        Object obj = null;
		try {
			obj = parser.parse(response.getBody());
		} catch (ParseException e) {
			e.printStackTrace();
		}
        JSONObject rjson = (JSONObject) obj;
        String accessToken = (String)rjson.get("access_token");

        return accessToken;
    }

    private Kakao getUserInfoByToken(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        RestTemplate rt = new RestTemplate();
        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers);

        ResponseEntity<String> response = rt.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.POST,
                kakaoProfileRequest,
                String.class
        );
        JSONParser parser = new JSONParser();
        Object obj = null;
		try {
			obj = parser.parse(response.getBody());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        JSONObject body = (JSONObject) obj;
        
        Long id = (Long) body.get("id");
        String email = (String)((JSONObject)body.get("kakao_account")).get("email");
        String nickname = (String)((JSONObject)body.get("properties")).get("nickname");

        return new Kakao(id, email, nickname);
    }
}