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
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data">
		<div style="margin: 2%; margin-left: 30%; margin-right: 30%; height: 700px;">
			<span class="employeeUpdateTitle">내 정보 수정</span>
			<div class="myPageUpdateDiv">
				<div class="myPageUpdateLeft">
					<span class="myPageUpdateLeftSpan">아이디</span>
				</div>
				<div class="myPageUpdateRight">
					<input class="formControl seachInput inputDisable" type="text" value="${employee.employeeId}" disabled>
				</div>
			</div>
			<div class="myPageUpdateDiv">
				<div class="myPageUpdateLeft">
					<span class="myPageUpdateLeftSpan">이름</span>
				</div>
				<div class="myPageUpdateRight">
					<input class="formControl seachInput" type="text" id="employeeName" name="employeeName" value="${employee.employeeName}">
				</div>
			</div>
			<div class="myPageUpdateDiv">
				<div class="myPageUpdateLeft">
					<span class="myPageUpdateLeftSpan">전화번호</span>
				</div>
				<div class="myPageUpdateRight">
					<input class="formControl seachInput" type="text" id="employeePhone" name="employeePhone" value="${employee.employeePhone}">
				</div>
			</div>
			<div class="myPageUpdateDiv">
				<div class="myPageUpdateLeft">
					<span class="myPageUpdateLeftSpan">이메일</span>
				</div>
				<div class="myPageUpdateRight">
					<input class="formControl seachInput" type="text" id="employeeEmail" name="employeeEmail" value="${employee.employeeEmail}">
				</div>
			</div>
			<div class="myPageUpdateDiv">
				<div class="myPageUpdateLeft">
					<span class="myPageUpdateLeftSpan">프로필</span>
				</div>
				<div class="myPageUpdateRight">
					<input class="formControl seachInput" type="file" id="employeeImgFile" name="employeeImgFile">
				</div>
			</div>
	
		
			<div style="width: 100%; margin-top: 3%; text-align: center;">
				<button class="btn btnBlue myPageUpdateBtn" type="button" onClick="btnUpdate();">정보 수정</button>
				<button class="btn btnRed myPageUpdateBtn" type="button" onClick="btnCancell();">취소</button>
			</div>
		</div>
	</form>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	function btnCancell() {
		location.href="<c:url value='/myPage'/>";
	}

	function btnUpdate() {
		const postData = new FormData();
		postData.append('employeeImgFile',$('#employeeImgFile')[0].files[0]);
		postData.append('employeeName',$('#employeeName').val());
		postData.append('employeePhone',$('#employeePhone').val());
		postData.append('employeeEmail',$('#employeeEmail').val());
		
		$.ajax({
			url: "<c:url value='/myPage/employeeUpdate'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        processData: false,
	        contentType: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '정보 수정 완료하였습니다.',
					}).then(function() {
						//location.href="<c:url value='/myPage'/>";								
					});
				} else if(result == "NotExtension") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '프로필은 JPA, PNG 중 하나여야 합니다.',
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
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '작업을 실패하였습니다.',
				});
			}
	    });
	}
</script>

<style>
	.myPageUpdateDiv {
		border-top: 2px solid #e5e5e5; 
		height: 75px;
		margin-top: 1%;
	}

	.myPageUpdateLeft {
		width: 15%;	
		float: left; 
		margin-top: 15px; 
		margin-left: 2%;
	}

	.myPageUpdateRight {
		width: 83%; 
		float: left; 
		margin-top: 20px;
	}

	.myPageUpdateLeftSpan {
		color: black;	
		font-weight: bolder;
	}

	.myPageUpdateBtn {
		height: 40px;
    	width: 100px;
	}

	.seachInput {
		color: #555555;
	}

	.employeeUpdateTitle {
		font-size: 30px;
	    font-weight: bold;
	}
	
</style>
</html>