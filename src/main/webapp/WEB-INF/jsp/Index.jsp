<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="google-site-verification" content="xIWfFJYp6uIejvm5HdDdwyVmWPR5pIbvKzCW11YVaQA" />
	<title>ITDeveloper</title>
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
		
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
</html>