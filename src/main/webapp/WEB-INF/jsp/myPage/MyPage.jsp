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
	<div class="mypageContainer">
		<div style="border: 3px solid #E9E9E9; width: 100%; height: 170px;">
			<div style="display: flex; align-items: center;	height: 170px; margin-left: 1%;">
				<div style="width: 50%;">
					<span style="display: contents; color:gray;">김기호님의</span><br>
					<span style="display: contents; color: black; font-weight: bold; font-size: 18px;">방문을 환영합니다.</span><br><br>
					<span style="display: contents; color:gray;">댓글 참여 : 5</span><br>
					<span style="display: contents; color:gray;">자유게시판 참여 : 5</span><br>
					<span style="display: contents; color:gray;">문의하기 : 5</span>
				</div>
				<div style="width: 50%;">
					<button class="btnBlue employeeUpdateBtn" onclick="employeeUpdate()">회원정보 수정</button>
				</div>
			</div>
			<div style="margin-top: 2%;">
				<div style="border-bottom: 1px solid #999999; padding-bottom: 1%;">
					<span>MY 댓글</span>
				</div>
			</div>
			<div style="margin-top: 2%;">
				<div style="border-bottom: 1px solid #999999; padding-bottom: 1%;">
					<span>MY 자유게시판</span>
				</div>
			</div>
			<div style="margin-top: 2%;">
				<div style="border-bottom: 1px solid #999999; padding-bottom: 1%;">
					<span>MY 문의하기</span>
				</div>
			</div>
			<div style="margin-top: 2%;">
				<div style="border-bottom: 1px solid #999999; padding-bottom: 1%;">
					<span>New 답글</span>
				</div>
			</div>
			
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	function employeeUpdate() {
		location.href = "<c:url value='/myPage/employeeUpdateView'/>";
	}
</script>

<style>
	span {
		font-family: none;
		color: black;
	}

</style>
</html>