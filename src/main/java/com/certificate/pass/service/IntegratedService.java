package com.certificate.pass.service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

	public List<MainContents> getIndexList(int page, int size) {
		int offset = (page - 1) * size;
		List<MainContents> mainContentsList = integratedDao.getIndexList(offset,size);
		for(MainContents mainContents : mainContentsList) {
			String longBlobData = mainContents.getMainContentsDetail();
			if(!longBlobData.substring(longBlobData.length() - 1).equals(">")) {
				longBlobData += ">";
			}
			mainContents.setMainContentsImg(mainContents.getMainContentsImg());
			longBlobData = removeHtmlTags(longBlobData);
			
			mainContents.setMainContentsDetail(longBlobData);
		}
		return mainContentsList;
	}
	
	// HTML 태그를 정규 표현식을 사용하여 제거하는 함수
    private static String removeHtmlTags(String input) {
        Pattern pattern = Pattern.compile("<[^>]*>");
        Matcher matcher = pattern.matcher(input);
        return matcher.replaceAll(""); // HTML 태그 제거
    }
    
    private static String imgHTmlTage(String input) {
        Pattern pattern = Pattern.compile("<img[^>]+>");
        Matcher matcher = pattern.matcher(input);
        
        if (matcher.find()) {
            String firstImgTag = matcher.group();
            return firstImgTag;
        }
        return "";
    }

	public int getIndexCount() {
		return integratedDao.getIndexCount();
	}

}
