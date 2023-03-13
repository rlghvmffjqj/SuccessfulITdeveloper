<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>게시글 작성</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<!-- Bootstrap -->
	<script type="text/javascript" src="<c:url value='/bootstrap/js/bootstrap.min.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap.min.css'/>">
	<!-- SummerNote -->
	<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	<script>
		$(function() {
	    	$.cookie('name',"${topItemsName}"+","+"${middleItemsName}", { path: '/successfulITdeveloper'});
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
						<input type="hidden" id="mainContentsKeyNum" name="mainContentsKeyNum" value="${mainContents.mainContentsKeyNum}">
						<input type="hidden" id="topItemsName" name="topItemsName" value="${topItemsName}">
						<input type="hidden" id="middleItemsName" name="middleItemsName" value="${middleItemsName}">
						<div class="formGroup">
							<input type="text" class="formControl inputMaterial" id="mainContentsTitle" name="mainContentsTitle" maxlength="100" placeholder="제목 입력" value="${mainContents.mainContentsTitle}" required>
							<span class="form-bar"></span>
						</div>
						<div class="formGroup">
							<textarea class="summerNoteSize" rows="5" id="mainContentsDetail" name="mainContentsDetail">${mainContents.mainContentsDetail}</textarea>
							<span class="form-bar"></span>
						</div>
					</form>
					<div class="mainContentsBtn">
						<c:if test="${viewType == 'insert'}">
							<button class="btnDarkgreen btnBlock" id="sendBtn" style="height:40px; font-size: inherit;">게시글 등록</button>
						</c:if>
						<c:if test="${viewType == 'update'}">
							<button class="btnDarkgreen btnBlock" id="updateBtn" style="height:40px; font-size: inherit;">게시글 수정</button>
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
		var mainContentsTitle= $("#mainContentsTitle").val();
		var mainContentsDetail = $("#mainContentsDetail").val();
		if(mainContentsTitle== "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제목을 입력해주세요.',
			});
			$("#mainContentsTitle").focus();
			return false;
		} else if(mainContentsDetail == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '내용을 입력해주세요.',
			});
			$("#mainContentsDetail").focus();
			return false;
		}
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/category/mainContentsWrite'/>",
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
						text: '게시글 등록 완료!',
					}).then((result) => {
						location.href="<c:url value='/category/mainContentsView'/>?contentNumber="+data;
					});
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});
	
	$('#updateBtn').click(function() {
		var formData = $("#form").serializeObject();
		var mainContentsTitle= $("#mainContentsTitle").val();
		var mainContentsDetail = $("#mainContentsDetail").val();
		if(mainContentsTitle== "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제목을 입력해주세요.',
			});
			$("#mainContentsTitle").focus();
			return false;
		} else if(mainContentsDetail == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '내용을 입력해주세요.',
			});
			$("#mainContentsDetail").focus();
			return false;
		}
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/category/mainContentsUpdate'/>",
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
						text: '게시글 수정 완료!',
					}).then((result) => {
						location.href="<c:url value='/category/mainContentsView'/>?contentNumber="+data;
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