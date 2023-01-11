<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>정보처리기사 실기 기출문제</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','pastQuestion');
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div style="float: left; margin: 1%; width: 59%;">
		<p style="font-size:14px; font-weight: bold; color: #333333;">
			<span style="color: red;">안녕하세요. 성공한 IT 개발자 방문해 주셔서 감사합니다.</span><br><br>
			해당 웹 사이트의 경우 개인적인 공부를 정리한 웹 사이트이며 방문해주신 분들께도 도움이 되었으면 하는 바램이 있습니다.<br><br>
			잘못된 정보나 개선 사항이 있을경우 문의하기를 통해 언제든 문의 바랍니다. 감사합니다.<br><br>
		</p>
		
		<p style="font-weight: bold; font-size: 15px; color: seagreen;">※ 시험일정</p>
		<img src="<c:url value='/images/InformationProcessingSchedule.png' />" style="width: 60%; border: 1px solid red; margin-left: 20px;"><br><br>
		
		<p style="font-weight: bold; font-size: 15px; color: seagreen;">※ 수수료</p>
		<img src="<c:url value='/images/InformationProcessingFee.png' />" style="width: 20%; border: 1px solid red; margin-left: 20px;"><br><br>
		
		<p style="font-weight: bold; font-size: 15px; color: seagreen;">※ 원서접수</p>
		<a href="https://www.q-net.or.kr/rcv002.do?id=rcv00201&gSite=Q&gId=" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">Q-Net 정보처리 기사 원서 접수</a><br><br>
		
		<p style="font-weight: bold; font-size: 15px; color: seagreen;">※ 기출문제</p>
		<p style="line-height: 200%;">
			<a href="<c:url value='/informationProcessing/pastQuestion/20223'/>" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2022년 3회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2022년 2회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2022년 1회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2021년 3회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2021년 2회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2021년 1회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2020년 3회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2020년 2회 정보처리기사 실기 기출문제</a><br>
			<a href="#" target="_blank" style="margin-left: 20px; font-size: 15px; color: dodgerblue; border-bottom: 1px solid; font-weight: bolder;">2020년 1회 정보처리기사 실기 기출문제</a><br>
		</p>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
</html>