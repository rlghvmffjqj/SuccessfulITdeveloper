<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>자유게시판</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_Table.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','freeBoardList', { path: '/ITDeveloper'});
	    });
    </script>
    <script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/freeBoard'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','제목','등록자','등록일','조회수'],
				colModel:[
					{name:'freeBoardKeyNum', index:'freeBoardKeyNum', align:'center', width: '5%', hidden:true },
					{name:'freeBoardTitle', index:'freeBoardTitle', align:'center', width: '50%', formatter: linkFormatter},
					{name:'freeBoardUserId', index:'freeBoardUserId', align:'center', width: '15%'},
					{name:'freeBoardDate', index:'freeBoardDate',align:'center', width: '20%'},
					{name:'freeBoardCount', index:'freeBoardCount', align:'center', width: '15%'},
				],
				jsonReader : {
		        	id: 'freeBoardKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'freeBoardKeyNum', 		// 기본 정렬 
		        sortorder: 'desc',			// 정렬 방식
		        
		        <sec:authorize access="hasRole('ADMIN')">
		        	multiselect: true,			// 체크박스를 이용한 다중선택
		        </sec:authorize>
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: true,				// 컬럼을 마우스 순서 변경
		        height : '670',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: true,			// 컬럼 폭 고정값 유지
		        altRows: false,				// 라인 강조
			}); 
	 	});
		
		$(window).on('resize.list', function () {
			jQuery("#list").jqGrid( 'setGridWidth', $(".mainDiv").width() - 30 );
		});
	</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" method ="post">
			<div class="divBox" >
			    <div class="col-lg-2">
			    	<label class="labelFontSize">제목</label>
			    	<input type="text" id="freeBoardTitle" name="freeBoardTitle" class="formControl seachInput">
			    </div>
			    <div class="col-lg-2">
			    	<label class="labelFontSize">등록자</label>
			    	<input type="text" id="freeBoardUserId" name="freeBoardUserId" class="formControl seachInput">
			    </div>
			    <div class="col-lg-12">
			    	<button class="btn btnDefault btnm" type="button" id="btnReset" style="float: right">
						<span>초기화</span>
					</button>
					<button class="btn btnDarkgreen btnm" type="button" id="btnSearch" style="float: right">
						<span>검색</span>
					</button>
				</div>
			</div>
		</form>
		<div style="width: 100%; height: 15px;"></div>
		<div class="divBox">
			<div style="width: 100%; height: 35px;">
				<sec:authorize access="isAuthenticated()">
					<button class="btn btnBlue btnBlock middleBtn" type="button" onClick="btnInsert();">등록</button>
				</sec:authorize>
			</div>
			<div class="jqGrid_wrapper">
				<table id="list"></table>
				<div id="pager"></div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
<script>
	/* =========== jpgrid의 formatter 함수 ========= */
	function linkFormatter(cellValue, options, rowdata, action) {
		return '<a onclick="freeBoardView('+"'"+rowdata.freeBoardKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}
	
	function freeBoardView(freeBoardKeyNum) {
		location.href="<c:url value='/freeBoard/freeBoardView'/>?contentNumber="+freeBoardKeyNum;
	}
	
	/* =========== 검색 ========= */
	$('#btnSearch').click(function() {
		tableRefresh();
	});
	
	/* =========== 테이블 새로고침 ========= */
	function tableRefresh() {
		var jqGrid = $("#list");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: $("#form").serializeObject() });
		jqGrid.trigger('reloadGrid');
	}
	
	/* =========== Enter 검색 ========= */
	$("input[type=text]").keypress(function(event) {
		if (window.event.keyCode == 13) {
			tableRefresh();
		}
	});
	
	/* =========== 검색 초기화 ========= */
	$('#btnReset').click(function() {
		$("input[type='text']").val("");
		$("input[type='date']").val("");
        
        $('.selectpicker').val('');
        $('.filter-option-inner-inner').text('');
		tableRefresh();
	});
	
	/* =========== Select Box 선택 ========= */
	$("select").change(function() {
		tableRefresh();
	});
	
	function btnInsert() {
		location.href = "<c:url value='/freeBoard/freeBoardWrite'/>";
	}
	
</script>
</html>