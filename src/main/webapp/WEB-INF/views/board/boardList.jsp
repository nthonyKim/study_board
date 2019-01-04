<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	
	$(document).ready(function() {
		//검색
		$("#search").on("keypress", function(e) {
			if (e.which == 13) {
				$("form").attr("action", "boardSearch");
				$(this).submit();
			}
		})// 
		
		//페이징
		var record = $("#totalCount").val()
		var total = record / 8;

		console.log(record)
		if (record % 8 != 0)
			total = Math.floor(total);
		console.log(total)
		var curpage = $("#curpage").val();
		var paging = "";

		for (var i = 1; i <= total; i++) {
			console.log(i);
			if (i == curpage) {
				paging = paging + i + "&nbsp;&nbsp;";
			} else {
				paging = paging
						+ "<a href='/190101_board/boardList?currentPage="
						+ i + "'>" + i + "</a>&nbsp;&nbsp;";
			}
		}
		$("p").html(paging);

	})
</script>

<body>
	<div>
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
						<td><a class="aLink" href="boardView?bnum=${board.bnum}">${board.title}</a></td>
						<td class="alignC"><a class="aLink"
							href="boardSearchAuthor?author=${board.author}">${board.author}</a></td>
						<td class="small alignC">${board.readcnt}</td>
						<td class="small alignC">${board.regdate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="btnGroup">
		<a class="btn darkGray" href="boardList">전체글</a> <a class="btn mint"
			href="boardWrite">글쓰기</a>
	</div>
	<!-- 검색 버튼 추가할 것 -->
	<div class="alignC">
		<form>
			<input type="text" name="search" id="search" placeholder="검색어"
				style="margin-bottom: 14px">
		</form>
	</div>
	<input type="hidden" value="${page.totalCount}" id="totalCount">
	<input type="hidden" value="${page.currentPage}" id="curpage">
	<p class="underTable page">page</p>
</body>
</html>