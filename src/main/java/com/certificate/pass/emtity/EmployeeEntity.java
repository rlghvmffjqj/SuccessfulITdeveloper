package com.certificate.pass.emtity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Component
@Entity
@Table(name="employee")
public class EmployeeEntity implements Serializable {
	@Id
	@Column(name = "employeeid")
	private String employeeId;
	@Column(name = "employeename")
	private String employeeName;
	@Column(name = "employeenickname")
	private String employeeNickName;
	@Column(name = "employeephone")
	private String employeePhone;
	@Column(name = "employeeemail")
	private String employeeEmail;
	@Column(name = "employeeimg")
	private String employeeImg;
	@Column(name = "employeestatus")
	private String employeeStatus;
	@Column(name = "lastlogin")
	private String lastLogin;
	@Column(name = "employeeregistrant")
	private String employeeRegistrant;
	@Column(name = "employeeregistrationdate")
	private String employeeRegistrationDate;
	@Column(name = "employeemodifier")
	private String employeeModifier;
	@Column(name = "employeemodifieddate")
	private String employeeModifiedDate;
	
	@Transient
	private String usersRole;
	@Transient
	private String usersPw;	
	
	@Transient
	private int page=1;							
	@Transient
	private int rows=25;						
	@Transient
	private String sidx="employeeId";			
	@Transient
	private String sord;
}
