<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {	
		var title = $("#title");
		title.focus();		

		// 공백 시 submit X
		$("form").on("submit", function(e) {
			var content = $("#content");

			if (title.val() == "") {
				alert("제목을 입력해 주십시오");
				title.focus();
				e.preventDefault();
			} else if (content.val() == "") {
				alert("내용을 입력해 주십시오");
				content.focus();
				e.preventDefault();
			}
		})

	})
</script>

<body>
		<form action="boardUpdate" method="post">
		<input type="hidden" name="imgName" value="null" id="imgName">
	<div>
			<table class="tbl" border="1">
				<tr>				
					<th style="width: 10%">author</th>
					<td style="width: *">${board.author}</td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" value="${board.title}" name="title" id="title"></td>
				</tr>

				<tr>
					<td colspan="2"><textarea name="content" id="content" class="bcontent">${board.content}</textarea></td>
				</tr>
			</table>
	</div>

	<div class="btnGroup">
		<a class="btn darkGray underTable" href="boardView?bnum=${board.bnum}">취소</a>		
		<button class="btn yellow" type="submit">완료</button>
	</div>
		</form>
</body>
</html>