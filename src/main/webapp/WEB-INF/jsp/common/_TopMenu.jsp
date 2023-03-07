<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function() {
	var arr =  $.cookie('name').split(",");
	
	if($.cookie('name') == 'index') {
		$('.index').addClass('active');
	} else if($.cookie('name') == 'adminSetting') {
		$('.adminSetting').addClass('active');
		$('.employee').addClass('activeSub');
		$('#adminSettingSubMenu').show();
	} else if($.cookie('name') == 'requestsWrite') {
		$('.inquiry').addClass('active');
		$('.requestsWrite').addClass('activeSub');
		$('#requestsSubMenu').show();
	} else if($.cookie('name') == 'requestsList') {
		$('.inquiry').addClass('active');
		$('.requestsList').addClass('activeSub');
		$('#requestsSubMenu').show();
	} else if($.cookie('name') == 'employee') {
		$('.adminSetting').addClass('active');
		$('.employee').addClass('activeSub');
		$('#adminSettingSubMenu').show();
	} else if($.cookie('name') == 'announcementWrite') {
		$('.adminSetting').addClass('active');
		$('.announcement').addClass('activeSub');
		$('#adminSettingSubMenu').show();
	} else if($.cookie('name') == 'categorySetting') {
		$('.adminSetting').addClass('active');
		$('.category').addClass('activeSub');
		$('#adminSettingSubMenu').show();
	} 
	
	if(arr.length == 2) {
		setTimeout(() => {
		$('#menu').show();
		$('.'+arr[0]).addClass('active');
		$('.'+arr[1]).addClass('activeSub');
		}, 100);
	}
	
});
</script>

<div style="width: 100%; height: 60px; background-color: #42855B; padding: 0px; overflow: hidden;">
	<a href="<c:url value='/pastQuestion'/>">
        <img src="<c:url value='/images/logo.png' />" style="float: left; width: 140px; margin-top: 15px; margin-right: 20px; margin-left: 20%;">
    </a>

    <a href="<c:url value='/index'/>" class="mainMenu index" id="index">HOME</a>
    <a href="#" class="mainMenu freeBoard" id="freeBoard">자유게시판</a>
    <sec:authorize access="hasAnyRole('ADMIN','MEMBER')">
    	<a href="<c:url value='/requestsWrite'/>" class="mainMenu inquiry" id="inquiry">문의하기</a>
    </sec:authorize>
    
    <sec:authorize access="hasRole('ADMIN')">
    	<a href="<c:url value='/employeeList'/>" class="mainMenu adminSetting" id="adminSetting">관리자설정</a>
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
    	<button class="btn btnPrimary btnBlock topMenuLogin" type="button" onClick="login();">로그인</button>
    </div>
</div>

<div id="menu" class="subMenu">
	<div style="height: 7px;"></div>
	<%-- <c:forEach var="middleItemsName" items="${middleItemsNameList}">
		<a href="<c:url value='/category/${topItemsName}/${middleItemsName}'/>" class="mediumMenu ${middleItemsName}" id="${middleItemsName}">${middleItemsName}</a>
	</c:forEach> --%>
</div>


<div id="requestsSubMenu" class="subMenu">
	<div style="height: 7px;"></div>
	<a href="<c:url value='/requestsWrite'/>" class="mediumMenu requestsWrite" id="requestsWrite">문의하기</a>
	<a href="<c:url value='/requestsList'/>" class="mediumMenu requestsList" id="requestsList">문의내역</a>
</div>

<div id="adminSettingSubMenu" class="subMenu">
	<div style="height: 7px;"></div>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="<c:url value='/employeeList'/>" class="mediumMenu employee" id="employee">회원 정보</a>
		<a href="<c:url value='/announcementWrite'/>" class="mediumMenu announcement" id="announcement">공지사항</a>
		<a href="<c:url value='/category/categorySetting'/>" class="mediumMenu category" id="category">메뉴설정</a>
	</sec:authorize>
</div>

<script>
	function kakaoLogout() {
		var usersId = $('#topMenuSpan').text();
		location.href="<c:url value='/kakaologout'/>?usersId="+usersId;
	};
	
	$(function() {
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/category/topItems'/>",
		    async: false,
		    success: function (data) {
		    	data.forEach(function(topItemsName){
		    		var rowItem = "<a href='<c:url value='/category/"+topItemsName+"'/>' class='mainMenu "+topItemsName+"' id='"+topItemsName+"'>"+topItemsName+"</a>";
				 	$('#index').after(rowItem);
		    	})
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
		
		var arr =  $.cookie('name').split(",");
		var topItemsName = arr[0];
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/category/middleItems'/>",
		    data: {"topItemsName":topItemsName},
		    async: false,
		    success: function (data) {
		    	data.forEach(function(middleItemsName){
		    		var rowItem = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenu "+middleItemsName+"' id='"+middleItemsName+"'>"+middleItemsName+"</a>";
				 	$('#menu').append(rowItem);
		    	})
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
		
		
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