package com.certificate.pass.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public List<MainContents> getIndexList(int offset, int limit) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("offset", offset);
		parameters.put("limit", limit);
		return sqlSession.selectList("integrated.getIndexList", parameters);
	}

	public int getIndexCount() {
		return sqlSession.selectOne("integrated.getIndexCount");
	}

}
