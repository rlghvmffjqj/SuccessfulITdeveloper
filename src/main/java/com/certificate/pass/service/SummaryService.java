package com.certificate.pass.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.SummaryDao;

@Service
public class SummaryService {
	@Autowired SummaryDao summaryDao;

}
