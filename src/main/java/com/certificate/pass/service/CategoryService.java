package com.certificate.pass.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.certificate.pass.dao.CategoryDao;
import com.certificate.pass.dao.EmployeeDao;
import com.certificate.pass.dao.UsersJpaDao;
import com.certificate.pass.vo.Category;
import com.certificate.pass.vo.ConnectUser;
import com.certificate.pass.vo.Employee;
import com.certificate.pass.vo.Favorites;
import com.certificate.pass.vo.MainComments;
import com.certificate.pass.vo.MainContents;
import com.certificate.pass.vo.Users;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CategoryService {
	@Autowired CategoryDao categoryDao;
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired EmployeeDao employeeDao;

	public List<String> topItems() {
		return categoryDao.topItems();
	}

	public List<String> middleItems(String topItemsName) {
		return categoryDao.middleItems(topItemsName);
	}

	public List<MainContents> getCategoryList(MainContents search) {
		return categoryDao.getCategoryList(search);
	}

	public int getCategoryListCount(MainContents search) {
		return categoryDao.getCategoryListCount(search);
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
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		mainContents.setMainContentsDate(formatter.format(now));
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
		if(mainComments.getMainCommentsRegistrant() == "" || mainComments.getMainCommentsRegistrant() == null) {
			if(mainComments.getMainCommentsName() == "" || mainComments.getMainCommentsName() == null) {
				return "NotName";
			}
			if(mainComments.getMainCommentsPassword() == "" || mainComments.getMainCommentsPassword() == null) {
				return "NotPwd";
			}
		} else {
			Optional<Users> users = usersJpaDao.findByUsersId(mainComments.getMainCommentsRegistrant());
			Employee employee = employeeDao.getEmployeeOne(mainComments.getMainCommentsRegistrant());
			mainComments.setMainCommentsName(employee.getEmployeeName());
			mainComments.setMainCommentsPassword(users.get().getUsersPw());
		}
		if(mainComments.getMainCommentsContents() == "") {
			return "NotContents";
		}
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
		if(mainComments.getMainCommentsRegistrant() == "" || mainComments.getMainCommentsRegistrant() == null) {
			if(mainComments.getMainCommentsNameDialog() == "" || mainComments.getMainCommentsNameDialog() == null) {
				return "NotName";
			}
			if(mainComments.getMainCommentsPasswordDialog() == "" || mainComments.getMainCommentsPasswordDialog() == null) {
				return "NotPwd";
			}
		} else {
			Optional<Users> users = usersJpaDao.findByUsersId(mainComments.getMainCommentsRegistrant());
			Employee employee = employeeDao.getEmployeeOne(mainComments.getMainCommentsRegistrant());
			mainComments.setMainCommentsNameDialog(employee.getEmployeeName());
			mainComments.setMainCommentsPasswordDialog(users.get().getUsersPw());
		}
		if(mainComments.getMainCommentsContentsDialog() == "") {
			return "NotContents";
		}
		int sucess = categoryDao.insertMainCommentsReply(mainComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String mainCommentsDelete(MainComments mainComments, MainComments parentComment, Principal principal) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		if(mainComments.getMainCommentsPasswordDialog() == "") 
			return "NotPwd";
		if(!passwordEncoder.matches(mainComments.getMainCommentsPasswordDialog(),parentComment.getMainCommentsPassword())) {
			if(!mainComments.getMainCommentsPasswordDialog().equals(parentComment.getMainCommentsPassword())) {
				return "Inconsistency";
			}
		}
		int sucess = categoryDao.mainCommentsDelete(parentComment.getMainCommentsKeyNum());
		if (sucess <= 0)
			return "FALSE";
		categoryDao.mainCommentsChildDelete(parentComment.getMainCommentsKeyNum());
		return "OK";
	}

	public String mainCommentsUpdateCheck(MainComments mainComments, MainComments parentComment,  Principal principal) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		if(mainComments.getMainCommentsPasswordDialog() == "") 
			return "NotPwd";
		try {
			Optional<Users> users = usersJpaDao.findByUsersId(principal.getName());
			if(passwordEncoder.matches(mainComments.getMainCommentsPasswordDialog(),users.get().getUsersPw())) {
				return "OK";
			}
		} catch (Exception e) {}
		if(!mainComments.getMainCommentsPasswordDialog().equals(parentComment.getMainCommentsPassword())) {
			return "Inconsistency";
		}
		return "OK";
	}

	public String mainCommentsUpdate(MainComments mainComments, MainComments parentComment) {
		mainComments.setMainCommentsKeyNum(parentComment.getMainCommentsKeyNum());
		int sucess;
		if(mainComments.getMainCommentsNameDialog() == "" || mainComments.getMainCommentsNameDialog() == null) 
			sucess = categoryDao.mainCommentsUpdateContents(mainComments);
		else 
			sucess = categoryDao.mainCommentsUpdate(mainComments);
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

	public int getFavoritesCount(int mainContentsKeyNum) {
		return categoryDao.getFavoritesCount(mainContentsKeyNum);
	}

	public void favoritesPlus(Favorites favorites) {
		categoryDao.favoritesPlus(favorites);
	}

	public void favoritesMinus(Favorites favorites) {
		categoryDao.favoritesMinus(favorites);
	}

	public boolean getFavoritesUsers(Favorites favorites) {
		int count = categoryDao.getFavoritesUsers(favorites);
		if(count > 0)
			return true;
		return false;
	}
	
	public String getIpAddress(HttpServletRequest req) {
		String ip = req.getHeader("X-Forwarded-For");
		if (ip == null) ip = req.getRemoteAddr();
		return ip;
	}

	public void insertConnectUser(ConnectUser connectUser) {
		categoryDao.insertConnectUser(connectUser);
	}

	public String validation(MainContents mainContents) {
		if(mainContents.getMainContentsTitle() == "" || mainContents.getMainContentsTitle() == null)
			return "NotTitle";
		if(mainContents.getMainContentsDetail() == "" || mainContents.getMainContentsDetail() == null)
			return "NotDatail";
		return "OK";
	}

}
