package com.certificate.pass.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.certificate.pass.core.KakaoOAuth2;
import com.certificate.pass.core.Role;
import com.certificate.pass.dao.EmployeeDao;
import com.certificate.pass.dao.UsersJpaDao;
import com.certificate.pass.vo.Employee;
import com.certificate.pass.vo.Kakao;
import com.certificate.pass.vo.LoginSession;
import com.certificate.pass.vo.Users;

@Service
public class UsersService implements UserDetailsService{
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired HttpSession session;
	@Autowired EmployeeDao employeeDao;
	@Autowired HttpServletRequest request;
	@Autowired Employee employee;
	
	private final PasswordEncoder passwordEncoder;
    private final KakaoOAuth2 kakaoOAuth2;
    private final AuthenticationManager authenticationManager;
    private static final String ADMIN_TOKEN = "a7798e143bff6a362744770e8ad774e0";
	
	@Autowired
    public UsersService(PasswordEncoder passwordEncoder, KakaoOAuth2 kakaoOAuth2, AuthenticationManager authenticationManager) {
        this.passwordEncoder = passwordEncoder;
        this.kakaoOAuth2 = kakaoOAuth2;
        this.authenticationManager = authenticationManager;
    }
	
	boolean enabled = true;
    boolean accountNonExpired = true;
    boolean credentialsNonExpired = true;
    boolean accountNonLocked = true;
    
	@Override
	public UserDetails loadUserByUsername(String usersId) throws UsernameNotFoundException {
		Optional<Users> usersEntityWrapper = usersJpaDao.findByUsersId(usersId);
		Users usersEntity = usersEntityWrapper.orElse(null);
		
		List<GrantedAuthority> authorities =new ArrayList<>();
		
		// 권한 세션 저장
		if (usersEntity.getUsersRole().equals("ADMIN")) {
			authorities.add(new SimpleGrantedAuthority(Role.ADMIN.getValue()));
			session.setAttribute("usersId", "admin");
		} else {
			authorities.add(new SimpleGrantedAuthority(Role.MEMBER.getValue()));
			session.setAttribute("usersId", "users");
		}
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
		String loginId = usersEntity.getUsersId();
		String loginIp = request.getRemoteAddr();
		String loginTime = df.format(new Date());
		
		// 접속 세션 목록 저장을 위해 추가
		LoginSession loingSession = new LoginSession(
				usersEntity.getUsersId(),
				usersEntity.getUsersPw(), enabled, accountNonExpired, credentialsNonExpired, accountNonLocked,
				authorities, loginId, loginIp, loginTime
		);
		// 로그인시 사용자 접속 로그 추가
		//employeeUidLogService.insertEmployeeUidLog(usersEntity.getUsersId());
		
		return loingSession;
		// return new User(usersEntity.getUsersId(), usersEntity.getUsersPw(), authorities);  // 기존 코드
	}
	
	public String loginIdPwd(String usersId, String usersPw) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String nowPwd = employeeDao.getUsersPw(usersId);
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(passwordEncoder.matches(usersPw,nowPwd)) {
			employeeDao.lastLogin(formatter.format(now), usersId);
			return "OK";
		}
		return "FALSE";
	}
	
	@Transactional
	public String save(Users users) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		users.setUsersPw(passwordEncoder.encode(users.getUsersPw()));
		String result = usersJpaDao.save(users).getUsersId();
		if(result.isEmpty()) {
			return "FALSE";
		}
		return "OK";
	}
	
	public void kakaoLogin(String authorizedCode) {
        // 카카오 OAuth2 를 통해 카카오 사용자 정보 조회
        Kakao userInfo = kakaoOAuth2.getUserInfo(authorizedCode);
        // 카카오톡 이메일을 아이디로 사용
        String usersId = userInfo.getEmail();

        // 우리 DB 에서 회원 Id 와 패스워드
        // 회원 Id = 카카오 nickname
        // 패스워드 = 카카오 Id + ADMIN TOKEN
        String password = usersId + ADMIN_TOKEN;

        // DB 에 중복된 Kakao Id 가 있는지 확인
        Users kakaoUser = usersJpaDao.findByUsersId(usersId).orElse(null);

        Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
		// 카카오 정보로 회원가입
        if (kakaoUser == null) {
        	
    		
            // 패스워드 인코딩
            String usersPw = passwordEncoder.encode(password);
            // ROLE = 사용자
            String usersRole = "MEMBER";
            String usersStatus = "KAKAO";

            kakaoUser = new Users(usersId, usersPw, usersStatus, usersRole);
            usersJpaDao.save(kakaoUser);
            
            // 사원 정보 넣어주기
            employee.setEmployeeId(usersId);
            employee.setEmployeeEmail(usersId);
            employee.setEmployeeName(userInfo.getNickname());
            employee.setEmployeeStatus("정상");
            employee.setEmployeeRegistrant(usersId);
            employee.setEmployeeRegistrationDate(formatter.format(now));
            employeeDao.insertEmployee(employee);
        }

        // 로그인 처리
        Authentication kakaoUsernamePassword = new UsernamePasswordAuthenticationToken(usersId, password);
        Authentication authentication = authenticationManager.authenticate(kakaoUsernamePassword);
        employeeDao.lastLogin(formatter.format(now), usersId);
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

	public String getState(String usersId) {
		return employeeDao.getState(usersId);
	}
}
