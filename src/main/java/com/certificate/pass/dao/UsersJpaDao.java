package com.certificate.pass.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.certificate.pass.vo.Users;


public interface UsersJpaDao extends JpaRepository<Users, String>{
	Optional<Users> findByUsersId(String usersId);
}