<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>회원 관리</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_Table.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','employee', { path: '/ITDeveloper'});
	    });
    </script>
    <script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/employee'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['사용자ID','사원명','이메일','상태','역할'],
				colModel:[
					{name:'employeeId', index:'employeeId', align:'center', width: 250, formatter: linkFormatter},
					{name:'employeeName', index:'employeeName',align:'center', width: 150},
					{name:'employeeEmail', index:'employeeEmail', width: 300, align:'center'},
					{name:'employeeStatus', index:'employeeStatus', align:'center', width: 150},
					{name:'usersRole', index:'usersRole', align:'center', width: 200},
				],
				jsonReader : {
		        	id: 'employeeId',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'employeeId', 	// 기본 정렬 
		        sortorder: 'asc',			// 정렬 방식
		        
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
		<form id="form" name="form" method ="post">
			<div class="divBox" >
			    <div class="col-lg-2">
			    	<label class="labelFontSize">사용자ID</label>
					<input type="text" id="employeeId" name="employeeId" class="formControl seachInput"> 
			    </div>
			    <div class="col-lg-2">
			    	<label class="labelFontSize">사원명</label>
			    	<input type="text" id="employeeName" name="employeeName" class="formControl seachInput">
			    </div>
			    <div class="col-lg-2">
			    	<label class="labelFontSize">이메일</label>
			    	<input type="text" id="employeeEmail" name="employeeEmail" class="formControl seachInput">
			    </div>
			    <div class="col-lg-2">
			    	<label class="labelFontSize">상태</label>
			    	<select class="formControl selectpicker seachInput" id="employeeStatus" name="employeeStatus" style="height: 34px; width: 98%;" data-live-search="true" data-size="5">
						<option value=""></option>
						<option value="정상">정상</option>
						<option value="제한">제한</option>
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
			<div style="width: 100%; height: 35px;">
				<button class="btn btnDarkgreen btnBlock middleBtn" type="button" style="width: 100px; border-radius: 5px;" onClick="btnLoginLimit();">로그인 제한</button>
				<button class="btn btnRed btnBlock middleBtn" type="button" style="width: 100px;" onClick="btnDelete();">탈퇴</button>
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
			return '<a onclick="updateView('+"'"+rowdata.employeeId+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		function updateView(employeeId) {
			let f = document.createElement('form');
		    
		    let obj;
		    obj = document.createElement('input');
		    obj.setAttribute('type', 'hidden');
		    obj.setAttribute('name', 'employeeId');
		    obj.setAttribute('value', employeeId);
		    
		    f.appendChild(obj);
		    f.setAttribute('method', 'post');
		    f.setAttribute('action', "<c:url value='/employeeView'/>");
		    document.body.appendChild(f);
		    f.submit();
		}
		
		function btnLoginLimit() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/employee/loginLimit'/>",
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
					  text: "회원 탈퇴 진행하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: '예'
				}).then((result) => {
					if (result.isConfirmed) {
						$.ajax({
				            type: 'POST',
				            url: "<c:url value='/employee/delete'/>",
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
			$("input[type='hidden']").val("");
			$("select").each(function(index){
				$("option:eq(0)",this).prop("selected",true);
			});
			tableRefresh();
		});
		
		$('#btnSearch').click(function() {
			tableRefresh();
		});
	</script>
</html>