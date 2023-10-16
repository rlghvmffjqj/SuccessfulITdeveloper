<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>회원 상세정보</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" method ="post">
			<div class="divBox" >
				<div class="textAlignCenter">
					<h3>회원 상세 정보</h3>
				</div>
			    <table style="width:100%">
			    	<tr>
			    		<td class="tdSilver">사용자ID</td>
			    		<td><input type="text" id="employeeId" name="employeeId" class="formControl seachInput"  value="${employee.employeeName}" readonly="readonly"></td>
			    	</tr>
			    	<tr>
			    		<td class="tdSilver">사원명</td>
			    		<td><input type="text" id="employeeName" name="employeeName" class="formControl seachInput"  value="${employee.employeeName}"></td>
			    	</tr>
			    	<tr>
			    		<td class="tdSilver">이메일</td>
			    		<td><input type="text" id="employeeEmail" name="employeeEmail" class="formControl seachInput" value="${employee.employeeEmail}"></td>
			    	</tr>
			    	<tr>
			    		<td class="tdSilver">상태</td>
			    		<td>
							<select class="formControl selectpicker seachInput" id="employeeStatus" name="employeeStatus" style="height: 34px; width: 98%;">
								<option value=""></option>
								<option value="정상" <c:if test="${'정상' eq employee.employeeStatus}">selected</c:if>>정상</option>
								<option value="제한" <c:if test="${'제한' eq employee.employeeStatus}">selected</c:if>>제한</option>
							</select>
						</td>
			    	</tr>
			    	<tr>
			    		<td class="tdSilver">권한</td>
			    		<td>
			    			<select class="formControl selectpicker seachInput" id="usersRole" name="usersRole" style="height: 34px; width: 98%;">
								<option value="ADMIN" <c:if test="${'ADMIN' eq role}">selected</c:if>>관리자</option>
								<option value="MEMBER" <c:if test="${'MEMBER' eq role}">selected</c:if>>일반회원</option>
							</select>
			    		</td>
			    	</tr>
			    	<tr>
			    		<td class="tdSilver">마지막 로그인 시간</td>
			    		<td><input type="text" id="lastLogin" class="formControl seachInput" value="${employee.lastLogin}" readonly="readonly"></td>
			    	</tr>
			    </table>
			    
			    <div style="height: 30px;"></div>
			    <div class="textAlignCenter width100">
					<button class="btn btnDarkgreen btnm" type="button" onClick="btnUpdate();">
						<span>수정</span>
					</button>
					<button class="btn btnDefault btnm" type="button" onClick="btnList();">
						<span>목록</span>
					</button>
				</div>
				<div style="height: 30px;"></div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
<script>
	function btnList() {
		location.href="<c:url value='/employeeList'/>";
	}
	
	function btnUpdate() {
		var postData = $('#form').serializeObject();
		$.ajax({
			url: "<c:url value='/employee/update'/>",
            type: 'post',
            data: postData,
            async: false,
            success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					}).then((result) => {
						location.href="<c:url value='/employeeList'/>";	
					});
				} else {
					Swal.fire({               
						icon: 'error',
						title: '실패!',
						text: '작업을 실패했습니다.',
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
	.seachInput {
		width: 96%;
		padding-inline: 8px;
		margin-left: 1%;
	}
	
	.height70 {
	    height: 70px;
	}
	
	.tdSilver {
		width: 15%;
		background: #c7c7c7;
    	text-align: center;
    	height: 50px;
	}
	
	td {
		border: 1px solid #EBEBEB;
	}
	
</style>
</html>