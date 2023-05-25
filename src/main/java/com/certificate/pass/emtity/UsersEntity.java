package com.certificate.pass.emtity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Component
@Table(name="users")
public class UsersEntity implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "usersid")
	private String usersId;					// 사용자 아이디
	@Column(name = "userspw")
	private String usersPw;					// 사용자 패스워드
	@Column(name = "usersstate")
	private String usersState;				// 사용자 상태 ex) 사용, 잠김
	@Column(name = "usersrole")
	private String usersRole;				// 역할 ex) 일반사용자, 관리자, 사용자
	
}
