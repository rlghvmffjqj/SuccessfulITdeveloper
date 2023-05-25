package com.certificate.pass.jpaDao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.certificate.pass.emtity.UsersEntity;

@Repository
public interface UsersJpaDao extends JpaRepository<UsersEntity, Long>{
	UsersEntity findByUsersId(String usersId);
	UsersEntity findUsersPwByUsersId(String usersId);
	UsersEntity findUsersRoleByUsersId(String usersId);
}