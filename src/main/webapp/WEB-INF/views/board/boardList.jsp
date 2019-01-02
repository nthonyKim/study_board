<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						//충격과 공포의 페이징
						var record = $("#totalCount").val()
						var total = record / 8;
						if (record % 8 != 0)
							total = Math.ceil(total);
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
						console.log(paging);
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
					<th style="width: 20%">date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${page.list}" varStatus="status">
					<tr>
						<td class="small">${board.bnum}</td>
						<td><a class="aLink" href="boardView?bnum=${board.bnum}">${board.title}</a></td>
						<td><a class="aLink" href="boardSearch?author=${board.author}">${board.author}</a></td>
						<td class="small">${board.readcnt}</td>
						<td class="small">${board.regdate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="btnGroup">
		<a class="btn yellow" href="boardWrite">write</a>
	</div>
	<input type="hidden" value="${page.totalCount}" id="totalCount">
	<input type="hidden" value="${page.currentPage}" id="curpage">
	<p class="underTable page">page</p>
</body>
</html>