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
		<div style="height: 160px; width: 100%; border-bottom: 3px solid #76AA9D; background: #f2ffee;">
			<div style="padding-top: 15px; padding-left: 25%; font-family: math;">
				<h3>공부하지 않으면 걱정만 늘어나고,</h3>
			</div>
			<div style="padding-top: 5px; padding-left: 40%; font-family: math;">
				<h3>실천하지 않으면 변하지 않는다.</h3>
			</div>
		</div>
		<div style="height: 500px; width: 100%;">
			
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
</html>