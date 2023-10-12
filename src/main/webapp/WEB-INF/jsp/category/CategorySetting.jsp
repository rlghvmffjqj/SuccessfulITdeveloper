<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>메뉴설정</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ include file="/WEB-INF/jsp/common/_Table.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','categorySetting', { path: '/ITDeveloper'});
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<div class="divBox" >
			<form id="form" name="form" method ="post">
				<div style="width: 100%; height: 50px;">
					<h2 style="float: left; height: 0px;">메뉴 설정</h2>
					<button class="saveButton" type="button" onclick='btnSave()'>저장</button>
				</div>
				<div class="divTop">
					<div><div><div id="blank"></div></div></div>
					<c:forEach var="top" items="${topMenu}">
						<div style="border-bottom: 1px indianred dashed; padding-bottom: 3%; padding-top: 3%;">
							<div class="menuForm">
								<input class="menuInput" id="topItemsName" name="topItemsName" value="${top}"><button class="menuBtn" type="button" onclick='topMenuPlus(this)'>+</button><button class="menuBtn" type="button" onclick='topMenuMinus(this)'>-</button>
							</div>
							<div class="divMiddle">
								<c:forEach var="middle" items="${middleMenu}">
									<c:if test="${middle.topItemsName eq top}">
										<div class="menuForm munuFormSub">
											<input class="menuInput" id="middleItemsName" name="middleItemsName" value="${middle.middleItemsName}"><button class="menuBtn" type="button" onclick='middleMenuPlus(this)'>+</button><button class="menuBtn" type="button" onclick='middleMenuMinus(this)'>-</button>
										</div>
									</c:if>
								</c:forEach>
								
								<c:if test="${!fn:contains(middleTopName, top)}">
									<div class="menuForm munuFormSub">
										<input class="menuInput" id="middleItemsName" name="middleItemsName" value="${middle.middleItemsName}"><button class="menuBtn" type="button" onclick='middleMenuPlus(this)'>+</button><button class="menuBtn" type="button" onclick='middleMenuMinus(this)'>-</button>
									</div>
								</c:if>
							</div>
							<input type='hidden' class="menuInput" id="topItemsName" name="topItemsName" value="|">
							<input type='hidden' class="menuInput" id="middleItemsName" name="middleItemsName" value="|">
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	$(function() {
		if($('.menuForm').length == 0) {
			topMenuPlus(document.getElementById('blank'));
		}
	});

	function topMenuPlus(obj) {
		console.log(obj);
		var div = $(obj).parent().parent();
		var rowItem = "<div>"; 
		rowItem += "<div class='menuForm'>";
		rowItem += "<input class='menuInput' id='topItemsName' name='topItemsName' value=''><button class='menuBtn' type='button' onclick='topMenuPlus(this)'>+</button><button class='menuBtn' type='button' onclick='topMenuMinus(this)'>-</button>";
		rowItem += "</div>";
		rowItem += "<div class='divMiddle'>";
		rowItem += "<div class='menuForm munuFormSub'>";
		rowItem += "<input class='menuInput' id='middleItemsName' name='middleItemsName' value=''><button class='menuBtn' type='button' onclick='middleMenuPlus(this)'>+</button><button class='menuBtn' type='button' onclick='middleMenuMinus(this)'>-</button>";
		rowItem += "</div>";
		rowItem += "</div>";
		rowItem += "<div style='height:30px'>--------------------------------------------------------------------------------------------------</div>";
		rowItem += "<input type='hidden' class='menuInput' id='topItemsName' name='topItemsName' value='|'>";
		rowItem += "<input type='hidden' class='menuInput' id='middleItemsName' name='middleItemsName' value='|'>";
		rowItem += "</div>";
		div.after(rowItem);
	}
	
	function topMenuMinus(obj) {
		var div = $(obj).parent().parent();
		div.remove();
		
		if($('.menuForm').length == 0) {
			topMenuPlus($(this).attr('blank'));
		}
	}
	
	function middleMenuPlus(obj) {
		var div = $(obj).parent();
		var rowItem = "<div class='menuForm munuFormSub'>";
		rowItem += "<input class='menuInput' id='middleItemsName' name='middleItemsName' value=''><button class='menuBtn' type='button' onclick='middleMenuPlus(this)'>+</button><button class='menuBtn' type='button' onclick='middleMenuMinus(this)'>-</button>";
		rowItem += "</div>";
		div.after(rowItem);
	}
	
	function middleMenuMinus(obj) {
		var div = $(obj).parent();
		div.remove();
	}
	
	function btnSave() {
		var postData = $('#form').serializeArray();
		console.log(postData);
		$.ajax({
			url: "<c:url value='/category/categorySettingSave'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result == "OK") {
	        		Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '메뉴설정 작업이 정상적으로 작동하였습니다.'
					}).then(() => {
						location.reload();
					});
	        	} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}
</script>
<style>
	.menuBtn {
		width: 35px;
    	height: 35px;
		background: aliceblue;
    	border: 1px solid #8d8d8d;
	}
	
	.menuInput {
		width: 60%;
    	height: 30px;
    	float: left;
	}
	
	.menuForm {
		width: 50%;
    	padding: 5px;
	}
	
	.munuFormSub {
		margin-left: 10%;
	}
	
	.saveButton {
		width: 75px;
	    height: 35px;
	    background: lavender;
	    margin-top: 20px;
	    border: 1px solid;
	    float: left;
	    margin-left: 30%;
	}
</style>
</html>