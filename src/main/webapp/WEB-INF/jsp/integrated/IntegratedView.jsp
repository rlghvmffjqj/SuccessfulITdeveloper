<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>${mainContents.mainContentsTitle}</title>
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<script>
		$(function() {
	    	$.cookie('name',"${mainContents.topItemsName}"+","+"${mainContents.middleItemsName}", { path: '/ITDeveloper'});
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" action="<c:url value='/category/categoryUpdate'/>" method="post">
			<input type="hidden" id="topItemsName" name="topItemsName" value="${mainContents.topItemsName}">
			<input type="hidden" id="middleItemsName" name="middleItemsName" value="${mainContents.middleItemsName}">
			<input type="hidden" id="mainContentsKeyNum" name="mainContentsKeyNum" value="${mainContentsKeyNum}">
			<h1 style="float: left;">${mainContents.mainContentsTitle}</h1>
			<sec:authorize access="hasRole('ADMIN')">
				<div style="width: 100%; float: right;">
					<button class="btn btnBlue btnBlock middleBtn contentsViewBtn" id="updateBtn" type="submit">수정</button>
					<button class="btn btnRed btnBlock middleBtn contentsViewBtn" id="deleteBtn" type="button">삭제</button>
				</div>
			</sec:authorize>
			<div class="divBox">
				<div style="min-height: 300px;">
					<div class="right_area">
						<a href="javascript:;" class="icon heart" id="heart" style="text-decoration:none; color:inherit; cursor: pointer; float: left;">
							<img src="https://cdn-icons-png.flaticon.com/512/812/812327.png" id="favorites" alt="좋아요">
						</a>
						<span id="favoritesCount" style="float: initial; margin-left: 1%;">${favoritesCount}</span>
						<span style="float: right; font-size: 14px; color: gray;">${mainContents.mainContentsRegistrationDate}</span>
					</div>
					<div>${mainContents.mainContentsDetail}</div>
				</div>
			</div>
		</form>

		<div class="commentDiv">
			<c:forEach var="mainComments" items="${mainCommentsList}">
				<c:if test="${mainComments.mainCommentsDepth == 0}">
					<div class="commentView">
						<span id="mainCommentsKeyNum" style="display: none">${mainComments.mainCommentsKeyNum}</span>
						<span class="commentsName" id="mainCommentsName">${mainComments.mainCommentsName}</span>
						<span class="commentsDate" id="mainCommentsDate">${mainComments.mainCommentsDate}</span>
						<a class="commentsReply" id="mainCommentsReply" href="#!" onClick="mainCommentsReply(this);">답글</a>
						<div class="commentsUpdate">
							<a href="#!" onClick="mainCommentsUpdate(this);">···</a>
							<div class="commentsUpdateLink">
								<a href="#!" class="commentsUpdateA" onclick="updateComment(this);">수정</a> 
								<a href="#!" class="commentsUpdateA" onclick="deleteComment(this);">삭제</a>
							</div>
						</div>
						<p class="commentsContents" id="mainCommentsContents">${mainComments.mainCommentsContents}</p>
					</div>
				</c:if>
				<c:if test="${mainComments.mainCommentsDepth > 0}">
					<div class="commentAnswerView"
						style="margin-left: ${mainComments.mainCommentsDepth*5}%;">
						<span id="mainCommentsKeyNum" style="display: none">${mainComments.mainCommentsKeyNum}</span>
						<span class="commentsName" id="mainCommentsName">${mainComments.mainCommentsName}</span>
						<span class="commentsDate" id="mainCommentsDate">${mainComments.mainCommentsDate}</span>
						<a class="commentsReply" id="mainCommentsReply" href="#!"
							onClick="mainCommentsReply(this);">답글</a>
						<div class="commentsUpdate">
							<a href="#!" onClick="mainCommentsUpdate(this);">···</a>
							<div class="commentsUpdateLink">
								<a href="#!" class="commentsUpdateA"
									onclick="updateComment(this);">수정</a> <a href="#!"
									class="commentsUpdateA" onclick="deleteComment(this);">삭제</a>
							</div>
						</div>
						<p class="commentsContents" id="mainCommentsContents">${mainComments.mainCommentsContents}</p>
					</div>
				</c:if>
			</c:forEach>
		</div>

		<div>
			<form id="commentform" name="commentform" method="post">
				<input type="hidden" id="mainContentsKeyNum" name="mainContentsKeyNum" value="${mainContentsKeyNum}">
				<div class="comment-form">
					<div class="field">
						<input class="commentHead" type="text" name="mainCommentsName" placeholder="이름" value=""> 
						<input class="commentHead" type="password" name="mainCommentsPassword" maxlength="8" placeholder="비밀번호" value="">
					</div>

					<textarea class="commentBody" name="mainCommentsContents" cols="" rows="4" placeholder="여러분의 소중한 댓글을 입력바랍니다."></textarea>
					<div class="submit" style="height: 55px;">
						<div class="secret">
							<input type="checkbox" name="mainCommentsSecret" id="secret">
							<label>비밀글</label>
						</div>
						<button class="commentSend btn" type="button" id="btnComments">등록</button>
					</div>
				</div>
			</form>
		</div>
		<div>
			<a class="pageMove" href="<c:url value='/category/beforePageMove'/>?contentNumber=${mainContentsKeyNum}">＜ 이전글</a>
			<a class="pageMove" href="<c:url value='/category/nextPageMove'/>?contentNumber=${mainContentsKeyNum}" style="float: right">다음글 ＞</a>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>

	<div id="dialog-reply" title="답글달기" style='display: none'>
		<form id="commentReplyform" name="commentReplyform" method="post" onsubmit="return false">
			<input class="commentHeadDialog" type="text" name="mainCommentsNameDialog" placeholder="이름" value=""> 
			<input class="commentHeadDialog" type="password" name="mainCommentsPasswordDialog" maxlength="8" placeholder="비밀번호" value="">
			<textarea class="commentBodyDialog" name="mainCommentsContentsDialog" cols="" rows="4" placeholder="여러분의 소중한 댓글을 입력바랍니다."></textarea>
			<input type="checkbox" name="mainCommentsSecretDialog" id="secret">
			<label class="commentSecretDialog">비밀글</label>
		</form>
	</div>

	<div id="dialog-delete" title="댓글삭제" style='display: none'>
		<form id="commentDeleteform" name="commentDeleteform" method="post" onsubmit="return false">
			<input class="commentUpdateDialog" type="password" id="mainCommentsPasswordDeleteDialog" name="mainCommentsPasswordDialog" placeholder="비밀번호" value="">
		</form>
	</div>

	<div id="dialog-updateCheck" title="댓글 수정" style='display: none'>
		<form id="commentUpdateCheckform" name="commentUpdateCheckform" method="post" onsubmit="return false">
			<input class="commentUpdateDialog" type="password" id="mainCommentsPasswordUpdateDialog" name="mainCommentsPasswordDialog" placeholder="비밀번호" value="">
		</form>
	</div>

	<div id="dialog-update" title="답글 수정" style='display: none'>
		<form id="commentUpdateform" name="commentUpdateform" method="post" onsubmit="return false">
			<input class="commentHeadDialog" type="text" id="mainCommentsNameDialog" name="mainCommentsNameDialog" placeholder="이름" value="">
			<textarea class="commentBodyDialog" name="mainCommentsContentsDialog" cols="" rows="4" placeholder="여러분의 소중한 댓글을 입력바랍니다."></textarea>
			<input type="checkbox" name="mainCommentsSecretDialog" id="mainCommentsSecretDialog"> 
			<label class="commentSecretDialog">비밀글</label>
		</form>
	</div>
</body>
<script>
	$(function() {
		var $likeBtn =$('.icon.heart');
		if(${favoritesUsers}) {
			$likeBtn.toggleClass('active2');

	        if($likeBtn.hasClass('active2')) {
				$('#favorites').attr({
	            	'src': 'https://cdn-icons-png.flaticon.com/512/803/803087.png', alt:'좋아요 완료'
				});
	        }
		}
	});

	function mainCommentsReply(reply) {
		var mainCommentsKeyNum = reply.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		$('#dialog-reply').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); replaySubmit(mainCommentsKeyNum); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
	}
	
	function replaySubmit(mainCommentsKeyNum) {
		var postData = $('#commentReplyform').serializeArray();
		postData.push({name : "mainCommentsKeyNum", value : mainCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/category/mainCommentsReply'/>",
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
	        url: "<c:url value='/category/mainComments'/>",
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
	
	function mainCommentsUpdate(link) {
		if(link.nextElementSibling.style.display=="block") {
			link.nextElementSibling.style.display="none";
		} else {
			link.nextElementSibling.style.display="block";
		}
	}
	
	function updateComment(update) {
		var mainCommentsKeyNum = update.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		var mainCommentsName = update.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		$('#dialog-updateCheck').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); updateCheckSubmit(mainCommentsKeyNum,mainCommentsName); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
		$("#mainCommentsPasswordUpdateDialog").val("");
	}
	
	function updateCheckSubmit(mainCommentsKeyNum,mainCommentsName) {
		var postData = $('#commentUpdateCheckform').serializeArray();
		postData.push({name : "mainCommentsKeyNum", value : mainCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/category/mainCommentsUpdateCheck'/>",
	        async: false,
	        data: postData,
	        success: function (data) {
	        	if(data=="OK") {
					commentUpdate(mainCommentsKeyNum,mainCommentsName);
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
	
	function commentUpdate(mainCommentsKeyNum,mainCommentsName) {
		$('#dialog-update').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); updateSubmit(mainCommentsKeyNum); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
		$('#mainCommentsNameDialog').val(mainCommentsName);
	}
	
	function updateSubmit(mainCommentsKeyNum) {
		var postData = $('#commentUpdateform').serializeArray();
		postData.push({name : "mainCommentsKeyNum", value : mainCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/category/mainCommentsUpdate'/>",
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
		var mainCommentsKeyNum = del.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerText;
		$('#dialog-delete').dialog({
			modal: true, 
			buttons: {
				"확인": function() { $(this).dialog('close'); deleteSubmit(mainCommentsKeyNum); },
				"취소": function() { $(this).dialog('close'); },
			}
		});
		$("#mainCommentsPasswordDeleteDialog").val("");
	}
	
	function deleteSubmit(mainCommentsKeyNum) {
		var postData = $('#commentDeleteform').serializeArray();
		postData.push({name : "mainCommentsKeyNum", value : mainCommentsKeyNum});
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/category/mainCommentsDelete'/>",
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
		var mainContentsKeyNum = $('#mainContentsKeyNum').val();
		var topItemsName = "${mainContents.topItemsName}";
		var middleItemsName = "${mainContents.middleItemsName}";
		
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
				    url: "<c:url value='/category/delete'/>",
				    data: {"chkList":mainContentsKeyNum},
				    async: false,
				    success: function (data) {
				    	if(data == "OK"){
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '작업을 완료했습니다.',
							}).then(() => {
								location.replace("<c:url value='/category/"+topItemsName+"/"+middleItemsName+"'/>");
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
	
	$(function(){
	    var $likeBtn =$('.icon.heart');
	    var mainContentsKeyNum = $('#mainContentsKeyNum').val();

		$likeBtn.click(function() {
			$likeBtn.toggleClass('active2');
			var favoritesCount = $('#favoritesCount').text();

	        if($likeBtn.hasClass('active2')) {
	        	$('#favoritesCount').text(Number(favoritesCount)+1);
				$(this).find('img').attr({
	            	'src': 'https://cdn-icons-png.flaticon.com/512/803/803087.png', alt:'좋아요 완료'
				});
				$.ajax({
				    type: 'post',
				    url: "<c:url value='/category/favoritesPlus'/>",
				    data: {"mainContentsKeyNum": mainContentsKeyNum},
				    async: false,
				    success: function () {
				    }, 
				    error: function(error) {
						console.log(error);
					}
				});
			} else {
				$('#favoritesCount').text(Number(favoritesCount)-1); 
				$(this).find('i').removeClass('fas').addClass('far')
				$(this).find('img').attr({
					'src': 'https://cdn-icons-png.flaticon.com/512/812/812327.png',	alt:"좋아요"
	           })
	           $.ajax({
				    type: 'post',
				    url: "<c:url value='/category/favoritesMinus'/>",
				    data: {"mainContentsKeyNum": mainContentsKeyNum},
				    async: false,
				    success: function () {
				    }, 
				    error: function(error) {
						console.log(error);
					}
				});
			}
		})
	})
</script>

<style>
	.right_area .icon{
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    width: calc(50vw * (45 / 1920));
	    height: calc(50vw * (45 / 1920));
	    background-color: #fff;
	}
	
	.icon.heart img{
	    width: calc(80vw * (24 / 1920));
	    height: calc(80vw * (24 / 1920));
	}
	
	.icon.heart.fas{
	  color:red
	}
	.heart{
	    transform-origin: center;
	}
	.heart.active img{
	    animation: animateHeart .3s linear forwards;
	}
	
	@keyframes animateHeart{
	    0%{transform:scale(.2);}
	    40%{transform:scale(1.2);}
		100%{transform:scale(1);}
	}
</style>
</html>