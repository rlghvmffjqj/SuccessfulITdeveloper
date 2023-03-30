<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function() {
	var arr =  $.cookie('name').split(",");
	$('.subMenuMobile').hide();
	
	if($.cookie('name') == 'index') {
		$('.index').addClass('active');
		$('.indexMobile').addClass('activeMobile');
	} else if($.cookie('name') == 'adminSetting') {
		$('.adminSetting').addClass('active');
		$('.adminSettingMobile').addClass('activeMobile');
		$('.employee').addClass('activeSub');
		$('.employeeMobile').addClass('activeSubMobile');
		$('#adminSettingSubMenu').show();
		$('#adminSettingSubMenuMobile').show();
	} else if($.cookie('name') == 'requestsWrite') {
		$('.inquiry').addClass('active');
		$('.inquiryMobile').addClass('activeMobile');
		$('.requestsWrite').addClass('activeSub');
		$('.requestsWriteMobile').addClass('activeSubMobile');
		$('#requestsSubMenu').show();
		$('#requestsSubMenuMobile').show();
	} else if($.cookie('name') == 'requestsList') {
		$('.inquiry').addClass('active');
		$('.inquiryMobile').addClass('activeMobile');
		$('.requestsList').addClass('activeSub');
		$('.requestsListMobile').addClass('activeSubMobile');
		$('#requestsSubMenu').show();
		$('#requestsSubMenuMobile').show();
	} else if($.cookie('name') == 'employee') {
		$('.adminSetting').addClass('active');
		$('.adminSettingMobile').addClass('activeMobile');
		$('.employee').addClass('activeSub');
		$('.employeeMobile').addClass('activeSubMobile');
		$('#adminSettingSubMenu').show();
		$('#adminSettingSubMenuMobile').show();
	} else if($.cookie('name') == 'announcementWrite') {
		$('.adminSetting').addClass('active');
		$('.adminSettingMobile').addClass('activeMobile');
		$('.announcement').addClass('activeSub');
		$('.announcementMobile').addClass('activeSubMobile');
		$('#adminSettingSubMenu').show();
		$('#adminSettingSubMenuMobile').show();
	} else if($.cookie('name') == 'categorySetting') {
		$('.adminSetting').addClass('active');
		$('.adminSettingMobile').addClass('activeMobile');
		$('.category').addClass('activeSub');
		$('.categoryMobile').addClass('activeSubMobile');
		$('#adminSettingSubMenu').show();
		$('#adminSettingSubMenuMobile').show();
	} else if($.cookie('name') == 'freeBoardList') {
		$('.freeBoard').addClass('active');
		$('.freeBoardMobile').addClass('activeMobile');
	} else if($.cookie('name') == 'integratedList') {
		$('.integrated').addClass('active');
		$('.integratedMobile').addClass('activeMobile');
	} else {
		$('#categorySubMenuMobile').show();
	}
	
	if(arr.length == 2) {
		setTimeout(() => {
			$('#menu').show();
			$('.'+arr[0]).addClass('active');
			$('.'+arr[0]+'Mobile').addClass('activeMobile');
			if(arr[0] == arr[1]) {
				$('.'+arr[1]+"Same").addClass('activeSub');
				$('.'+arr[1]+"SameMobile").addClass('activeSub');
			} else {
				$('.'+arr[1]).addClass('activeSub');
				$('.'+arr[1]+'Mobile').addClass('activeSubMobile');
			}
		}, 100);
	}
	
});
</script>

