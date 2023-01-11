<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
		$(function() {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '${msg}',    
			}).then((result) => {
				location.href="${pageContext.request.contextPath}${loc}";
			})
		})
	</script>
</head>
</html>