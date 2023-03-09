package com.certificate.pass.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.Requests;
import com.certificate.pass.vo.Requestscomment;

@Repository
public class RequestsDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int insertRequests(Requests requests) {
		return sqlSession.insert("requests.insertRequests", requests);
	}

	public List<Requests> getRequestsList(Requests search) {
		return sqlSession.selectList("requests.getRequestsList", search);
	}

	public int getRequestsListCount(Requests search) {
		return sqlSession.selectOne("requests.getRequestsListCount", search);
	}

	public Requests getRequestsOne(int requestsKeyNum) {
		return sqlSession.selectOne("requests.getRequestsOne", requestsKeyNum);
	}

	public List<Requestscomment> getRequestscomment(int requestsKeyNum) {
		return sqlSession.selectList("requestscomment.getRequestsList", requestsKeyNum);
	}

	public int insertRequestsComment(Requestscomment requestsComment) {
		return sqlSession.insert("requestscomment.insertRequestsComment", requestsComment);
	}

	public void updateRequestsComment(String requestsState, int requestsKeyNum) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("requestsState", requestsState);
		parameters.put("requestsKeyNum", requestsKeyNum);
		sqlSession.update("requests.updateRequestsComment", parameters);
	}

	public int deleteRequests(int requestsKeyNum) {
		return sqlSession.delete("requests.deleteRequests", requestsKeyNum);
	}

}
