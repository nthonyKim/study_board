<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">	
	$(document).ready(function() {
		//검색
		$("#search").on("keypress", function(e) {
			if (e.which == 13) {
				$("form").attr("action", "boardList");
				$(this).submit();
			}
		})//  
		
		var temp = $("#bnum${board.bnum}");
		$(temp).removeClass("aLink");
		$(temp).addClass("highlight");
		
		//페이징
		//세션에 저장하여 관리		
		function paging(){
			var record = "${page.totalCount}"
			var curpage = "${page.currentPage}";
			var sea = "${searching.search}"
			var key = "${searching.keyWord}"
			var total = record / 12;
			
			console.log(sea, key)
			if (record % 12 != 0)
				total = Math.ceil(total);
			console.log(total)
			var paging = "";
	
			for (var i = 1; i <= total; i++) {
				console.log(i);
				if (i == curpage) {
					paging = paging + i + "&nbsp;&nbsp;";
				} else if(sea != "" || key != ""){
					paging = paging
					+ "<a href='/190101_board/boardList?search="+sea+"&keyWord="+key+"&currentPage=" + i + "'>" + i + "</a>&nbsp;&nbsp;";
				} else{
					paging = paging
							+ "<a href='/190101_board/boardList?currentPage=" + i + "'>" + i + "</a>&nbsp;&nbsp;";
				}
			}
			$(".page").html(paging);
		}
		paging();

	})
</script>
	<div id="bList">
		<table class="tbl" border="1">
			<thead>
				<tr>
					<th style="width: 10%">no</th>
					<th style="width: *">title</th>
					<th style="width: 15%">author</th>
					<th style="width: 10%">read</th>
					<th style="width: 12%">date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bd" items="${page.list}" varStatus="status">
					<tr>
						<td class="alignC">${bd.bnum}</td>
						<td><c:choose>
								<c:when test="${bd.pub == 'y' }">									
									<a class="aLink" href="boardView?bnum=${bd.bnum}" id="bnum${bd.bnum}">${bd.title}</a>
								</c:when>
								<c:when test="${bd.pub == 'n' }">
									<c:choose>
										<c:when test="${user.userid eq 'admin' || user.username eq bd.author}">
											<a class="aLink" href="boardView?bnum=${bd.bnum}">${bd.title}</a>
										</c:when>
										<c:otherwise>
										<span class="" style="color: #ddd">관리자와 작성자만 볼 수 있는 게시글 입니다.</span>
										</c:otherwise>
									</c:choose>
								</c:when>
							</c:choose> 
							<c:if test="${bd.commentCnt > 0}">
								<span class="highlight xsmall">${bd.commentCnt}</span>
							</c:if></td>
						<td class="alignC"><%-- <a class="aLink search">${board.author}</a> --%>
							${bd.author}</td>
						<td class="alignC">${bd.readcnt}</td>
						<td class="alignC">${bd.regdate}</td>
					</tr>
					
				</c:forEach>
			</tbody>
		</table>
		
	<div class="btnGroup" style=" float: right;">
		<a class="btn darkGray" href="boardList">전체글</a> 
		<a class="btn mint" href="loginCheck/boardWrite">글쓰기</a>
	</div>
	<!-- 검색 -->
	<div class="alignC underTable">
			<form method="get">
			<div class="searchBox">
				<select name="search">
					<option selected="selected" value="author">글쓴이</option>
					<option value="title">제목</option>
					<option value="title_content">제목+내용</option>
				</select> 
				<input type="text" name="keyWord" id="search" placeholder="검색어" style="margin-bottom: 14px" maxlength="10">
				<!-- <img src="images/icon/search.png" style="padding-top: 2px"> -->
				<button type="submit" class="none"><img src="images/icon/search.png" style="top: 3px; left: 10px; position: relative; opacity: 0.5;"></button>
			</div>
			</form>
		</div>
	<p class="underTable page">page</p>	
	</div>
	