<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>문의하기</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','questionView');
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div style="float: left; margin: 1%; width: 59%;">
		<div class="divBox">
			<div class="card">
				<div class="card-header">
					<h4>Successful IT Developer 관리자에게 요청사항 및 수정사항을 전달합니다.</h4>
					<h5 class="colorRed">회원 여러분의 소중한 의견을 듣고싶습니다. 사소한 문제라고 말씀해주시면 최대한 반영하여 적용 및 수정하겠습니다. <br>감사합니다.</h5>
				</div>
				<div class="card-block">
					<form class="form-material" id="form">
						<div class="form-group form-default">
							<input type="text" class="form-control" id="requestsTitle" name="requestsTitle" maxlength="50" required>
							<span class="form-bar"></span>
							<label class="float-label">제목 입력</label>
						</div>
						<div class="form-group form-default">
							<textarea class="form-control" id="requestsDetail" name="requestsDetail" required></textarea>
							<span class="form-bar"></span>
							<label class="float-label">여기에 내용을 입력 주세요.</label>
						</div>
					</form>
					<div class="requestsBtn">
						<button class="btn btn-darkgreen btn-block" id="sendBtn" style="height:30px; font-size: inherit;">문의하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
</html>