<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>문의하기</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','requestsWrite');
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<div class="divBox">
			<div class="card">
				<div class="card-header">
					<h4>Successful IT Developer 관리자에게 요청사항 및 수정사항을 전달합니다.</h4>
					<h5 class="colorRed">회원 여러분의 소중한 의견을 듣고싶습니다. 사소한 문제라고 말씀해주시면 최대한 반영하여 적용 및 수정하겠습니다. <br>감사합니다.</h5>
				</div>
				<div style="background:darkcyan; width: 100%; height:1px; float: left;"></div>
				<div class="card-block">
					<form id="form">
						<div class="form-group form-default">
							<input type="text" class="form-control input-material" id="requestsTitle" name="requestsTitle" maxlength="50" placeholder="제목 입력" required>
							<span class="form-bar"></span>
						</div>
						<div class="form-group form-default">
							<textarea class="form-control input-material" id="requestsDetail" name="requestsDetail" style="height:500px;" placeholder="여기에 내용을 입력 주세요." required></textarea>
							<span class="form-bar"></span>
						</div>
					</form>
					<div class="requestsBtn">
						<button class="btn btn-darkgreen btn-block" id="sendBtn" style="height:40px; font-size: inherit;">문의하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
<script>
	$('#sendBtn').click(function() {
		var formData = $("#form").serializeObject();
		var requestsTitle = $("#requestsTitle").val();
		var requestsDetail = $("#requestsDetail").val();
		if(requestsTitle == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제목을 입력해주세요.',
			});
			$("#requestsTitle").focus();
			return false;
		} else if(requestsDetail == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '내용을 입력해주세요.',
			});
			$("#requestsDetail").focus();
			return false;
		}
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/requestsWrite'/>",
		    data: formData,
		    async: false,
		    success: function (data) {
		    	if(data == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '관리자에게 요청 사항이 정상적으로 전달 되었습니다.',
					});
					$('#requestsTitle').val("");
					$('#requestsDetail').val("");
		    	} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});
</script>
</html>