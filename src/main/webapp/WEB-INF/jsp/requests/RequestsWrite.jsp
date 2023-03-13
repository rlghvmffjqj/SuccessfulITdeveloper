<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>문의하기</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<!-- Bootstrap -->
	<script type="text/javascript" src="<c:url value='/bootstrap/js/bootstrap.min.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap.min.css'/>">
	<!-- SummerNote -->
	<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	<script>
	    $(function() {
	    	$.cookie('name','requestsWrite', { path: '/successfulITdeveloper'});
	    });
    </script>
    <style>
    	.note-editor {
    		border-left: 0 !important;
    		border-right: 0 !important; 
    		border-top: 0 !important;
    	}
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<div class="divBox">
			<div>
				<div>
					<span>Successful IT Developer 관리자에게 요청사항 및 수정사항을 전달합니다.</span><br>
					<span class="colorRed">회원 여러분의 소중한 의견을 듣고싶습니다. 사소한 문제라고 말씀해주시면 최대한 반영하여 적용 및 수정하겠습니다. <br>감사합니다.</span>
				</div>
				<div style="background:darkcyan; width: 100%; height:1px; float: left; margin-top: 15px; margin-bottom: 15px;"></div>
				<div>
					<form id="form">
						<div class="formGroup">
							<input type="text" class="formControl inputMaterial" id="requestsTitle" name="requestsTitle" maxlength="50" placeholder="제목 입력" required>
							<span class="form-bar"></span>
						</div>
						<div class="formGroup">
							<textarea class="summerNoteSize" rows="5" id="requestsDetail" name="requestsDetail" ></textarea>
							<span class="form-bar"></span>
						</div>
					</form>
					<div class="requestsBtn">
						<button class="btnDarkgreen btnBlock" id="sendBtn" style="height:40px; font-size: inherit;">문의하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
<script>
	$(function (){
		/* =========== 섬머노트 ========= */
		$('.summerNoteSize').summernote({
			minHeight:495,
			maxHeight:495,
			placeholder:"여기에 내용을 입력 주세요."
		});
	});

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
		    	if(data == 0) {
		    		Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});
		    	} else {
		    		Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '관리자에게 요청 사항이 정상적으로 전달 되었습니다.',
					}).then((result) => {
						let f = document.createElement('form');
					    
					    let obj;
					    obj = document.createElement('input');
					    obj.setAttribute('type', 'hidden');
					    obj.setAttribute('name', 'requestsKeyNum');
					    obj.setAttribute('value', data);
					    
					    f.appendChild(obj);
					    f.setAttribute('method', 'post');
					    f.setAttribute('action', "<c:url value='/requestsView'/>");
					    document.body.appendChild(f);
					    f.submit();
					});
					$('#requestsTitle').val("");
					$('#requestsDetail').val("");					  
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});
</script>
</html>