<div style="width: 100%; height: 60px; background-color: #42855B; padding: 0px; overflow: hidden;">
	<a href="<c:url value='/index'/>">
        <img src="<c:url value='/images/logo.png' />" class="mainLogo">
    </a>
    <a onClick="mobileSubMenuBtn()">
    	<img class="mobileMenu" src="<c:url value='/images/menu.png' />">
    </a>
	<div class="mainMenuDiv">
	    <a href="<c:url value='/index'/>" class="mainMenu index" id="index">HOME</a>
	    <a href="<c:url value='/integrated/integratedList'/>" class="mainMenu integrated" id="integrated">통합검색</a>
	    <a href="<c:url value='/freeBoard/freeBoardList'/>" class="mainMenu freeBoard" id="freeBoard">자유게시판</a>
	    <sec:authorize access="hasAnyRole('ADMIN','MEMBER')">
	    	<a href="<c:url value='/requestsWrite'/>" class="mainMenu inquiry" id="inquiry">문의하기</a>
	    </sec:authorize>
	    
	    <sec:authorize access="hasRole('ADMIN')">
	    	<a href="<c:url value='/employeeList'/>" class="mainMenu adminSetting" id="adminSetting">관리자설정</a>
	    </sec:authorize>
    </div>
    
    <sec:authorize access="isAuthenticated()">
	    <div id="member">
		    <a href="#!" style="float: right; margin-right: 2%;" id="topMendAShow">
		        <img class="profile" style="border-radius: 50%; width: 35px; margin: 10px;" src="<c:url value='/images/profile.png' />">
		        <img class="logoutProfile" src="<c:url value='/images/down.png' />">
		        <span id="topMenuSpan" class="loginId"><sec:authentication property="name"/></span>
		    </a>
		    <ul style="display: none; z-index: 1;" class="topMenuUl" id="topMendUlShow">
		    	<img class="profileTriggle" src="<c:url value='/images/triangle.png' />">
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
    </sec:authorize>
    <sec:authorize access="isAnonymous()">
	    <div id="noMember">
	    	<button class="btnPrimary btnBlock topMenuLogin" type="button" onClick="login();">로그인</button>
	    </div>
    </sec:authorize>
</div>

<div id="menu" class="subMenu">
	<div style="width: 28%; float: left; height: 1px;"></div>
</div>


<div id="requestsSubMenu" class="subMenu">
	<div style="width: 28%; float: left; height: 1px;"></div>
	<a href="<c:url value='/requestsWrite'/>" class="mediumMenu requestsWrite" id="requestsWrite">문의하기</a>
	<a href="<c:url value='/requestsList'/>" class="mediumMenu requestsList" id="requestsList">문의내역</a>
</div>

<div id="adminSettingSubMenu" class="subMenu">
	<div style="width: 28%; float: left; height: 1px;"></div>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="<c:url value='/employeeList'/>" class="mediumMenu employee" id="employee">회원 정보</a>
		<a href="<c:url value='/announcementWrite'/>" class="mediumMenu announcement" id="announcement">공지사항</a>
		<a href="<c:url value='/category/categorySetting'/>" class="mediumMenu category" id="category">메뉴설정</a>
	</sec:authorize>
</div>

<div class="mobileSubMenu" id="mobileSubMenu" style="display:none">
	<div style="width:100%; height:60px; float:left; background: #ddd;">
		<div style="float: left; margin-top: 17px; margin-left: 2%;"><span style="font-size: 20px; font-weight: 600;">전체메뉴</span></div>
		<a onClick="mobileSubMenuBtn()"><img style="width:20px; float: right; margin-top: 20px; margin-right: 2%;" src="<c:url value='/images/close.png' />"></a>
	</div>
	<div style="width:35%; height:100%; float:left; border-right: 1px solid #ddd">
		<a href="<c:url value='/index'/>" class="mainMenuMobile indexMobile" id="indexMobile">HOME</a>
	    <a href="<c:url value='/integrated/integratedList'/>" class="mainMenuMobile integratedMobile" id="integratedMobile">통합검색</a>
	    <a href="<c:url value='/freeBoard/freeBoardList'/>" class="mainMenuMobile freeBoardMobile" id="freeBoardMobile">자유게시판</a>
	    <sec:authorize access="hasAnyRole('ADMIN','MEMBER')">
	    	<a href="#!" onClick="inquiry();" class="mainMenuMobile inquiryMobile" id="inquiryMobile">문의하기</a>
	    </sec:authorize>
	    
	    <sec:authorize access="hasRole('ADMIN')">
	    	<a href="#!" onClick="adminSetting();" class="mainMenuMobile adminSettingMobile" id="adminSettingMobile">관리자설정</a>
	    </sec:authorize>
	</div>
	<div id="menuMobile" style="width:64%; height:100%; float:left;">
		<div id="requestsSubMenuMobile" class="subMenuMobile">
			<div style="width: 28%; float: left; height: 1px;"></div>
			<a href="<c:url value='/requestsWrite'/>" class="mediumMenuMobile requestsWriteMobile" id="requestsWriteMobile">문의하기</a>
			<a href="<c:url value='/requestsList'/>" class="mediumMenuMobile requestsListMobile" id="requestsListMobile">문의내역</a>
		</div>
		
		<div id="adminSettingSubMenuMobile" class="subMenuMobile">
			<div style="width: 28%; float: left; height: 1px;"></div>
			<sec:authorize access="hasRole('ADMIN')">
				<a href="<c:url value='/employeeList'/>" class="mediumMenuMobile employeeMobile" id="employeeMobile">회원 정보</a>
				<a href="<c:url value='/announcementWrite'/>" class="mediumMenuMobile announcementMobile" id="announcementMobile">공지사항</a>
				<a href="<c:url value='/category/categorySetting'/>" class="mediumMenuMobile categoryMobile" id="categoryMobile">메뉴설정</a>
			</sec:authorize>
		</div>
		
		<div id="categorySubMenuMobile" class="subMenuMobile">
		</div>
	</div>
