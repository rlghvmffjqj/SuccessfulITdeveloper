<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function() {
	if($.cookie('name') == 'index') {
		$('.index').addClass('active');
	} else if($.cookie('name') == 'pastQuestion') {
		$('.informationProcessing').addClass('active');
		$('.pastQuestion').addClass('activeSub');
		$('#informationProcessingSubMenu').show();
	} else if($.cookie('name') == 'pastQuestion') {
		$('.informationProcessing').addClass('active');
		$('.summary').addClass('activeSub');
	} else if($.cookie('name') == 'summary') {
		$('.informationProcessing').addClass('active');
		$('.summary').addClass('activeSub');
		$('#informationProcessingSubMenu').show();
	} else if($.cookie('name') == 'algorithm') {
		$('.informationProcessing').addClass('active');
		$('.algorithm').addClass('activeSub');
		$('#informationProcessingSubMenu').show();
	} else if($.cookie('name') == 'ingang') {
		$('.informationProcessing').addClass('active');
		$('.ingang').addClass('activeSub');
		$('#informationProcessingSubMenu').show();
	} else if($.cookie('name') == 'employee') {
		$('.employee').addClass('active');
	} else if($.cookie('name') == 'requestsWrite') {
		$('.inquiry').addClass('active');
		$('.requestsWrite').addClass('activeSub');
		$('#requestsSubMenu').show();
	} else if($.cookie('name') == 'requestsList') {
		$('.inquiry').addClass('active');
		$('.requestsList').addClass('activeSub');
		$('#requestsSubMenu').show();
	}
	
	
});
</script>

<div style="width: 100%; height: 60px; background-color: #42855B; padding: 0px; overflow: hidden;">
	<a href="<c:url value='/pastQuestion'/>">
        <img src="<c:url value='/images/logo.png' />" style="float: left; width: 140px; margin-top: 15px; margin-right: 20px; margin-left: 20%;">
    </a>

    <a href="<c:url value='/index'/>" class="mainMenu index" id="index">HOME</a>
    <a href="<c:url value='/informationProcessing/pastQuestion'/>" class="mainMenu informationProcessing" id="informationProcessing">정보처리기사 실기</a>
    <a href="#" class="mainMenu java" id="java">JAVA</a>
    <a href="#" class="mainMenu freeBoard" id="freeBoard">자유게시판</a>
    <a href="#" class="mainMenu announcement" id="announcement">공지사항</a>
    <sec:authorize access="hasAnyRole('ADMIN','MEMBER')">
    	<a href="<c:url value='/requestsWrite'/>" class="mainMenu inquiry" id="inquiry">문의하기</a>
    </sec:authorize>
    <sec:authorize access="hasRole('ADMIN')">
    	<a href="<c:url value='/employeeList'/>" class="mainMenu employee" id="employee">회원정보</a>
    </sec:authorize>
    
    <div id="member">
	    <a href="#!" style="float: right; margin-right: 20%;" id="topMendAShow">
	        <img style="border-radius: 50%; width: 35px; margin: 10px;" src="<c:url value='/images/profile.png' />">
	        <img style="float: right; width: 12px; margin-top: 23px;" src="<c:url value='/images/down.png' />">
	        <span id="topMenuSpan" style="float: right; color: white; font-size: 18px; margin: 14px;"><sec:authentication property="name"/></span>
	    </a>
	    <ul style="display: none; z-index: 1;" class="topMenuUl" id="topMendUlShow">
	    	<img style="width: 28px; margin: 10px; position: absolute; right: 44px; transform: translateY(-34px);" src="<c:url value='/images/triangle.png' />">
	        <li class="topMenuLi">
	            <a href="#" onclick="profileView()" class="topMenuA">
	                Profile
	            </a>
	        </li>
	        <li class="topMenuLi">
	            <a href="#" onclick="kakaoLogout()" class="topMenuA">
	                Logout
	            </a>
	        </li>
	    </ul>
    </div>
    <div id="noMember">
    	<button class="btn btn-primary btn-block topMenuLogin" type="button" onClick="login();">로그인</button>
    </div>
</div>
<div id="informationProcessingSubMenu" class="subMenu">
	<div style="height: 7px;"></div>
	<a href="<c:url value='/informationProcessing/pastQuestion'/>" class="mediumMenu pastQuestion" id="pastQuestion" style="margin-left: 29%;">기출문제</a>
	<a href="<c:url value='/informationProcessing/summary'/>" class="mediumMenu summary" id="summary">정리&요약</a>
	<a href="<c:url value='/informationProcessing/algorithm'/>" class="mediumMenu algorithm" id="algorithm">알고리즘</a>
	<a href="<c:url value='/informationProcessing/ingang'/>" class="mediumMenu ingang" id="ingang">인터넷강의</a>
</div>

<div id="requestsSubMenu" class="subMenu">
	<div style="height: 7px;"></div>
	<a href="<c:url value='/requestsWrite'/>" class="mediumMenu requestsWrite" id="requests" style="margin-left: 29%;">문의하기</a>
	<a href="<c:url value='/requestsList'/>" class="mediumMenu requestsList" id="requestsList">문의내역</a>
</div>

<script>
	function kakaoLogout() {
		var usersId = $('#topMenuSpan').text();
		location.href="<c:url value='/kakaologout'/>?usersId="+usersId;
	};
	
	$(function() {
		if($("#topMenuSpan").text() == "anonymousUser") {
			$("#member").hide();
			$("#noMember").show();
		} else {
			$("#noMember").hide();
			$("#member").show();
		}
	});
	
	$('#topMendAShow').click(function() {
		$('#member').show();
		$('#topMendUlShow').show();
	});
	
	document.addEventListener('mouseup', function(e) {
	    var container = document.getElementById('topMendUlShow');
	    if (!container.contains(e.target)) {
	        container.style.display = 'none';
	    }
	});
	
	function login() {
		location.href="<c:url value='/login'/>";
	}
</script>