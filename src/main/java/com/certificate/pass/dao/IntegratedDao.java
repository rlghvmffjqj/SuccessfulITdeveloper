package com.certificate.pass.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.MainContents;

@Repository
public class IntegratedDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<MainContents> getIntegratedList(MainContents search) {
		return sqlSession.selectList("integrated.getIntegratedList", search);
	}

	public int getIntegratedListCount(MainContents search) {
		return sqlSession.selectOne("integrated.getIntegratedListCount",search);
	}

}
