package com.certificate.pass.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.RequestsDao;
import com.certificate.pass.vo.Requests;
import com.certificate.pass.vo.Requestscomment;

@Service
public class RequestsService {
	@Autowired RequestsDao requestsDao;
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public int insertRequests(Requests requests) {
		int sucess = requestsDao.insertRequests(requests);
		if (sucess <= 0)
			return 0;
		return requests.getRequestsKeyNum();
	}

	public List<Requests> getRequestsList(Requests search) {
		return requestsDao.getRequestsList(search);
	}

	public int getRequestsListCount() {
		return requestsDao.getRequestsListCount();
	}

	public Requests getRequestsOne(int requestsKeyNum) {
		return requestsDao.getRequestsOne(requestsKeyNum);
	}

	public List<Requestscomment> getRequestscomment(int requestsKeyNum) {
		return requestsDao.getRequestscomment(requestsKeyNum);
	}

	public String insertRequestsComment(Requestscomment requestsComment) {
		int sucess = requestsDao.insertRequestsComment(requestsComment);
		if (sucess <= 0)
			return "FALSE";
		String requestsState = "답변완료";
		if(!requestsComment.getRequestsCommentRegistrant().equals("admin")) {
			requestsState = "재답변";
		}
		requestsDao.updateRequestsComment(requestsState, requestsComment.getRequestsKeyNum());
		return "OK";
	}

}
