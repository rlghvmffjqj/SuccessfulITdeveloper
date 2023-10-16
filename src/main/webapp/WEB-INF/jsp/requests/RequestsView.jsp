<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>문의내역</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" method ="post">
			<div class="divBox" >
				<div class="requestsViewTitle">문의 내역 상세</div>
				<div style="width:100%; margin-top: 20px; border-top: 5px solid #adadad; border-bottom: 5px solid #adadad; height: 130px; background: #F6F7F9;">
					<div class="requestsViewSubTitle"><span>제목</span></div>
					<div class="requestsViewSubDetail"><span class="width90">${requests.requestsTitle}</span></div>
					<div class="requestsViewLine"></div>
					<div class="requestsViewSubTitle"><span>작성자ID</span></div>
					<div class="requestsViewSubDetail"><span class="width90">${requests.employeeId}</span></div>
					<div class="requestsViewLine"></div>
					<div class="requestsViewSubTitle"><span>상태</span></div>
					<div class="requestsViewSubDetail"><span class="width90">${requests.requestsState}</span></div>
					<div class="requestsViewLine"></div>
					<div class="requestsViewSubTitle"><span>날짜</span></div>
					<div class="requestsViewSubDetail"><span class="width90">${requests.requestsDate}</span></div>
				</div>
				<div style="width: 100%;">
					<article class="formControl seachInput" style="padding-top: 5px; width: 98%; margin-top: 10px; height:350px; border: 0;">${requests.requestsDetail}</article>
				</div>
				<div style="width:100%; height:35px;"></div>
				<div class="requestsViewLine"></div>
				<c:forEach var="answer" items="${requestscomment}">
					<div class="requestsViewAnswer">
						<div>
							<span style="font-weight: bold;">
								<c:if test="${answer.requestsCommentRegistrant eq 'admin'}">관리자</c:if>
								<c:if test="${answer.requestsCommentRegistrant ne 'admin'}">${answer.requestsCommentRegistrant}</c:if>
							</span>
							<span style="font-size:13px; float:right">${answer.requestsCommentDate}</span>
						</div>
						<div>
							<span>${answer.requestsCommentDetail}</span>
						</div>
					</div>
					<div class="requestsViewLine"></div>
				</c:forEach>
				<div>					
					<textarea class="formControl" style="margin-top: 10px; width: 90%; height: 50px; float:left; padding: 5px;" id="requestsCommentDetail" placeholder="답변내용"></textarea>
					<button class="btn btnDarkgreen" type="button" style="margin-top: 10px; width: 8%; height: 63px;" onClick="answerBtn();">답변하기</button>
				</div> 
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
<script>
	function answerBtn() {
		var requestsCommentDetail = $('#requestsCommentDetail').val();
		var requestsKeyNum = ${requests.requestsKeyNum};
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/requestsComment/insert'/>",
		    data: {
		    	"requestsCommentDetail" : requestsCommentDetail,
		    	"requestsKeyNum" : requestsKeyNum
		    },
		    async: false,
		    success: function (data) {
		    	if(data == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '답변 완료 되었습니다.',
					}).then((result) => {
						location.reload();
					});
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
	}
</script>
<style>
	.requestsViewLine {
		background:#cfcfcf; 
		width: 100%; 
		height:1px; 
		float: left;
	}
	
	.requestsViewTitle {
		width: 100%;
	    height: 35px;
	    text-align: center;
	    padding-top: 10px;
	    background: #adadad;
	    color: black;
	    font-weight: bold;
	    font-size: 20px;
	}
	
	.requestsViewSubTitle {
		margin:5px; 
		float: left; 
		width:10%
	}
	
	.requestsViewSubDetail {
		margin:5px; 
		float: left; 
		margin-left: 10%;
	}
	
	.requestsViewAnswer {
	    padding-top: 15px;
	    padding-bottom: 15px;
	    width: 100%;
	    height: 100%;
	}

</style>
</html>