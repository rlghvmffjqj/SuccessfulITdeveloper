<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>패스워드 찾기</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

</head>
<body style="background-image:url('images/background.png'); background-size: cover;">
	<div style="text-align: -webkit-center;">
		<div style="text-align: -webkit-center; margin-top: 15%;">
			<form id="form" method="post">
				<img style="width: 250px;" src="<c:url value='/images/logo.png' />" alt="logo.png">
				<div style="margin-top: 10px;">
					<input style="width:350px; padding-inline: 10px;" type="text" id="employeeId" name="employeeId" class="formControl" required="required" placeholder="아이디">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="idEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
				</div>
				<div style="margin-top: 10px;">
					<input style="width:350px; padding-inline: 10px;" type="text" id="employeeEmail" name="employeeEmail" class="formControl" required="required" placeholder="이메일">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="emailEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
				</div>
				<div style="margin-top: 10px;">
					<input style="width:250px; padding-inline: 10px;" type="text" id="certificationNumber" name="certificationNumber" class="formControl" required="required" placeholder="인증번호">
					<button type="button" class="btn btnPrimary" style="height: 46px; width: 45px;" onClick="certificationSend();">전송</button>
					<button type="button" class="btn btnPrimary" style="height: 46px; width: 45px;" onClick="certificationConfirm();">확인</button>
				</div>
				<div style="margin-top: 10px; text-align: -webkit-center;">
					<button style=" border: none; width: 375px; height: 50px;" type="button" id="btn" class="btn btnPrimary btnBlock" onClick="findPwd();">패스워드 찾기</button>
				</div>
				<div style="margin-top: 2px; text-align: -webkit-center;">
					<button style="border: none; width: 375px; height: 50px; background-color:#646464;" type="button" id="btn" class="btn btnPrimary btnBlock" onClick="login();">로그인</button>
				</div>
				
				<!-- The Modal -->
			    <div id="modal" class="modal">
					<!-- Modal content -->
					<div class="modal-content" style="margin: 19% auto;">
						<a onclick="close_pop();" style="float: right; font-weight: bold; color: #999999; cursor: pointer;">X</a><br><br>
						<input style="width:100%; margin: 2px;" type="password" id="usersPw" name="usersPw" class="formControl" required="required" placeholder="비밀번호">
						<span id="pwdEssential" style="color: red; font-size: 13px; float: left; display: none;">※ 필수 정보입니다.</span>
						<input style="width:100%; margin: 2px;" type="password" id="usersPwReconfirm" name="usersPwReconfirm" class="formControl" required="required" placeholder="비밀번호 재확인">
						<span id="pwdReEssential" style="color: red; font-size: 13px; float: left; display: none;">※ 필수 정보입니다.</span>
						<span id="pwdReSame" style="color: red; font-size: 13px; float: left; display: none;">패스워드가 일치 하지 않습니다.</span><br>
						<button type="button" class="btn btnPrimary btnBlock" style="width: 200px; height: 50px; margin: 5px;" onclick="pwdChange();">패스워드 변경</button><br>
					</div>
				</div>
		        <!--End Modal-->
			</form>
		</div>
	</div>
</body>
	<script>
		var certificationCheck = false;
		function login() {
			location.href="<c:url value='/login'/>";
		}
		
		function pwdChange() {
			var employeeId = $('#employeeId').val();
			var employeeEmail = $('#employeeEmail').val();
			var check = true;
			if($('#usersPw').val() == "") {
				$('#pwdEssential').show();
				check = false;
			} else {
				$('#pwdEssential').hide();
			}
			if($('#usersPwReconfirm').val() == "") {
				$('#pwdReEssential').show();
				check = false;
			} else {
				$('#pwdReEssential').hide();
			}
			if($('#usersPw').val() != $('#usersPwReconfirm').val()) {
				$('#pwdReSame').show();
				check = false;
			} else {
				$('#pwdReSame').hide();
			}
			
			if(check == true) {
				var usersPw = $('#usersPw').val();
				$.ajax({
					url: "<c:url value='/changePwd'/>",
					type: 'post',
					data: {
						"usersPw":usersPw,
						"employeeEmail":employeeEmail,
						"employeeId":employeeId
					},
					async: false,
					dataType: 'text',
					success: function (data) {
						if(data == "OK") {
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '작업을 완료했습니다.',
							}).then(function() {
								location.href="<c:url value='/login'/>";								
							});
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업중 오류가 발생하였습니다.',
							});
						}
					}
				});
			}
		}
		
		function findPwd() {
			var employeeId = $('#employeeId').val();
			var employeeEmail = $('#employeeEmail').val();
			var check = true;
			if(employeeId == "") {
				$('#idEssential').show();
				check = false;
			} else {
				$('#idEssential').hide();
			}
			if(employeeEmail == "") {
				$('#emailEssential').show();
				check = false;
			} else {
				$('#emailEssential').hide();
			}
			if(certificationCheck == false) {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '인증번호 확인 후 이용 바랍니다',
				});	
				return;
			}
			
			if(check == true) {
				$.ajax({
					url: "<c:url value='/findPwd'/>",
					type: 'post',
					data: {
						"employeeEmail":employeeEmail,
						"employeeId":employeeId
					},
					async: false,
					dataType: 'text',
					success: function (data) {
						if(data == "noMatch") {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '아이디와 이메일이 일치하지 않습니다.',
							});	
						} else {
							$('#modal').show();
						}
					}
				});
			}
		}
		//팝업 Close 기능
		function close_pop(flag) {
			$('#modal').hide();
		};
		
		function loginCheck() {
			var findId = $('#findId').text();
			location.href="<c:url value='/loginCheck'/>?employeeId="+findId;
		}
		
		function certificationSend() {
			var check = true;
			var employeeEmail = $('#employeeEmail').val();
			if(employeeEmail == "") {
				$('#emailEssential').show();
				check = false;
			} else {
				$('#emailEssential').hide();
			}
			if(check == true) {
				$.ajax({
					url: "<c:url value='/emailConfirm'/>",
					type: 'post',
					data: {
						"employeeEmail":employeeEmail
					},
					async: false,
					dataType: 'text',
					success: function (data) {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '인증번호 정상적으로 전달 되었습니다.',
						});
						sessionStorage.setItem("certificationNum", data);
					}
				});
			}
		}
		
		
		function certificationConfirm() {
			var certificationNumber = $('#certificationNumber').val();
			if(certificationNumber == sessionStorage.getItem('certificationNum')) {
				Swal.fire({
					icon: 'success',
					title: '성공!',
					text: '인증 완료 되었습니다.',
				});
				sessionStorage.removeItem('certificationNum');
				certificationCheck = true;
			} else {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '인증 실패 인증번호가 일치하지 않습니다.',
				});	
			}
		}
	</script>
</html>