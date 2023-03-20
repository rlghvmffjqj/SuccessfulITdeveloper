<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>자유게시판</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script type="text/javascript" src="<c:url value='/js/jquery/jquery-ui.js'/>"></script>
	<%@ include file="/WEB-INF/jsp/common/_Table.jsp"%>
	<script>
		$(function() {
	    	$.cookie('name',"freeBoardList", { path: '/ITDeveloper'});
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" action="<c:url value='/freeBoard/freeBoardUpdateWrite'/>" method="post">
			<input type="hidden" id="freeBoardKeyNum" name="freeBoardKeyNum" value="${freeBoardKeyNum}">
			<h1 style="float: left;">${freeBoard.freeBoardTitle}</h1>
			<c:if test="${certification eq 'allowed'}">
				<button class="btn btnBlue btnBlock middleBtn contentsViewBtn" id="updateBtn" type="submit">수정</button>
				<button class="btn btnRed btnBlock middleBtn contentsViewBtn" id="deleteBtn" type="button">삭제</button>
			</c:if>
			<div class="divBox" >
				<div style="min-height: 300px;">
					<div>${freeBoard.freeBoardDetail}</div>
				</div>
			</div>
		</form>
		
		<div class="commentDiv">
			<c:forEach var="freeBoardComments" items="${freeBoardCommentsList}">
				<c:if test="${freeBoardComments.freeBoardCommentsDepth == 0}">
					<div class="commentView">
						<span id="freeBoardCommentsKeyNum" style="display:none">${freeBoardComments.freeBoardCommentsKeyNum}</span>
						<span class="commentsName" id="freeBoardCommentsName">${freeBoardComments.freeBoardCommentsName}</span>
						<span class="commentsDate" id="freeBoardCommentsDate">${freeBoardComments.freeBoardCommentsDate}</span>
						<a class="commentsReply" id="freeBoardCommentsReply" href="#!" onClick="freeBoardCommentsReply(this);">답글</a>
						<div class="commentsUpdate">
							<a href="#!" onClick="freeBoardCommentsUpdate(this);">···</a>
							<div class="commentsUpdateLink">
								<a href="#!" class="commentsUpdateA" onclick="updateComment(this);">수정</a>
								<a href="#!" class="commentsUpdateA" onclick="deleteComment(this);">삭제</a>
							</div>
						</div>
						<p class="commentsContents" id="freeBoardCommentsContents">${freeBoardComments.freeBoardCommentsContents}</p>
					</div>
				</c:if>
				<c:if test="${freeBoardComments.freeBoardCommentsDepth > 0}">
					<div class="commentAnswerView" style="margin-left: ${freeBoardComments.freeBoardCommentsDepth*5}%;">
						<span id="freeBoardCommentsKeyNum" style="display:none">${freeBoardComments.freeBoardCommentsKeyNum}</span>
						<span class="commentsName" id="freeBoardCommentsName">${freeBoardComments.freeBoardCommentsName}</span>
						<span class="commentsDate" id="freeBoardCommentsDate">${freeBoardComments.freeBoardCommentsDate}</span>
						<a class="commentsReply" id="freeBoardCommentsReply" href="#!" onClick="freeBoardCommentsReply(this);">답글</a>
						<div class="commentsUpdate">
							<a href="#!" onClick="freeBoardCommentsUpdate(this);">···</a>
							<div class="commentsUpdateLink">
								<a href="#!" class="commentsUpdateA" onclick="updateComment(this);">수정</a>
								<a href="#!" class="commentsUpdateA" onclick="deleteComment(this);">삭제</a>
							</div>
						</div>
						<p class="commentsContents" id="freeBoardCommentsContents">${freeBoardComments.freeBoardCommentsContents}</p>
					</div>
				</c:if>
			</c:forEach>
		</div>
		
		<div>
			<form id="commentform" name="commentform" method ="post">
				<input type="hidden" id="freeBoardKeyNum" name="freeBoardKeyNum" value="${freeBoardKeyNum}">
				<div class="comment-form">
					<div class="field">
							<input class="commentHead" type="text" name="freeBoardCommentsName" placeholder="이름" value="">
							<input class="commentHead" type="password" name="freeBoardCommentsPassword" maxlength="8" placeholder="비밀번호" value="">
					</div>
			
					<textarea class="commentBody" name="freeBoardCommentsContents" cols="" rows="4" placeholder="여러분의 소중한 댓글을 입력바랍니다."></textarea>
					<div class="submit">
						<div class="secret">
							<input type="checkbox" name="freeBoardCommentsSecret" id="secret">
							<label>비밀글</label>
						</div>
						<button class="commentSend btn" type="button" id="btnComments">등록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
	
	<div id="dialog-reply" title="답글달기" style='display:none'>
		<form id="commentReplyform" name="commentReplyform" method ="post" onsubmit="return false">
	  		<input class="commentHeadDialog" type="text" name="freeBoardCommentsNameDialog" placeholder="이름" value="">
			<input class="commentHeadDialog" type="password" name="freeBoardCommentsPasswordDialog" maxlength="8" placeholder="비밀번호" value="">
	  		<textarea class="commentBodyDialog" name="freeBoardCommentsContentsDialog" cols="" rows="4" placeholder="여러분의 소중한 댓글을 입력바랍니다."></textarea>
	  		<input type="checkbox" name="freeBoardCommentsSecretDialog" id="secret">
	  		<label class="commentSecretDialog">비밀글</label>
		</form>
	</div>
	
	<div id="dialog-delete" title="댓글삭제" style='display:none'>
		<form id="commentDeleteform" name="commentDeleteform" method ="post" onsubmit="return false">
	  		<input class="commentUpdateDialog" type="password" id="freeBoardCommentsPasswordDeleteDialog" name="freeBoardCommentsPasswordDialog" placeholder="비밀번호" value="">
		</form>
	</div>
	
	<div id="dialog-updateCheck" title="댓글 수정" style='display:none'>
		<form id="commentUpdateCheckform" name="commentUpdateCheckform" method ="post" onsubmit="return false">
	  		<input class="commentUpdateDialog" type="password" id="freeBoardCommentsPasswordUpdateDialog" name="freeBoardCommentsPasswordDialog" placeholder="비밀번호" value="">
		</form>
	</div>
	
	<div id="dialog-update" title="답글 수정" style='display:none'>
		<form id="commentUpdateform" name="commentUpdateform" method ="post" onsubmit="return false">
	  		<input class="commentHeadDialog" type="text" id="freeBoardCommentsNameDialog" name="freeBoardCommentsNameDialog" placeholder="이름" value="">
	  		<textarea class="commentBodyDialog" name="freeBoardCommentsContentsDialog" cols="" rows="4" placeholder="여러분의 소중한 댓글을 입력바랍니다."></textarea>
	  		<input type="checkbox" name="freeBoardCommentsSecretDialog" id="freeBoardCommentsSecretDialog">
	  		<label class="commentSecretDialog">비밀글</label>
		</form>
	</div>
</body>
<script>
	function freeBoardCommentsReply(reply) {
		var freeBoardCommentsKeyNum = reply.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		$('#dialog-reply').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); replaySubmit(freeBoardCommentsKeyNum); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
	}
	
	function replaySubmit(freeBoardCommentsKeyNum) {
		var postData = $('#commentReplyform').serializeArray();
		postData.push({name : "freeBoardCommentsKeyNum", value : freeBoardCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/freeBoard/freeBoardCommentsReply'/>",
	        async: false,
	        data: postData,
	        success: function (data) {
	        	if(data=="OK") {
					Swal.fire(
					  '답글!',
					  '답글 등록 하였습니다.',
					  'success'
					).then(() => {
						location.reload();
					});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
	        },
	    });
	}
	
	$('#btnComments').click(function() {
		var postData = $('#commentform').serializeObject();
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/freeBoard/freeBoardComments'/>",
	        async: false,
	        data: postData,
	        success: function (data) {
				if(data=="OK") {
					Swal.fire(
					  '댓글!',
					  '댓글 등록 하였습니다.',
					  'success'
					).then(() => {
						location.reload();
					});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
	        },
	    });
	});
	
	function freeBoardCommentsUpdate(link) {
		if(link.nextElementSibling.style.display=="block") {
			link.nextElementSibling.style.display="none";
		} else {
			link.nextElementSibling.style.display="block";
		}
	}
	
	function updateComment(update) {
		var freeBoardCommentsKeyNum = update.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		var freeBoardCommentsName = update.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		$('#dialog-updateCheck').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); updateCheckSubmit(freeBoardCommentsKeyNum,freeBoardCommentsName); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
		$("#freeBoardCommentsPasswordUpdateDialog").val("");
	}
	
	function updateCheckSubmit(freeBoardCommentsKeyNum,freeBoardCommentsName) {
		var postData = $('#commentUpdateCheckform').serializeArray();
		postData.push({name : "freeBoardCommentsKeyNum", value : freeBoardCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/freeBoard/freeBoardCommentsUpdateCheck'/>",
	        async: false,
	        data: postData,
	        success: function (data) {
	        	if(data=="OK") {
					commentUpdate(freeBoardCommentsKeyNum,freeBoardCommentsName);
	        	} else if(data=="Inconsistency") {
	        		Swal.fire({
						icon: 'error',
						title: '불일치',
						text: '패스워드가 일치하지 않습니다.',
					});    
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
	        },
	    });
	}
	
	function commentUpdate(freeBoardCommentsKeyNum,freeBoardCommentsName) {
		$('#dialog-update').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); updateSubmit(freeBoardCommentsKeyNum); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
		$('#freeBoardCommentsNameDialog').val(freeBoardCommentsName);
	}
	
	function updateSubmit(freeBoardCommentsKeyNum) {
		var postData = $('#commentUpdateform').serializeArray();
		postData.push({name : "freeBoardCommentsKeyNum", value : freeBoardCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/freeBoard/freeBoardCommentsUpdate'/>",
	        async: false,
	        data: postData,
	        success: function (data) {
	        	if(data=="OK") {
					Swal.fire(
					  '수정!',
					  '댓글 수정 하였습니다.',
					  'success'
					).then(() => {
						location.reload();
					});
	        	} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
	        },
	    });
	}
	
	function deleteComment(del) {
		var freeBoardCommentsKeyNum = del.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		$('#dialog-delete').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); deleteSubmit(freeBoardCommentsKeyNum); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
		$("#freeBoardCommentsPasswordDeleteDialog").val("");
	}
	
	function deleteSubmit(freeBoardCommentsKeyNum) {
		var postData = $('#commentDeleteform').serializeArray();
		postData.push({name : "freeBoardCommentsKeyNum", value : freeBoardCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/freeBoard/freeBoardCommentsDelete'/>",
	        async: false,
	        data: postData,
	        success: function (data) {
	        	if(data=="OK") {
					Swal.fire(
					  '삭제!',
					  '댓글이 삭제 되었습니다.',
					  'success'
					).then(() => {
						location.reload();
					});
	        	} else if(data=="Inconsistency") {
	        		Swal.fire({
						icon: 'error',
						title: '불일치',
						text: '패스워드가 일치하지 않습니다.',
					});    
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
	        },
	    });
	}
	
	$('#deleteBtn').click(function() {
		var freeBoardKeyNum = $('#freeBoardKeyNum').val();
		
		Swal.fire({
			  title: '삭제!',
			  text: "게시물 삭제 하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#7066e0',
			  cancelButtonColor: '#FF99AB',
			  confirmButtonText: '삭제',
			  cancelButtonText: '아니오'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
				    type: 'post',
				    url: "<c:url value='/freeBoard/delete'/>",
				    data: {"freeBoardKeyNum":freeBoardKeyNum},
				    async: false,
				    success: function (data) {
				    	if(data == "OK"){
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '작업을 완료했습니다.',
							}).then(() => {
								location.replace("<c:url value='/freeBoard/freeBoardList'/>");
							});
						} else{
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
						}
				    },
				    error: function(e) {
				        console.log(e);
				    }
				});
			}
		})
	});
	
	
</script>
</html>