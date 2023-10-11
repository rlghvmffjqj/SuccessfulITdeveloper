<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="google-site-verification" content="xIWfFJYp6uIejvm5HdDdwyVmWPR5pIbvKzCW11YVaQA" />
	<title>IT Developer</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','index', { path: '/ITDeveloper'});
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div>
		<div id="index_main_title" style="height: 160px; width: 100%; border-bottom: 3px solid #76AA9D; background: #f2ffee;">
			<div style="padding-top: 15px; padding-left: 25%; font-family: math;">
				<span class="index_lesson">공부하지 않으면 걱정만 불어나고,</span>
			</div>
			<div style="padding-top: 5px; padding-left: 40%; font-family: math;">
				<span class="index_lesson">실천하지 않으면 발전하지 않는다.</span>
			</div>
		</div>
		<div id="index_list" style="height: auto; width: 100%; text-align: center; margin-top: 1%;">
			<div style="margin: 20px;">
				<a class="index_list">전체 글 (${mainContentsCount})</a>
			</div>

			<c:forEach var='mainContents' items='${mainContentsList}'>
				<div class="index_div">
					<a class="index_link" href="<c:url value='/category/mainContentsView?contentNumber=${mainContents.mainContentsKeyNum}'/>">
						<strong class="index_title">${mainContents.mainContentsTitle}</strong>
						<p class="index_txt">${mainContents.mainContentsDetail}</p>
					</a>
					<a href="<c:url value='/category/${mainContents.topItemsName}/${mainContents.middleItemsName}'/>" class="index_link">${mainContents.middleItemsName}</a>
					<span class="index_bar">${mainContents.mainContentsDate}</span>
				</div>
			</c:forEach>
			<div>
				<c:choose>
					<c:when test="${page > 1}">
						<a href="/ITDeveloper/index?page=${page - 1}&size=${size}">Previous</a>
					</c:when>
					<c:otherwise>
						<span>Previous</span>
					</c:otherwise>
				</c:choose>
				
				<span>|</span>
				
				<c:choose>
					<c:when test="${not empty mainContentsList && mainContentsList.size() == size}">
						<a href="/ITDeveloper/index?page=${page + 1}&size=${size}">Next</a>
					</c:when>
					<c:otherwise>
						<span>Next</span>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	
</script>

<style>
	.index_link:hover .index_title {
		text-decoration: underline;
    	color: #3db39e;
	}

	.index_link {
		font-size: 12px;
    	text-decoration: none;
    	color: #3db39e;
	}

	.index_bar {
		display: inline-block;
    	width: 140px;
    	font-size: 12px;
    	margin: 0 5px;
	}
</style>
</html>