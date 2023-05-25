package com.certificate.pass.emtity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
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
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "employeeid")
	private String employeeId;
	@Column(name = "employeename")
	private String employeeName;
	@Column(name = "employeephone")
	private String employeePhone;
	@Column(name = "employeeemail")
	private String employeeEmail;
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
	private int page=1;							// 기본 페이지 번호
	@Transient
	private int rows=25;						// 데이터 보여줄 갯수
	@Transient
	private String sidx="employeeId";			// 정렬할 기준 데이터
	@Transient
	private String sord;
}
