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
				<span class="index_lesson">공부하지 않으면 걱정만 불어나고,</span>
			</div>
			<div style="padding-top: 5px; padding-left: 40%; font-family: math;">
				<span class="index_lesson">실천하지 않으면 발전하지 않는다.</span>
			</div>
		</div>
		<div id="index_list" style="height: auto; width: 100%; text-align: center; margin-top: 1%;">
			<div style="margin: 20px;">
				<a class="index_list">전체 글 (${mainContentsCount})</a>
			</div>

			<c:forEach var='mainContents' items='${mainContentsList}'>
				<div class="index_div">
					<c:if test="${mainContents.mainContentsImg != '' && mainContents.mainContentsImg != null}">
						<a class="thumbnail_post" href="<c:url value='/category/mainContentsView?contentNumber=${mainContents.mainContentsKeyNum}'/>">
							${mainContents.mainContentsImg}
						</a>	
					</c:if>
					<c:if test="${mainContents.mainContentsImg == '' || mainContents.mainContentsImg == null}">
						<a class="thumbnail_post" href="<c:url value='/category/mainContentsView?contentNumber=${mainContents.mainContentsKeyNum}'/>">
							<img class="index_contentImg" src="<c:url value='/images/developer.png' />">
						</a>	
					</c:if>
					<a class="index_link" href="<c:url value='/category/mainContentsView?contentNumber=${mainContents.mainContentsKeyNum}'/>">
						<strong class="index_title">${mainContents.mainContentsTitle}</strong>
						<p class="index_txt">${mainContents.mainContentsDetail}</p>
					</a>
					<a href="<c:url value='/category/${mainContents.topItemsName}/${mainContents.middleItemsName}'/>" class="index_link">${mainContents.middleItemsName}</a>
					<span class="index_bar">${mainContents.mainContentsDate}</span>
				</div>
			</c:forEach>
			<div>
				<div class="index_paging index_paging_list">
					<span class="inner_paging">
						<c:choose>
							<c:when test="${page > 1}">
								<a class="ico_skin link_prev link_a" href="/ITDeveloper/index?page=${page - 1}" style="color: black;">이전</a>
							</c:when>
							<c:otherwise>
								<span class="ico_skin link_prev" style="color: gray;">이전</span>
							</c:otherwise>
						</c:choose>

						<c:forEach begin="${startPage}" end="${endPage}" varStatus="i">
							<c:if test="${i.index == page}">
								<a class="link_page" href="/ITDeveloper/index?page=${i.index}"><span class="selected">${i.index}</span></a>
							</c:if>
        				    <c:if test="${i.index != page}">
								<a class="link_page" href="/ITDeveloper/index?page=${i.index}"><span class="">${i.index}</span></a>
							</c:if>
        				</c:forEach>

						<c:choose>
							<c:when test="${not empty mainContentsList && mainContentsList.size() == size}">
								<a class="ico_skin link_next link_a" href="/ITDeveloper/index?page=${page + 1}" style="color: black;">다음</a>
							</c:when>
							<c:otherwise>
								<span class="ico_skin link_next" style="color: gray;">다음</span>
							</c:otherwise>
						</c:choose>
					</span>
				</div>				
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/_FooterMenu.jsp"%>
</body>

<script>
	$(function() {
		$(".thumbnail_post > img").css("cssText", "");
		$(".thumbnail_post > img").addClass("index_contentImg");
	})
</script>

<style>
	.index_link:hover .index_title {
		text-decoration: underline;
    	color: #3db39e;
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

	.index_paging {
	    margin: 30px 0 93px;
	    text-align: center;
	}

	.index_paging .inner_paging {
	    display: inline-block;
	    overflow: hidden;
	}
	.index_paging {
	    margin: 30px 0 93px;
	    text-align: center;
	}

	.index_paging .no-more-prev {
	    background-position: 0 -75px;
	}
	.index_paging .link_prev {
	    margin-right: 20px;
	    background-position: 0 -100px;
	}
	.index_paging .ico_skin {
	    float: left;
	    width: 40px;
	    height: 24px;
	    margin-top: 10px;
	}
	

	.index_paging .link_page {
	    float: left;
	}

	.index_paging .link_next {
	    margin-left: 20px;
	    background-position: 0 -150px;
	}

	.index_paging .link_page span.selected {
	    border-radius: 3px;
	    background-color: #3db39e;
	    color: #fff;
	    font-weight: bold;
	    padding: 8px 14px 6px;
	}
	.index_paging .link_page span {
	    display: block;
	    padding: 9px 14px 5px;
	    color: #666;
	}

	.link_page:hover {
    	text-decoration: underline;
	}

	.link_a:hover {
    	text-decoration: underline;
	}

	

</style>
</html>