</div>

<script>
	function adminSetting() {
		$('.subMenuMobile').css('display','none');
		$('#adminSettingSubMenuMobile').css('display','block');
		$('.mainMenuMobile').removeClass('activeMobile');
		$("#adminSettingMobile").addClass('activeMobile');
	}
	
	function inquiry() {
		$('.subMenuMobile').css('display','none');
		$('#requestsSubMenuMobile').css('display','block');
		$('.mainMenuMobile').removeClass('activeMobile');
		$("#inquiryMobile").addClass('activeMobile');
	}
	
	function category(topItemsName) {
		var topItemsName = topItemsName.text;
		$('.mainMenuMobile').removeClass('activeMobile');
		$("#"+topItemsName+"Mobile").addClass('activeMobile');
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/category/middleItems'/>",
		    data: {"topItemsName":topItemsName},
		    async: false,
		    success: function (data) {
		    	$('.mediumMenuMobile ').remove();
		    	data.forEach(function(middleItemsName){
		    		if(topItemsName == middleItemsName) {
		    			var rowItemMobile = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenuMobile "+middleItemsName+"SameMobile' id='"+middleItemsName+"Mobile'>"+middleItemsName+"</a>";
		    		} else {
		    			var rowItemMobile = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenuMobile "+middleItemsName+"Mobile' id='"+middleItemsName+"Mobile'>"+middleItemsName+"</a>";
		    		}
				 	$('#categorySubMenuMobile').append(rowItemMobile);
				 	$('.subMenuMobile').css('display','none');
				 	$('#categorySubMenuMobile').css('display','block');
		    	})
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	}

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
		    		var rowItemMobile = "<a href='#!' onClick='category("+topItemsName+");' class='mainMenuMobile "+topItemsName+"Mobile' id='"+topItemsName+"Mobile'>"+topItemsName+"</a>";
				 	$('#index').after(rowItem);
				 	$('#indexMobile').after(rowItemMobile);
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
		    		if(topItemsName == middleItemsName) {
		    			var rowItem = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenu "+middleItemsName+"Same' id='"+middleItemsName+"'>"+middleItemsName+"</a>";
		    			var rowItemMobile = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenuMobile "+middleItemsName+"SameMobile' id='"+middleItemsName+"Mobile'>"+middleItemsName+"</a>";
		    		} else {
		    			var rowItem = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenu "+middleItemsName+"' id='"+middleItemsName+"'>"+middleItemsName+"</a>";
		    			var rowItemMobile = "<a href='<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>' class='mediumMenuMobile "+middleItemsName+"Mobile' id='"+middleItemsName+"Mobile'>"+middleItemsName+"</a>";
		    		} 
				 	$('#menu').append(rowItem);
				 	$('#categorySubMenuMobile').append(rowItemMobile);
		    	})
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
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
	
	function mobileSubMenuBtn() {
		var check = document.getElementById("mobileSubMenu");
		console.log(check.style.display);
		if(check.style.display=='none') {
			check.style.display = 'block';
		} else {
			check.style.display = 'none';
		}
	}
		
</script>