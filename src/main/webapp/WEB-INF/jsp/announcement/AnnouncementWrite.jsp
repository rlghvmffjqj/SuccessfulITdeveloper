<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 작성</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<!-- Bootstrap -->
	<script type="text/javascript" src="<c:url value='/bootstrap/js/bootstrap.min.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap.min.css'/>">
	<!-- SummerNote -->
	<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	<script>
	    $(function() {
	    	$.cookie('name','announcementWrite', { path: '/ITDeveloper'});
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
					<form id="form">
						<div class="formGroup">
							<input type="text" class="formControl inputMaterial" id="announcementTitle" name="announcementTitle" maxlength="50" placeholder="제목 입력" required>
							<span class="form-bar"></span>
						</div>
						<div class="formGroup">
							<textarea class="summerNoteSize" rows="5" id="announcementDetail" name="announcementDetail" ></textarea>
							<span class="form-bar"></span>
						</div>
					</form>
					<div class="announcementBtn">
						<button class="btnDarkgreen btnBlock" id="sendBtn" style="height:40px; font-size: inherit;">공지사항 등록</button>
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
		var announcementTitle = $("#announcementTitle").val();
		var announcementDetail = $("#announcementDetail").val();
		if(announcementTitle == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제목을 입력해주세요.',
			});
			$("#announcementTitle").focus();
			return false;
		} else if(announcementDetail == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '내용을 입력해주세요.',
			});
			$("#announcementDetail").focus();
			return false;
		}
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/announcementWrite'/>",
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
						text: '공지사항 등록 완료!',
					}).then((result) => {
						let f = document.createElement('form');
					    
					    let obj;
					    obj = document.createElement('input');
					    obj.setAttribute('type', 'hidden');
					    obj.setAttribute('name', 'announcementKeyNum');
					    obj.setAttribute('value', data);
					    
					    f.appendChild(obj);
					    f.setAttribute('method', 'post');
					    f.setAttribute('action', "<c:url value='/announcementView'/>");
					    document.body.appendChild(f);
					    f.submit();
					});
					$('#announcementTitle').val("");
					$('#announcementDetail').val("");					  
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});
</script>
</html>