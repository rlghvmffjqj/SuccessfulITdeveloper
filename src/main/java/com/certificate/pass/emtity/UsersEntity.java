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
	@Column(name = "usersid")
	private String usersId;					
	@Column(name = "userspw")
	private String usersPw;					
	@Column(name = "usersstate")
	private String usersState;				
	@Column(name = "usersrole")
	private String usersRole;				
	
}
