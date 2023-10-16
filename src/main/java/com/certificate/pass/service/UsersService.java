package com.certificate.pass.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.emtity.UsersEntity;
import com.certificate.pass.jpaDao.EmployeeJpaDao;
import com.certificate.pass.jpaDao.UsersJpaDao;
import com.certificate.pass.vo.Employee;
import com.certificate.pass.vo.Kakao;
import com.certificate.pass.vo.LoginSession;
import com.certificate.pass.vo.Visitor;

@Service
public class UsersService implements UserDetailsService{
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired HttpSession session;
	@Autowired EmployeeDao employeeDao;
	@Autowired EmployeeJpaDao employeeJpaDao;
	@Autowired HttpServletRequest request;
	
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
		UsersEntity usersEntityWrapper = usersJpaDao.findByUsersId(usersId);
		UsersEntity usersEntity = usersEntityWrapper;
		
		List<GrantedAuthority> authorities =new ArrayList<>();
		
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
		
		LoginSession loingSession = new LoginSession(
				usersEntity.getUsersId(),
				usersEntity.getUsersPw(), enabled, accountNonExpired, credentialsNonExpired, accountNonLocked,
				authorities, loginId, loginIp, loginTime
		);
		//employeeUidLogService.insertEmployeeUidLog(usersEntity.getUsersId());
		
		return loingSession;
		// return new User(usersEntity.getUsersId(), usersEntity.getUsersPw(), authorities);  
	}
	
	public String loginIdPwd(String usersId, String usersPw) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String nowPwd = usersJpaDao.findUsersPwByUsersId(usersId).getUsersPw();
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(passwordEncoder.matches(usersPw,nowPwd)) {
			EmployeeEntity employeeEntity = employeeJpaDao.findByEmployeeId(usersId);
			employeeEntity.setLastLogin(formatter.format(now));
			employeeEntity.setEmployeeId(usersId);
			employeeJpaDao.save(employeeEntity);
			return "OK";
		}
		return "FALSE";
	}
	
	@Transactional
	public String save(UsersEntity usersEntity) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		usersEntity.setUsersPw(passwordEncoder.encode(usersEntity.getUsersPw()));
		String result = usersJpaDao.save(usersEntity).getUsersId();
		if(result.isEmpty()) {
			return "FALSE";
		}
		return "OK";
	}
	
	public void kakaoLogin(String authorizedCode) {
        Kakao userInfo = kakaoOAuth2.getUserInfo(authorizedCode);
        String usersId = userInfo.getEmail();

        String password = usersId + ADMIN_TOKEN;

        UsersEntity kakaoUser = usersJpaDao.findByUsersId(usersId);

        Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        if (kakaoUser == null) {
            String usersPw = passwordEncoder.encode(password);
            String usersRole = "MEMBER";
            String usersStatus = "KAKAO";

            kakaoUser = new UsersEntity(usersId, usersPw, usersStatus, usersRole);
            usersJpaDao.save(kakaoUser);
            
            EmployeeEntity employeeEntity = new EmployeeEntity();
            
            employeeEntity.setEmployeeId(usersId);
            employeeEntity.setEmployeeEmail(usersId);
            employeeEntity.setEmployeeName(userInfo.getNickname());
            employeeEntity.setEmployeeStatus("정상");
            employeeEntity.setEmployeeRegistrant(usersId);
            employeeEntity.setEmployeeRegistrationDate(formatter.format(now));
   			employeeJpaDao.save(employeeEntity);
        }

        Authentication kakaoUsernamePassword = new UsernamePasswordAuthenticationToken(usersId, password);
        Authentication authentication = authenticationManager.authenticate(kakaoUsernamePassword);
        
        EmployeeEntity employeeEntity = employeeJpaDao.findByEmployeeId(usersId);
		employeeEntity.setLastLogin(formatter.format(now));
		employeeEntity.setEmployeeId(usersId);
		employeeJpaDao.save(employeeEntity);
		
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

	public String getState(String usersId) {
		return usersJpaDao.findByUsersId(usersId).getUsersState();
	}

	public Visitor getVisitor(Visitor visitor) {
		return employeeDao.getVisitor(visitor);
		
	}

	public void insertVisitor(Visitor visitor) {
		employeeDao.insertVisitor(visitor);
	}

	public Employee getProfile(String employeeId) {
		return employeeDao.getEmployeeOne(employeeId);
	}

}
