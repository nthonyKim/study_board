<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		CKEDITOR.replace( 'content' );
		var cke = CKEDITOR.instances['content'];
	
	 cke.on('key', function(e) {
		 console.log(cke.getData().length)
			var deleteKey = 46;
			var backspaceKey = 8;
			var keyCode = e.data.keyCode;
			if (keyCode === deleteKey || keyCode === backspaceKey) {
				return true;
			} else {
				var str = CKEDITOR.instances.content.getData();
				if (str.length >= 3000){
					alert("내용이 너무 깁니다")
					return false;
				}
			}
		}); 

		//공백 시 submit X
		$("form").on("submit", function(e) {
			var title = $("#title");
			var author = $("#author");
			if (title.val() == "") {
				alert("제목을 입력하세요");
				title.focus();
				e.preventDefault();
			} else if (author.val() == "") {
				alert("글쓴이를 입력하세요");
				author.focus();
				e.preventDefault();
			} else if (cke.getData() == "") {
				alert("내용을 입력하세요");
				content.focus();
				e.preventDefault();
			} else if (cke.getData().length >= 3000) {
				alert("내용이 너무 깁니다");
				e.preventDefault();
			}
		})

	})
</script>

<body>
		<form action="loginCheck/boardWrite" method="post" enctype="multipart/form-data">
	<div>
			<table class="tbl" border="1">
				<tr>
					<th style="width: 10%">public</th>
					<td style="width: *" class="small">공개<input type="radio" value="y" checked="checked" name="pub"> 
						비공개<input type="radio" value="n" name="pub">
						<span>선택하지 않는 경우 자동으로 공개처리 됩니다.</span></td>
				</tr>
				<tr>
					<th>author</th>
					<td><input type="text" name="author" id="author" value="${user.username}" onfocus="this.blur()" readonly="readonly" ></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" id="title" placeholder="제목을 입력하세요" maxlength="30"></td>
				</tr>

				<tr>
					<td colspan="2"><textarea name="content" id="content" class="bcontent" maxlength="3000"></textarea></td>
				</tr>
				<tr>
				<td colspan="2">
					<input type="file" name="theFile" multiple="multiple"></td>
				</tr>
			</table>
	</div>

	<div class="btnGroup underTable">
		<a href="boardList"><button class="btn darkGray" type="button">취소</button></a>
		<button class="btn mint" type="submit">완료</button>
	</div>
		</form>
	
</body>
</html>