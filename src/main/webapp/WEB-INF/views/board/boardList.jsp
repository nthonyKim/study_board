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
		
		//페이징
		var record = "${page.totalCount}"
		var total = record / 8;
		var sea = "${searching.search}"
		var key = "${searching.keyWord}"
		var curpage = "${page.currentPage}";
		
		console.log(sea, key)
		if (record % 8 != 0)
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

	})
</script>

<body>
	<div id="bList">
		<table class="tbl" border="1">
			<thead>
				<tr>
					<th style="width: 10%">no</th>
					<th style="width: *">title</th>
					<th style="width: 10%">author</th>
					<th style="width: 10%">read</th>
					<th style="width: 10%">date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${page.list}" varStatus="status">
					<tr>
						<td class="small alignC">${board.bnum}</td>
						<td><a class="aLink" href="boardView?bnum=${board.bnum}">${board.title}</a>
						<c:if test="${board.commentCnt > 0}">
							<span class="xsmall">${board.commentCnt}</span>
						</c:if>
							</td>
						<td class="alignC">
 						<a class="aLink search">${board.author}</a>
							<%-- ${board.author} --%></td>
						<td class="small alignC">${board.readcnt}</td>
						<td class="small alignC">${board.regdate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	<div class="btnGroup">
		<a class="btn darkGray" href="boardList">전체글</a> 
		<a class="btn mint" href="boardWrite">글쓰기</a>
	</div>
	<!-- 검색 버튼 추가할 것 -->
	<div class="alignC">
			<form method="get">
			<div class="searchBox">
				<select name="search">
					<option selected="selected" value="author">글쓴이</option>
					<option value="title">제목</option>
					<option value="title_content">제목+내용</option>
				</select> <input type="text" name="keyWord" id="search" placeholder="검색어" style="margin-bottom: 14px">
			</div>
			</form>
		</div>
	<p class="underTable page">page</p>
	</div>
</body>
</html>