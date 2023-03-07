package com.certificate.pass.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.AnnouncementDao;
import com.certificate.pass.vo.Announcement;
import com.certificate.pass.vo.Requests;

@Service
public class AnnouncementService {
	@Autowired AnnouncementDao announcementDao;

	public List<Announcement> getAnnouncementList(Announcement search) {
		return announcementDao.getAnnouncementList(search);
	}

	public int getAnnouncementListCount() {
		return announcementDao.getAnnouncementListCount();
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public int insertAnnouncement(Announcement announcement) {
		int sucess = announcementDao.insertAnnouncement(announcement);
		if (sucess <= 0)
			return 0;
		return announcement.getAnnouncementKeyNum();
	}

	public Announcement getAnnouncementOne(int announcementKeyNum) {
		return announcementDao.getAnnouncementOne(announcementKeyNum);
	}

	public void announcementCountPlus(int announcementKeyNum) {
		announcementDao.announcementCountPlus(announcementKeyNum);
	}

}
