<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 100%;  height: 100%;">
<head> 
	<title>로그인</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

	<script>
		$(function() {
			/* =========== 쿠키 값이 있을 경우 아이디 저장 CheckBox true ========= */
			if($.cookie('usersId') != null) {
				$('#check_btn').prop('checked',true);
			}
			
			/* =========== CheckBox true 일경우 ID Input 값 넣기 ========= */
			if($('#check_btn').is(':checked') == true) {
				$('#usersId').val($.cookie('usersId'));
			}
		});
	</script>
</head>
<body style="background-image:url('images/background.png'); background-size: cover;">
	<div style="text-align: -webkit-center;">
		<div style="text-align: -webkit-center; margin-top: 11%;">
			<form id="form" method="post" action="/ITDeveloper/login">
				<img style="width: 250px;" src="<c:url value='/images/logo.png' />" alt="logo.png">
				<div style="margin-top: 10px;">
					<input type="text" id="usersId" name="usersId" class="formControl login_idpw" required="required" placeholder="ID" value="${usersId}">
				</div>
				<div style="margin-top: 10px;">
					<input type="password" id="usersPw" name="usersPw" class="formControl login_idpw" required="required" placeholder="Password">
				</div>
				<div style="margin-top: 10px; text-align: -webkit-center;">
				 <button type="button" id="btn" class="btn btnPrimary btnBlock login_btn" onClick="pwdCheck();">Login</button>
				</div>
				<div class="check_wrap login_save">
					<input type="checkbox" id="check_btn"/>
					<label for="check_btn"><span>아이디 저장</span></label>
				</div>
				<div style="margin-top: 20px;">
					<button type="button" onClick="kakaoLogin();" style="border: 0; background: none;"><img class="login_kakao" src="<c:url value='/images/kakao.png' />" alt="logo.png"></button>
				</div>
				<br>
				<a href="<c:url value='/signUp'/>" style="margin: 10px; color: black;">회원가입</a>|<a href="<c:url value='/findId'/>" style="margin: 10px; color: black;">아이디</a>|<a href="<c:url value='/findPwd'/>" style="margin: 10px; color: black;">패스워드</a>
				<br><br><br>
				<a href="<c:url value='/index'/>" style="border-bottom: 1px solid; color: #afafaf;">비회원 IT Developer 시작하기</a>
			</form>
		</div>
	</div>
</body>
	<script>
		$(function() {
			$("#usersId").focus();
		})

		/* =========== 로그인(ID, PWD 일치 여부 확인 후) ========= */
		function pwdCheck() {
			var usersId = $('#usersId').val();
			var usersPw = $('#usersPw').val();
			
			if(usersId == "") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '아이디를 입력해주세요.',
				});
				return false;
			}
			if(usersPw == "") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '패스워드를 입력해주세요.',
				});
				return false;
			}
			
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/users/pwdCheck'/>",
		        data: {
		        	"usersId" : usersId,
		        	"usersPw" : usersPw
		        },
		        async: false,
		        success: function (data) {
		            if(data == "FALSE") {
		            	Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '아이디 패스워드가 일치하지 않습니다.',
						});
		            } else {
		            	$("form").submit();
		            }
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
			
			/* =========== CheckBox true 일경우 쿠키 저장 (기간 1일) ========= */
			if($('#check_btn').is(':checked') == true) {
				$.cookie('usersId', $('#usersId').val(), { expires: 1 });
			}
			
			/* =========== CheckBox false일 경우 쿠키 삭제 ========= */
			if($('#check_btn').is(':checked') == false) {
				$.removeCookie('usersId');
			}
		}
		
		/* =========== Enter 검색 ========= */
		$("input[type=password]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				pwdCheck();
			}
		});
		
		// 카카오 로그인 버튼 클릭
		function kakaoLogin() {
		  $.ajax({
		      url: "<c:url value='/login/getKakaoAuthUrl'/>",
		      type: 'get',
		      async: false,
		      dataType: 'text',
		      success: function (res) {
		          location.href = res;
		      }
		  });
		}
		
	</script>
</html>