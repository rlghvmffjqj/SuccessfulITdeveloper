package com.certificate.pass.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.certificate.pass.dao.FreeBoardDao;
import com.certificate.pass.emtity.EmployeeEntity;
import com.certificate.pass.emtity.UsersEntity;
import com.certificate.pass.jpaDao.EmployeeJpaDao;
import com.certificate.pass.jpaDao.UsersJpaDao;
import com.certificate.pass.vo.FreeBoard;
import com.certificate.pass.vo.FreeBoardComments;

@Service
public class FreeBoardService {
	@Autowired FreeBoardDao freeBoardDao;
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired EmployeeJpaDao employeeJpaDao;

	public List<FreeBoard> getFreeBoardList(FreeBoard search) {
		return freeBoardDao.getFreeBoardList(search);
	}

	public int getFreeBoardListCount(FreeBoard search) {
		return freeBoardDao.getFreeBoardListCount(search);
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public int insertFreeBoard(FreeBoard freeBoard) {
		int sucess = freeBoardDao.insertFreeBoard(freeBoard);
		if (sucess <= 0)
			return 0;
		return freeBoard.getFreeBoardKeyNum();
	}

	public FreeBoard getFreeBoardOne(int freeBoardKeyNum) {
		return freeBoardDao.getFreeBoardOne(freeBoardKeyNum);
	}

	public List<FreeBoardComments> getFreeBoardComments(int freeBoardCommentsKeyNum, Principal principal) {
		String userId = "";
		try {
			userId = principal.getName();
		} catch (Exception e) {}
		int swap = 1;
		List<FreeBoardComments> freeBoardCommentList = freeBoardDao.getFreeBoardCommentsList(freeBoardCommentsKeyNum);
		for(int one=0; one<freeBoardCommentList.size(); one++) {
			for(int two=0; two<freeBoardCommentList.size(); two++) {
				if(freeBoardCommentList.get(one) != freeBoardCommentList.get(two)) {
					if(freeBoardCommentList.get(one).getFreeBoardCommentsKeyNum() == freeBoardCommentList.get(two).getFreeBoardCommentsParentKeyNum()) {
						freeBoardCommentList.add(one+swap, freeBoardCommentList.get(two));
						freeBoardCommentList.remove(two+1);
						swap++;
					}
				}
			}
			swap = 1;
		}
		
		int temp = 9999999;
		for(FreeBoardComments freeBoardComment: freeBoardCommentList) {
			if(!userId.equals("admin")) {
				if(freeBoardComment.isFreeBoardCommentsSecret()) {
					if(!userId.equals(freeBoardComment.getFreeBoardCommentsRegistrant())) {
						if(freeBoardComment.getFreeBoardCommentsParentKeyNum() != temp) {
							freeBoardComment.setFreeBoardCommentsName("�씡紐�");
							freeBoardComment.setFreeBoardCommentsContents("鍮꾨� �뙎湲� �엯�땲�떎.");
						}
					}
				}
			}
			if(userId.equals(freeBoardComment.getFreeBoardCommentsRegistrant())) {
				temp = freeBoardComment.getFreeBoardCommentsKeyNum();
			}
		}
		
		return freeBoardCommentList;
	}

	public String insertFreeBoardComments(FreeBoardComments freeBoardComments) {
		if(freeBoardComments.getFreeBoardCommentsRegistrant() == "" || freeBoardComments.getFreeBoardCommentsRegistrant() == null) {
			if(freeBoardComments.getFreeBoardCommentsName() == "" || freeBoardComments.getFreeBoardCommentsName() == null) {
				return "NotName";
			}
			if(freeBoardComments.getFreeBoardCommentsPassword() == "" || freeBoardComments.getFreeBoardCommentsPassword() == null) {
				return "NotPwd";
			}
		} else {
			UsersEntity users = usersJpaDao.findByUsersId(freeBoardComments.getFreeBoardCommentsRegistrant());
			EmployeeEntity employeeEntity = employeeJpaDao.findByEmployeeId(freeBoardComments.getFreeBoardCommentsRegistrant());
			freeBoardComments.setFreeBoardCommentsName(employeeEntity.getEmployeeName());
			freeBoardComments.setFreeBoardCommentsPassword(users.getUsersPw());
		}
		int sucess = freeBoardDao.insertFreeBoardComments(freeBoardComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public FreeBoardComments getFreeBoardCommentsOne(Integer freeBoardCommentsKeyNum) {
		return freeBoardDao.getFreeBoardCommentsOne(freeBoardCommentsKeyNum);
	}

	public String insertFreeBoardCommentsReply(FreeBoardComments freeBoardComments) {
		if(freeBoardComments.getFreeBoardCommentsRegistrant() == "" || freeBoardComments.getFreeBoardCommentsRegistrant() == null) {
			if(freeBoardComments.getFreeBoardCommentsNameDialog() == "" || freeBoardComments.getFreeBoardCommentsNameDialog() == null) {
				return "NotName";
			}
			if(freeBoardComments.getFreeBoardCommentsPasswordDialog() == "" || freeBoardComments.getFreeBoardCommentsPasswordDialog() == null) {
				return "NotPwd";
			}
		} else {
			UsersEntity users = usersJpaDao.findByUsersId(freeBoardComments.getFreeBoardCommentsRegistrant());
			EmployeeEntity employeeEntity = employeeJpaDao.findByEmployeeId(freeBoardComments.getFreeBoardCommentsRegistrant());
			freeBoardComments.setFreeBoardCommentsNameDialog(employeeEntity.getEmployeeName());
			freeBoardComments.setFreeBoardCommentsPasswordDialog(users.getUsersPw());
		}
		if(freeBoardComments.getFreeBoardCommentsContentsDialog() == "") {
			return "NotContents";
		}
		int sucess = freeBoardDao.insertFreeBoardCommentsReply(freeBoardComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String freeBoardCommentsDelete(FreeBoardComments freeBoardComments, FreeBoardComments parentComment) {
		if(!freeBoardComments.getFreeBoardCommentsPasswordDialog().equals(parentComment.getFreeBoardCommentsPassword())) {
			return "Inconsistency";
		}
		int sucess = freeBoardDao.freeBoardCommentsDelete(parentComment.getFreeBoardCommentsKeyNum());
		if (sucess <= 0)
			return "FALSE";
		freeBoardDao.freeBoardCommentsChildDelete(parentComment.getFreeBoardCommentsKeyNum());
		return "OK";
	}

	public String freeBoardCommentsUpdateCheck(FreeBoardComments freeBoardComments, FreeBoardComments parentComment) {
		if(!freeBoardComments.getFreeBoardCommentsPasswordDialog().equals(parentComment.getFreeBoardCommentsPassword())) {
			return "Inconsistency";
		}
		return "OK";
	}

	public String freeBoardCommentsUpdate(FreeBoardComments freeBoardComments, FreeBoardComments parentComment) {
		freeBoardComments.setFreeBoardCommentsKeyNum(parentComment.getFreeBoardCommentsKeyNum());
		int sucess = freeBoardDao.freeBoardCommentsUpdate(freeBoardComments);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String freeBoardDelete(int freeBoardKeyNum) {
		int sucess = freeBoardDao.freeBoardDelete(freeBoardKeyNum);

		if (sucess <= 0)
			return "FALSE";
		freeBoardDao.freeBoardContentsCommentsDelete(freeBoardKeyNum);
		return "OK";
	}

	public int updateFreeBoard(FreeBoard freeBoard, Principal principal) {
		int sucess = freeBoardDao.updateFreeBoard(freeBoard);
		if (sucess <= 0)
			return 0;
		return freeBoard.getFreeBoardKeyNum();
	}

	public void countPlus(int freeBoardKeyNum) {
		freeBoardDao.countPlus(freeBoardKeyNum);
	}

}
