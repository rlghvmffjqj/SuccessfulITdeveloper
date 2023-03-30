<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>문의내역</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_Table.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','requestsList', { path: '/ITDeveloper'});
	    });
    </script>
    <script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/requests'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','사용자ID','사원명','제목','상태','날짜'],
				colModel:[
					{name:'requestsKeyNum', index:'requestsKeyNum', align:'center', width: 40, hidden:true },
					{name:'employeeId', index:'employeeId', align:'center', width: 100, formatter: linkFormatter},
					{name:'employeeName', index:'employeeName', align:'center', width: 70},
					{name:'requestsTitle', index:'requestsTitle', align:'center', width: 200},
					{name:'requestsState', index:'requestsState',align:'center', width: 80},
					{name:'requestsDate', index:'requestsDate',align:'center', width: 150},
				],
				jsonReader : {
		        	id: 'requestsKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'requestsKeyNum', 		// 기본 정렬 
		        sortorder: 'desc',			// 정렬 방식
		        
		        multiselect: true,			// 체크박스를 이용한 다중선택
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: true,				// 컬럼을 마우스 순서 변경
		        height : '670',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: false,			// 컬럼 폭 고정값 유지
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
				<sec:authorize access="hasRole('ADMIN')">
				    <div class="col-lg-2">
				    	<label class="labelFontSize">사용자ID</label>
						<input type="text" id="employeeId" name="employeeId" class="formControl seachInput"> 
				    </div>
			    </sec:authorize>
			    <div class="col-lg-2">
			    	<label class="labelFontSize">제목</label>
			    	<input type="text" id="requestsTitle" name="requestsTitle" class="formControl seachInput">
			    </div>
			    <div class="col-lg-2">
			    	<label class="labelFontSize">상태</label>
			    	<select class="formControl selectpicker seachInput selectInput" id="requestsState" name="requestsState"  data-size="5">
						<option value=""></option>
						<option value="전송">전송</option>
						<option value="답변">답변</option>
					</select>
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
			<sec:authorize access="hasAnyRole('ADMIN')">
				<div style="width: 100%; height: 35px;">
					<button class="btn btnRed btnBlock middleBtn" type="button" onClick="btnDelete();">삭제</button>
				</div>
			</sec:authorize>
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
		return '<a onclick="updateView('+"'"+rowdata.requestsKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}
	
	function updateView(requestsKeyNum) {
		let f = document.createElement('form');
	    
	    let obj;
	    obj = document.createElement('input');
	    obj.setAttribute('type', 'hidden');
	    obj.setAttribute('name', 'requestsKeyNum');
	    obj.setAttribute('value', requestsKeyNum);
	    
	    f.appendChild(obj);
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', "<c:url value='/requestsView'/>");
	    document.body.appendChild(f);
	    f.submit();
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
	
	function btnDelete() {
		var chkList = $("#list").getGridParam('selarrrow');
		if(chkList == 0) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '선택한 행이 존재하지 않습니다.',    
			});    
		} else {
			Swal.fire({
				  title: '삭제!',
				  text: "문의 내용 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
			            type: 'POST',
			            url: "<c:url value='/requests/delete'/>",
			            data: {
							chkList: chkList
						},
			            dataType: "json",
						async: false,
						traditional: true,
			            success: function (data) {
			            	if(data.result == "OK"){
								Swal.fire({
									icon: 'success',
									title: '성공!',
									text: '작업을 완료했습니다.',
								});
								tableRefresh();
							} else{
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '작업을 실패하였습니다.',
								});
							}
			            },
			            error: function(e) {
			                // TODO 에러 화면
			            }
			        });
				}
			})
		}
	}
</script>
</html>