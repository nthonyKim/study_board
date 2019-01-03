<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mod").on("click", function() {
			var num = $(this).attr("data-bnum");
			location.href = "boardUpdate?bnum=" + num;
		})

		$("#del").on("click", function(e) {
			var txt = confirm("삭제하시겠습니까?");
			if (txt == true) {
				var num = $(this).attr("data-bnum");
				location.href = "boardDelete?bnum=" + num;
			} else {
				e.preventDefault();
			}

		})

	})
</script>

<body>
	<div>
		<table class="tbl" border="1">

			<tr>
				<td style="width: 10%"><span class="small">${board.bnum}</span></td>
				<td style="width: *"><span><a class="alignC aLink bold"
						href="boardView?bnum=${board.bnum}">${board.title}</a></span></td>
			</tr>
			<tr>
				<td><a class="aLink small"
					href="boardSearch?author=${board.author}">${board.author}</a></td>
				<td class="alignR small">${board.readcnt} ${board.regdate}</td>
			</tr>
			<tr>
				<td colspan="2">
					<!-- 엔터 치환 --> <% pageContext.setAttribute("br", "\n"); %>
					<div class="bcontent">${fn:replace(board.content, br, "<br/>")}</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="btnGroup">
		<a class="btn darkGray underTable" href="boardList">목록</a>
		<a class="btn darkGray underTable" data-bnum="${board.bnum}" id="mod">수정</a> 
		<a class="btn darkGray underTable" data-bnum="${board.bnum}" id="del">삭제</a>
	</div>
</body>
</html>