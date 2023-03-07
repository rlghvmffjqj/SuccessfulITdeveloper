package com.certificate.pass.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.Announcement;
import com.certificate.pass.vo.Requests;

@Repository
public class AnnouncementDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Announcement> getAnnouncementList(Announcement search) {
		return sqlSession.selectList("announcement.getAnnouncementList", search);
	}

	public int getAnnouncementListCount() {
		return sqlSession.selectOne("announcement.getAnnouncementListCount");
	}

	public int insertAnnouncement(Announcement announcement) {
		return sqlSession.insert("announcement.insertAnnouncement", announcement);
	}

	public Announcement getAnnouncementOne(int announcementKeyNum) {
		return sqlSession.selectOne("announcement.getAnnouncementOne", announcementKeyNum);
	}

	public void announcementCountPlus(int announcementKeyNum) {
		 sqlSession.update("announcement.announcementCountPlus", announcementKeyNum);
	}
}
