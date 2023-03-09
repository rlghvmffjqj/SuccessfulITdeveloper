package com.certificate.pass.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.certificate.pass.dao.CategoryDao;
import com.certificate.pass.vo.Category;
import com.certificate.pass.vo.MainComments;
import com.certificate.pass.vo.MainContents;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CategoryService {
	@Autowired CategoryDao categoryDao;

	public List<String> topItems() {
		return categoryDao.topItems();
	}

	public List<String> middleItems(String topItemsName) {
		return categoryDao.middleItems(topItemsName);
	}

	public List<MainContents> getCategoryList(String topItemsName, String middleItemsName) {
		return categoryDao.getCategoryList(topItemsName, middleItemsName);
	}

	public int getCategoryListCount(String topItemsName, String middleItemsName) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<String> getTopMenuCategoryList() {
		return categoryDao.getTopMenuCategoryList();
	}

	public List<Category> getMiddleMenuCategoryList() {
		return categoryDao.getMiddleMenuCategoryList();
	}

	public List<String> getMiddleTopNameList() {
		return categoryDao.getMiddleTopNameList();
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertCategorySetting(Category category, Principal principal) {
		int count = 1;
		List<String> topMenuList = new ArrayList<String>();
		List<String> middleMenuList = new ArrayList<String>();
		
		String[] topMenuStr = category.getTopItemsName().split(",");
		String[] middleMenuStr = category.getMiddleItemsName().split(",");
		
		for(String topMenu : topMenuStr) {
			topMenuList.add(topMenu);
		}
		for(String middleMenu : middleMenuStr) {
			middleMenuList.add(middleMenu);
		}
		
		categoryDao.deleteTopItems();
		categoryDao.deleteMiddleItems();
		
		for(String topMenu : topMenuList) {
			if(!topMenu.isBlank()) {
				if(!topMenu.equals("|")) {
					category.setTopItemsName(topMenu);
					count *= categoryDao.insertTopItems(category);
				} else {
					continue;
				}
				
				int middleMenuSize = middleMenuList.size();
				for(int i=0; i<middleMenuSize; i++) {
					if(!middleMenuList.get(0).isBlank()) {
						if(middleMenuList.get(0).equals("|")) {
							break;
						} else {
							category.setMiddleItemsName(middleMenuList.get(0));
							count *= categoryDao.insertMiddleItems(category);
						}
					}
					middleMenuList.remove(0);
				}
			}
			middleMenuList.remove(0);
		}
		
		if(count > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public int insertMainContents(MainContents mainContents, Principal principal) {
		int sucess = categoryDao.insertMainContents(mainContents);
		if (sucess <= 0)
			return 0;
		return mainContents.getMainContentsKeyNum();
	}

	public MainContents getMainContentsOne(int mainContentsKeyNum) {
		return categoryDao.getMainContentsOne(mainContentsKeyNum);
	}

	public String delMainContents(int[] chkList) {
		for (int mainContentsKeyNum : chkList) {
			int sucess = categoryDao.delMainContents(mainContentsKeyNum);

			if (sucess <= 0)
				return "FALSE";
			categoryDao.delMainContentsComments(mainContentsKeyNum);
		}
		return "OK";
	}

	public String insertMainComments(MainComments mainComments) {
		int sucess = categoryDao.insertMainComments(mainComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public List<MainComments> getMainCommentsList(int mainContentsKeyNum, Principal principal) {
		String userId = "";
		try {
			userId = principal.getName();
		} catch (Exception e) {}
		int swap = 1;
		List<MainComments> mainCommentsList = categoryDao.getMainCommentsList(mainContentsKeyNum);
		for(int one=0; one<mainCommentsList.size(); one++) {
			for(int two=0; two<mainCommentsList.size(); two++) {
				if(mainCommentsList.get(one) != mainCommentsList.get(two)) {
					if(mainCommentsList.get(one).getMainCommentsKeyNum() == mainCommentsList.get(two).getMainCommentsParentKeyNum()) {
						mainCommentsList.add(one+swap, mainCommentsList.get(two));
						mainCommentsList.remove(two+1);
						swap++;
					}
				}
			}
			swap = 1;
		}
		
		int temp = 9999999;
		for(MainComments mainComments: mainCommentsList) {
			if(!userId.equals("admin")) {
				if(mainComments.isMainCommentsSecret()) {
					if(!userId.equals(mainComments.getMainCommentsRegistrant())) {
						if(mainComments.getMainCommentsParentKeyNum() != temp) {
							mainComments.setMainCommentsName("익명");
							mainComments.setMainCommentsContents("비밀 댓글 입니다.");
						}
					}
				}
			}
			if(userId.equals(mainComments.getMainCommentsRegistrant())) {
				temp = mainComments.getMainCommentsKeyNum();
			}
		}
		
		return mainCommentsList;
	}

	public MainComments getMainCommentsOne(int mainCommentsKeyNum) {
		return categoryDao.getMainCommentsOne(mainCommentsKeyNum);
	}

	public String insertMainCommentsReply(MainComments mainComments) {
		int sucess = categoryDao.insertMainCommentsReply(mainComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String mainCommentsDelete(MainComments mainComments, MainComments parentComment) {
		if(!mainComments.getMainCommentsPasswordDialog().equals(parentComment.getMainCommentsPassword())) {
			return "Inconsistency";
		}
		int sucess = categoryDao.mainCommentsDelete(parentComment.getMainCommentsKeyNum());
		if (sucess <= 0)
			return "FALSE";
		categoryDao.mainCommentsChildDelete(parentComment.getMainCommentsKeyNum());
		return "OK";
	}

	public String mainCommentsUpdateCheck(MainComments mainComments, MainComments parentComment) {
		if(!mainComments.getMainCommentsPasswordDialog().equals(parentComment.getMainCommentsPassword())) {
			return "Inconsistency";
		}
		return "OK";
	}

	public String mainCommentsUpdate(MainComments mainComments, MainComments parentComment) {
		mainComments.setMainCommentsKeyNum(parentComment.getMainCommentsKeyNum());
		int sucess = categoryDao.mainCommentsUpdate(mainComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public void countPlus(int mainContentsKeyNum) {
		categoryDao.countPlus(mainContentsKeyNum);
	}

	public int updateMainContents(MainContents mainContents, Principal principal) {
		int sucess = categoryDao.updateMainContents(mainContents);
		if (sucess <= 0)
			return 0;
		return mainContents.getMainContentsKeyNum();
	}

	public int beforePageMove(int mainContentsKeyNum) {
		MainContents mainContents = categoryDao.getMainContentsOne(mainContentsKeyNum);
		return categoryDao.beforePageMove(mainContents);
	}

	public int nextPageMove(int mainContentsKeyNum) {
		MainContents mainContents = categoryDao.getMainContentsOne(mainContentsKeyNum);
		return categoryDao.nextPageMove(mainContents);
	}

}
