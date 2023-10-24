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
	    	$.cookie('name','myPage', { path: '/ITDeveloper'});
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<div style="margin: 2%; margin-left: 20%; margin-right: 20%; height: 700px;">
		<div class="myPageUpdateDiv">
			<div class="myPageUpdateLeft">
				<span class="myPageUpdateLeftSpan">이름</span>
			</div>
			<div class="myPageUpdateRight">
				<input class="formControl seachInput" type="text">
			</div>
		</div>
		<div class="myPageUpdateDiv">
			<div class="myPageUpdateLeft">
				<span class="myPageUpdateLeftSpan">이름</span>
			</div>
			<div class="myPageUpdateRight">
				<input class="formControl seachInput" type="text">
			</div>
		</div>





		<div style="width: 100%; margin-top: 3%; text-align: center;">
			<button class="btn btnBlue myPageUpdateBtn" type="submit">게시물 등록</button>
			<button class="btn btnRed myPageUpdateBtn" type="button" onClick="btnDelete();">게시물 삭제</button>
		</div>
		
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	
</script>

<style>
	.myPageUpdateDiv {
		border-top: 2px solid #e5e5e5; 
		height: 75px
	}

	.myPageUpdateLeft {
		width: 15%;	
		float: left; 
		margin-top: 15px; 
		margin-left: 2%;
	}

	.myPageUpdateRight {
		width: 83%; 
		float: left; 
		margin-top: 20px;
	}

	.myPageUpdateLeftSpan {
		color: black;	
		font-weight: bolder;
	}

	.myPageUpdateBtn {
		height: 40px;
    	width: 100px;
	}

	.seachInput {
		color: #555555;
	}
	
</style>
</html>