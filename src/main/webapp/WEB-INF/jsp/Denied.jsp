<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<title>접근 거부</title>
</head>
<body>
<div class="error-404">
    <div class="container-fluid">
        <div class="row" style="text-align: center; display: inline;">
            <div class="text-uppercase col-xs-12">
                <h1>접근 거부</h1>
                <h5>No Access</h5>
                <p>oops! No Access</p>
                <a href="/AgentInfo/login" class="btn btn-error btn-lg waves-effect">back to home page</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>