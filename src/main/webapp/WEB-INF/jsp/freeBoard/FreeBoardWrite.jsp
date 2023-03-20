<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>자유게시판</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<!-- Bootstrap -->
	<script type="text/javascript" src="<c:url value='/bootstrap/js/bootstrap.min.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap.min.css'/>">
	<!-- SummerNote -->
	<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	<script>
	    $(function() {
	    	$.cookie('name','freeBoardList', { path: '/ITDeveloper'});
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
					<span>Successful IT Developer 접속자 여러분들 감사합니다.</span><br>
					<span class="colorRed">접속자 여러분들께서 공유하고싶은 내용 또는 궁금한 내용을 입력해주시기 바랍니다. <br>감사합니다.</span>
				</div>
				<div style="background:darkcyan; width: 100%; height:1px; float: left; margin-top: 15px; margin-bottom: 15px;"></div>
				<div>
					<form id="form">
						<input type="hidden" id="freeBoardKeyNum" name="freeBoardKeyNum" value="${freeBoard.freeBoardKeyNum}">
						<div class="formGroup">
							<input type="text" class="formControl inputMaterial" id="freeBoardTitle" name="freeBoardTitle" maxlength="50" placeholder="제목 입력" value="${freeBoard.freeBoardTitle}" required>
							<span class="form-bar"></span>
						</div>
						<div class="formGroup">
							<textarea class="summerNoteSize" rows="5" id="freeBoardDetail" name="freeBoardDetail">${freeBoard.freeBoardDetail}</textarea>
							<span class="form-bar"></span>
						</div>
					</form>
					<div class="freeBoardBtn">
						<c:if test="${viewType == 'insert'}">
							<button class="btnDarkgreen btnBlock" id="sendBtn" style="height:40px; font-size: inherit;">등록하기</button>
						</c:if>
						<c:if test="${viewType == 'update'}">
							<button class="btnDarkgreen btnBlock" id="updateBtn" style="height:40px; font-size: inherit;">수정하기</button>
						</c:if>
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
		var freeBoardTitle = $("#freeBoardTitle").val();
		var freeBoardDetail = $("#freeBoardDetail").val();
		if(freeBoardTitle == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제목을 입력해주세요.',
			});
			$("#freeBoardTitle").focus();
			return false;
		} else if(freeBoardDetail == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '내용을 입력해주세요.',
			});
			$("#freeBoardDetail").focus();
			return false;
		}
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/freeBoard/freeBoardWrite'/>",
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
						text: '게시물 등록 되었습니다.',
					}).then((result) => {
						location.href="<c:url value='/freeBoard/freeBoardView'/>?contentNumber="+data;
					});
					$('#freeBoardTitle').val("");
					$('#freeBoardDetail').val("");					  
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});
	
	$('#updateBtn').click(function() {
		var formData = $("#form").serializeObject();
		var freeBoardTitle = $("#freeBoardTitle").val();
		var freeBoardDetail = $("#freeBoardDetail").val();
		if(freeBoardTitle == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제목을 입력해주세요.',
			});
			$("#freeBoardTitle").focus();
			return false;
		} else if(freeBoardDetail == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '내용을 입력해주세요.',
			});
			$("#freeBoardDetail").focus();
			return false;
		}
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/freeBoard/freeBoardUpdate'/>",
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
						text: '게시물 등록 되었습니다.',
					}).then((result) => {
						location.href="<c:url value='/freeBoard/freeBoardView'/>?contentNumber="+data;
					});
					$('#freeBoardTitle').val("");
					$('#freeBoardDetail').val("");					  
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});
</script>
</html>