package com.certificate.pass.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.certificate.pass.vo.Category;
import com.certificate.pass.vo.MainComments;
import com.certificate.pass.vo.MainContents;

@Repository
public class CategoryDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public List<String> topItems() {
		return sqlSession.selectList("category.topItems");
	}

	public List<String> middleItems(String topItemsName) {
		return sqlSession.selectList("category.middleItems",topItemsName);
	}

	public List<MainContents> getCategoryList(MainContents search) {
		return sqlSession.selectList("category.getCategoryList", search);
	}

	public List<String> getTopMenuCategoryList() {
		return sqlSession.selectList("category.getTopMenuCategoryList");
	}

	public List<Category> getMiddleMenuCategoryList() {
		return sqlSession.selectList("category.getMiddleMenuCategoryList");
	}

	public List<String> getMiddleTopNameList() {
		return sqlSession.selectList("category.getMiddleTopNameList");
	}

	public int insertTopItems(Category category) {
		return sqlSession.insert("category.insertTopItems",category);
	}

	public int insertMiddleItems(Category category) {
		return sqlSession.insert("category.insertMiddleItems",category);
	}

	public void deleteTopItems() {
		sqlSession.delete("category.deleteTopItems");
	}

	public void deleteMiddleItems() {
		sqlSession.delete("category.deleteMiddleItems");
		
	}

	public int insertMainContents(MainContents mainContents) {
		return sqlSession.insert("category.insertMainContents",mainContents);
	}

	public MainContents getMainContentsOne(int mainContentsKeyNum) {
		return sqlSession.selectOne("category.getMainContentsOne",mainContentsKeyNum);
	}

	public int delMainContents(int mainContentsKeyNum) {
		return sqlSession.delete("category.delMainContents",mainContentsKeyNum);
	}

	public int insertMainComments(MainComments mainComments) {
		return sqlSession.insert("category.insertMainComments",mainComments);
	}

	public List<MainComments> getMainCommentsList(int mainContentsKeyNum) {
		return sqlSession.selectList("category.getMainCommentsList",mainContentsKeyNum);
	}

	public MainComments getMainCommentsOne(int mainCommentsKeyNum) {
		return sqlSession.selectOne("category.getMainCommentsOne",mainCommentsKeyNum);
	}

	public int insertMainCommentsReply(MainComments mainComments) {
		return sqlSession.insert("category.insertMainCommentsReply",mainComments);
	}

	public int mainCommentsDelete(Integer mainCommentsKeyNum) {
		return sqlSession.delete("category.mainCommentsDelete",mainCommentsKeyNum);
	}

	public int mainCommentsUpdate(MainComments mainComments) {
		return sqlSession.update("category.mainCommentsUpdate",mainComments);
	}

	public void mainCommentsChildDelete(Integer mainCommentsKeyNum) {
		sqlSession.delete("category.mainCommentsChildDelete",mainCommentsKeyNum);
	}

	public void delMainContentsComments(int mainContentsKeyNum) {
		sqlSession.delete("category.delMainContentsComments",mainContentsKeyNum);
	}

	public void countPlus(int mainContentsKeyNum) {
		sqlSession.update("category.countPlus",mainContentsKeyNum);
	}

	public int updateMainContents(MainContents mainContents) {
		return sqlSession.update("category.updateMainContents",mainContents);
	}

	public int beforePageMove(MainContents mainContents) {
		return sqlSession.selectOne("category.beforePageMove",mainContents);
	}

	public int nextPageMove(MainContents mainContents) {
		return sqlSession.selectOne("category.nextPageMove",mainContents);
	}

	public int getCategoryListCount(MainContents search) {
		return sqlSession.selectOne("category.getCategoryListCount",search);
	}

	public int getFavoritesCount(MainContents mainContents) {
		return sqlSession.selectOne("category.getFavoritesCount",mainContents);
	}
}
