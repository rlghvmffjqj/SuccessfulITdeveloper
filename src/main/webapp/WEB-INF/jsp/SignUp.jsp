<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>회원가입</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

</head>
<body style="background-image:url('images/background.png'); background-size: cover;">
	<div style="text-align: -webkit-center;">
		<div style="text-align: -webkit-center; margin-top: 11%;">
			<form id="form" method="post">
				<img style="width: 250px;" src="<c:url value='/images/logo.png' />" alt="logo.png">
				<div style="margin-top: 10px;">
					<input style="width:350px; padding-inline: 10px;" type="text" id="employeeId" name="employeeId" class="formControl" required="required" placeholder="아이디">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="idEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
					<span id="idDuplicateCheck" style="color: red; font-size: 13px; display: none;">동일한 아이디가 존재합니다.</span>
				</div>
				<div style="margin-top: 10px;">
					<input type="password" style="width:350px; padding-inline: 10px;"  id="usersPw" name="usersPw" class="formControl" required="required" placeholder="비밀번호">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="pwdEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
				</div>
				<div style="margin-top: 10px;">
					<input type="password" style="width:350px; padding-inline: 10px;"  id="usersPwReconfirm" name="usersPwReconfirm" class="formControl" required="required" placeholder="비밀번호 재확인">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="pwdReEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
					<span id="pwdReSame" style="color: red; font-size: 13px; display: none;">※ 패스워드가 일치 하지 않습니다.</span>
				</div>
				<div style="margin-top: 10px;">
					<input type="text" style="width:350px; padding-inline: 10px;"  id="employeeName" name="employeeName" class="formControl" required="required" placeholder="이름">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="nameEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
				</div>
				<div style="margin-top: 10px;">
					<input type="email" pattern=".+@" style="width:350px; padding-inline: 10px;"  id="employeeEmail" name="employeeEmail" class="formControl" required="required" placeholder="이메일">
				</div>
				<div class="check_wrap" style="width: 375px; text-align: left;">
					<span id="emailEssential" style="color: red; font-size: 13px; display: none;">※ 필수 정보입니다.</span>
					<span id="emailDuplicateCheck" style="color: red; font-size: 13px; display: none;">등록된 이메일이 존재합니다.</span>
					<span id="emailForm" style="color: red; font-size: 13px; display: none;">이메일 주소에 '@'를 포함해 주세요.</span>
				</div>
				<div style="margin-top: 10px;">
					<input style="width:250px; padding-inline: 10px;" type="text" id="certificationNumber" name="certificationNumber" class="formControl" required="required" placeholder="인증번호">
					<button type="button" class="btn btnPrimary" style="height: 46px; width: 45px;" onClick="certificationSend();">전송</button>
					<button type="button" class="btn btnPrimary" style="height: 46px; width: 45px;" onClick="certificationConfirm();">확인</button>
				</div>
				<div style="margin-top: 10px; text-align: -webkit-center;">
					<button style=" border: none; width: 375px; height: 50px;" type="button" id="btn" class="btn btnPrimary btnBlock" onClick="signUp();">회원가입</button>
				</div>
				<div style="margin-top: 2px; text-align: -webkit-center;">
					<button style="border: none; width: 375px; height: 50px; background-color:#646464;" type="button" id="btn" class="btn btnPrimary btnBlock" onClick="login();">로그인</button>
				</div>
				<div class="check_wrap" style="margin-top: 10px; width: 375px; text-align: left;">
					<input type="checkbox" id="check_btn"/>
				</div>
				<br>
			</form>
		</div>
	</div>
</body>
	<script>
		var certificationCheck = false;
		function login() {
			location.href="<c:url value='/login'/>";
		}
	
		function signUp() {
			var check = true;
			if($('#employeeId').val() == "") {
				$('#idEssential').show();
				check = false;
			} else {
				$('#idEssential').hide();
			}
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
			if($('#employeeName').val() == "") {
				$('#nameEssential').show();
				check = false;
			} else {
				$('#nameEssential').hide();
			}
			if($('#employeeEmail').val() == "") {
				$('#emailEssential').show();
			} else {
				$('#emailEssential').hide();
				if($('#employeeEmail').val().includes('@')) {
					$('#emailForm').hide();
				} else {
					check = false;
					$('#emailForm').show();
				}
			}
			if($('#usersPw').val() != $('#usersPwReconfirm').val()) {
				$('#pwdReSame').show();
				check = false;
			} else {
				$('#pwdReSame').hide();
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
				var postData = $('#form').serializeObject();
				$.ajax({
					url: "<c:url value='/signUp'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
						if(result.result == "OK") {
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '작업을 완료했습니다.',
							}).then(function() {
								location.href="<c:url value='/login'/>";								
							});
						} else if(result.result == "idDuplicateCheck") {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '동일한 아이디가 존재합니다.',
							});
							$('#idDuplicateCheck').show();
						} else if(result.result == "emailDuplicateCheck") {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '등록된 이메일이 존재합니다.',
							});
							$('#emailDuplicateCheck').show();
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