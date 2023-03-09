package com.certificate.pass.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.FreeBoard;
import com.certificate.pass.vo.FreeBoardComments;

@Repository
public class FreeBoardDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<FreeBoard> getFreeBoardList(FreeBoard search) {
		return sqlSession.selectList("freeBoard.getFreeBoardList", search);
	}

	public int getFreeBoardListCount(FreeBoard search) {
		return sqlSession.selectOne("freeBoard.getFreeBoardListCount",search);
	}

	public int insertFreeBoard(FreeBoard freeBoard) {
		return sqlSession.insert("freeBoard.insertFreeBoard", freeBoard);
	}

	public FreeBoard getFreeBoardOne(int freeBoardKeyNum) {
		return sqlSession.selectOne("freeBoard.getFreeBoardOne", freeBoardKeyNum);
	}

	public List<FreeBoardComments> getFreeBoardCommentsList(int freeBoardCommentsKeyNum) {
		return sqlSession.selectList("freeBoard.getFreeBoardCommentsList",freeBoardCommentsKeyNum);
	}

	public int insertFreeBoardComments(FreeBoardComments freeBoardComments) {
		return sqlSession.insert("freeBoard.insertFreeBoardComments",freeBoardComments);
	}

	public FreeBoardComments getFreeBoardCommentsOne(Integer freeBoardCommentsKeyNum) {
		return sqlSession.selectOne("freeBoard.getFreeBoardCommentsOne",freeBoardCommentsKeyNum);
	}

	public int insertFreeBoardCommentsReply(FreeBoardComments freeBoardComments) {
		return sqlSession.insert("freeBoard.insertFreeBoardCommentsReply",freeBoardComments);
	}

	public int freeBoardCommentsDelete(Integer freeBoardCommentsKeyNum) {
		return sqlSession.delete("freeBoard.freeBoardCommentsDelete",freeBoardCommentsKeyNum);
	}

	public void freeBoardCommentsChildDelete(Integer freeBoardCommentsKeyNum) {
		sqlSession.delete("freeBoard.freeBoardCommentsChildDelete",freeBoardCommentsKeyNum);
		
	}

	public int freeBoardCommentsUpdate(FreeBoardComments freeBoardComments) {
		return sqlSession.update("freeBoard.freeBoardCommentsUpdate",freeBoardComments);
	}

	public int freeBoardDelete(int freeBoardKeyNum) {
		return sqlSession.delete("freeBoard.freeBoardDelete",freeBoardKeyNum);
	}

	public void freeBoardContentsCommentsDelete(int freeBoardKeyNum) {
		sqlSession.delete("freeBoard.freeBoardContentsCommentsDelete",freeBoardKeyNum);
	}

	public int updateFreeBoard(FreeBoard freeBoard) {
		return sqlSession.update("freeBoard.updateFreeBoard",freeBoard);
	}

	public void countPlus(int freeBoardKeyNum) {
		sqlSession.update("freeBoard.countPlus",freeBoardKeyNum);
		
	}

}
