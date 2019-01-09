<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {	
		var title = $("#title");
		title.focus();		
		console.log(CKEDITOR.instances['content'])

		var con = "${board.content}"
		CKEDITOR.instances['content'].setData(con);
		// 공백 시 submit X
		$("form").on("submit", function(e) {
			var cke = CKEDITOR.instances['content'].getData();
			if (title.val() == "") {
				alert("제목을 입력해 주십시오");
				title.focus();
				e.preventDefault();
			} else if (cke == "") {
				alert("내용을 입력해 주십시오");
				content.focus();
				e.preventDefault();
			}
		})

	})
</script>

<body>
	<form action="loginCheck/boardUpdate" method="post">
		<input type="hidden" name="bnum" value="${board.bnum}">
		<div>
			<table class="tbl" border="1">
				<tr>
					<th style="width: 10%">author</th>
					<td style="width: *"><input type="text" value="${board.author}" name="author" onfocus="this.blur()" readonly="readonly" ></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" value="${board.title}" name="title" id="title"></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="content" id="content" class="bcontent"></textarea></td>
				</tr>
			</table>
		</div>

		<div class="btnGroup">
			<a href="boardView?bnum=${board.bnum}"><button class="btn darkGray">취소</button></a>
			<button class="btn mint" type="submit">완료</button>
		</div>
	</form>
	<script>
		CKEDITOR.replace('content');
	</script>
</body>
</html>