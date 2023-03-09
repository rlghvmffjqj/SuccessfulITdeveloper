<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>아이디 찾기</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

</head>
<body style="background-image:url('images/background.png'); background-size: cover;">
	<div style="text-align: -webkit-center;">
		<div style="text-align: -webkit-center; margin-top: 15%;">
			<form id="form" method="post">
				<img style="width: 250px;" src="<c:url value='/images/logo.png' />" alt="logo.png">
				<div style="margin-top: 10px;">
					<input style="width:350px; padding-inline: 10px;" type="text" id="employeeEmail" name="employeeEmail" class="formControl" required="required" placeholder="이메일">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="emailEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
				</div>
				<div style="margin-top: 10px; text-align: -webkit-center;">
					<button style=" border: none; width: 375px; height: 50px;" type="button" id="btn" class="btn btnPrimary btnBlock" onClick="findId();">아이디 찾기</button>
				</div>
				<div style="margin-top: 2px; text-align: -webkit-center;">
					<button style="border: none; width: 375px; height: 50px; background-color:#646464;" type="button" id="btn" class="btn btnPrimary btnBlock" onClick="login();">로그인</button>
				</div>
				
				<!-- The Modal -->
			    <div id="modal" class="modal">
					<!-- Modal content -->
					<div class="modal-find" style="margin: 19% auto;">
						<a onclick="close_pop();" style="float: right; font-weight: bold; color: #999999; cursor: pointer;">X</a><br><br>
						<span id="findId"></span><button type="button" class="btn btnPrimary btnBlock" style="display: inline; width: 55px; margin-left: 20px;" onclick="loginCheck();">선택</button><br><br>
					</div>
				</div>
		        <!--End Modal-->
			</form>
		</div>
	</div>
</body>
	<script>
		function login() {
			location.href="<c:url value='/login'/>";
		}
		
		function findId() {
			var employeeEmail = $('#employeeEmail').val();
			if(employeeEmail == "") {
				$('#emailEssential').show();
				return;
			}
			$.ajax({
				url: "<c:url value='/findId'/>",
				type: 'post',
				data: {"employeeEmail":employeeEmail},
				async: false,
				dataType: 'text',
				success: function (data) {
					console.log(data);
					if(data == "noId") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '존재하지 않는 이메일 입니다.',
						});	
					} else {
						$('#findId').text(data);
						$('#modal').show();
					}
				}
			});
		}
		//팝업 Close 기능
		function close_pop(flag) {
			$('#modal').hide();
		};
		
		function loginCheck() {
			var findId = $('#findId').text();
			location.href="<c:url value='/loginCheck'/>?employeeId="+findId;
		}
	</script>
</html>