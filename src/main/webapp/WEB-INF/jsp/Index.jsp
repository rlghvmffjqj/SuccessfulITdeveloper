<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="google-site-verification" content="xIWfFJYp6uIejvm5HdDdwyVmWPR5pIbvKzCW11YVaQA" />
	<title>IT Developer</title>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
	    $(function() {
	    	$.cookie('name','index', { path: '/ITDeveloper'});
	    });
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
	<%@ include file="/WEB-INF/jsp/common/_RightMenu.jsp"%>
	<div>
		<div id="index_main_title" style="height: 160px; width: 100%; border-bottom: 3px solid #76AA9D; background: #f2ffee;">
			<div style="padding-top: 15px; padding-left: 25%; font-family: math;">
				<h3>공부하지 않으면 걱정만 불어나고,</h3>
			</div>
			<div style="padding-top: 5px; padding-left: 40%; font-family: math;">
				<h3>실천하지 않으면 발전하지 않는다.</h3>
			</div>
		</div>
		<div id="index_list" style="height: auto; width: 100%; text-align: center; margin-top: 1%;">
			<div>
				<a class="index_list">전체 글 (${mainContentsCount})</a>
			</div>

			<c:forEach var='mainContents' items='${mainContentsList}'>
				<div class="index_div">
					<a class="index_link" href="<c:url value='/category/${mainContents.topItemsName}/${mainContents.middleItemsName}'/>">
						<strong class="index_title">${mainContents.mainContentsTitle}</strong>
						<p class="index_txt">${mainContents.mainContentsDetail}</p>
					</a>
					<a href="<c:url value='/category/${mainContents.topItemsName}/${mainContents.middleItemsName}'/>" class="index_link">${mainContents.middleItemsName}</a>
					<span class="index_bar">${mainContents.mainContentsDate}</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	
</script>

<style>
	.index_div{
		margin-top: 1%;
    	text-align: left;
    	margin-left: 25%;
    	margin-right: 25%;
		border-bottom: 1px solid #ebebeb;
    	padding-bottom: 2%;
	}

	.index_list {
		font-size: 20px;
    	font-weight: bold;
    	color: #3db39e;
	}

	.index_title {
		display: block;
    	font-weight: normal;
    	font-size: 28px;
    	text-overflow: ellipsis;
    	overflow: hidden;
    	white-space: nowrap;
		color: black;
	}

	.index_link:hover .index_title {
		text-decoration: underline;
    	color: #3db39e;
	}

	.index_txt {
		display: -webkit-box;
    	display: -ms-flexbox;
    	display: box;
    	overflow: hidden;
    	max-height: 80px;
    	margin-top: 1px;
    	font-size: 16px;
    	line-height: 28px;
    	color: #666;
    	vertical-align: top;
    	word-break: break-all;
    	-webkit-box-orient: vertical;
    	-webkit-line-clamp: 3;
	}

	.index_link {
		font-size: 12px;
    	text-decoration: none;
    	color: #3db39e;
	}

	.index_bar {
		display: inline-block;
    	width: 140px;
    	font-size: 12px;
    	margin: 0 5px;
	}
</style>
</html>