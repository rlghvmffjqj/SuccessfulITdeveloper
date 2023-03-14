package com.certificate.pass.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.IntegratedDao;
import com.certificate.pass.vo.MainContents;

@Service
public class IntegratedService {
	@Autowired IntegratedDao integratedDao;

	public List<MainContents> getIntegratedList(MainContents search) {
		return integratedDao.getIntegratedList(search);
	}

	public int getIntegratedListCount(MainContents search) {
		return integratedDao.getIntegratedListCount(search);
	}

}
