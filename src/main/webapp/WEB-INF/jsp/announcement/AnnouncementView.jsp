<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>문의내역</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" method ="post">
			<div class="divBox" >
				<div class="announcementViewTitle">공지 내용</div>
				<div style="width:100%; margin-top: 20px; border-top: 5px solid #adadad; border-bottom: 5px solid #adadad; height: 130px; background: #F6F7F9;">
					<div class="announcementViewSubTitle"><span>제목</span></div>
					<div class="announcementViewSubDetail"><span class="width90">${announcement.announcementTitle}</span></div>
					<div class="announcementViewLine"></div>
					<div class="announcementViewSubTitle"><span>작성자</span></div>
					<div class="announcementViewSubDetail"><span class="width90">${announcement.announcementRegistrant}</span></div>
					<div class="announcementViewLine"></div>
					<div class="announcementViewSubTitle"><span>작성일</span></div>
					<div class="announcementViewSubDetail"><span class="width90">${announcement.announcementRegistrationDate}</span></div>
					<div class="announcementViewLine"></div>
					<div class="announcementViewSubTitle"><span>조회수</span></div>
					<div class="announcementViewSubDetail"><span class="width90">${announcement.announcementCount}</span></div>
				</div>
				<div style="width: 100%;">
					<article class="formControl seachInput" style="padding-top: 5px; width: 98%; margin-top: 10px; height:350px; border: 0;">${announcement.announcementDetail}</article>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
<script>
</script>
<style>
	.announcementViewLine {
		background:#cfcfcf; 
		width: 100%; 
		height:1px; 
		float: left;
	}
	
	.announcementViewTitle {
		width: 100%;
	    height: 35px;
	    text-align: center;
	    padding-top: 10px;
	    background: #adadad;
	    color: black;
	    font-weight: bold;
	    font-size: 20px;
	}
	
	.announcementViewSubTitle {
		margin:5px; 
		float: left; 
		width:10%
	}
	
	.announcementViewSubDetail {
		margin:5px; 
		float: left; 
		margin-left: 10%;
	}
	
	.announcementViewAnswer {
	    padding-top: 15px;
	    padding-bottom: 15px;
	    width: 100%;
	    height: 100%;
	}

</style>
</html>