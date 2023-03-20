<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>IT Developer</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_Table.jsp"%>
	<script>
	    $(function() {
	    	$.removeCookie('name', {path:'/ITDeveloper'});
    		$.cookie('name',"${topItemsName}"+","+"${middleItemsName}", { path: '/ITDeveloper'});
	    });
    </script>
    <script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/category'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['키','제목','등록자','등록일'],
				colModel:[
					{name:'mainContentsKeyNum', index:'mainContentsKeyNum',align:'center', width: 50, hidden:true},
					{name:'mainContentsTitle', index:'mainContentsTitle', align:'center', width: 500, formatter: linkFormatter},
					{name:'mainContentsRegistrant', index:'mainContentsRegistrant',align:'center', width: 150},
					{name:'mainContentsRegistrationDate', index:'mainContentsRegistrationDate', width: 150, align:'center'},
				],
				jsonReader : {
		        	id: 'mainContentsKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'mainContentsKeyNum', 	// 기본 정렬 
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
		    jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() - $(".departmentTable").width() - 10);
		});
	</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div class="mainDiv">
		<form id="form" name="form" method ="post" action="<c:url value='/category/categoryWrite'/>">
			<input type="hidden" id="topItemsName" name="topItemsName" class="form-control" value="${topItemsName}">
			<input type="hidden" id="middleItemsName" name="middleItemsName" class="form-control" value="${middleItemsName}">
			<div class="divBox" >
			    <div class="col-lg-2">
			    	<label class="labelFontSize">제목</label>
					<input type="text" id="mainContentsTitle" name="mainContentsTitle" class="formControl seachInput">
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
		
			<div style="width: 100%; height: 15px;"></div>
			<div class="divBox">
				<sec:authorize access="hasRole('ADMIN')">
					<div style="width: 100%; height: 35px;">
						<button class="btn btnBlue btnBlock middleBtn" type="submit" style="width: 100px;">게시물 등록</button>
						<button class="btn btnRed btnBlock middleBtn" type="button" style="width: 100px;" onClick="btnDelete();">게시물 삭제</button>
					</div>
				</sec:authorize>
				<div class="jqGrid_wrapper">
					<table id="list"></table>
					<div id="pager"></div>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>
	<script>
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a href="#!" onclick="mainContentsView('+"'"+rowdata.mainContentsKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		function mainContentsView(mainContentsKeyNum) {
			location.href="<c:url value='/category/mainContentsView'/>?contentNumber="+mainContentsKeyNum;
		}
		
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
				            type: 'POST',
				            url: "<c:url value='/category/delete'/>",
				            data: {
								chkList: chkList
							},
				            dataType: "text",
							async: false,
							traditional: true,
				            success: function (data) {
				            	if(data == "OK"){
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
		
		function tableRefresh() {
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$("select").each(function(index){
				$("option:eq(0)",this).prop("selected",true);
			});
			tableRefresh();
		});
		
		$('#btnSearch').click(function() {
			tableRefresh();
		});
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
				event.preventDefault();
			}
		});
		
	</script>
</html>