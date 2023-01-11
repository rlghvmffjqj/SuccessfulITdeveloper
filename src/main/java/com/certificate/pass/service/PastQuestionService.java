package com.certificate.pass.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.PastQuestionDao;

@Service
public class PastQuestionService {
	@Autowired PastQuestionDao pastQuestionDao;

}
