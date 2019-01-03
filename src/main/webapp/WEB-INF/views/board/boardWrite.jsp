<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		//���� �� submit X
		$("form").on("submit", function(e) {		
			var title = $("#title");
			var author = $("#author");
			var content = $("#content");
						
			if (title.val() == "") {
				alert("������ �Է��� �ֽʽÿ�");
				title.focus();
				e.preventDefault();
			}else if(author.val() == ""){
				alert("�۾��̸� �Է��� �ֽʽÿ�");
				author.focus();
				e.preventDefault();
			}else if(content.val() == ""){
				alert("������ �Է��� �ֽʽÿ�");
				content.focus();
				e.preventDefault();
			}
		})
		
	})
</script>

<body>
		<form action="boardWrite" method="post">
		<input type="hidden" name="imgName" value="null" id="imgName">
	<div>
			<table class="tbl" border="1">
				<tr>
					<th style="width: 10%">public</th>
					<td style="width: *">����<input type="radio" value="y" checked="checked" name="pub"> 
						�����<input type="radio" value="n" name="pub">
						<span class="small">�������� �ʴ� ��� �ڵ����� ����ó�� �˴ϴ�.</span></td>
				</tr>
				<tr>
					<th>author</th>
					<td><input type="text" name="author" id="author" placeholder="�۾��̸� �Է��� �ֽʽÿ�"></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" id="title" placeholder="������ �Է��� �ֽʽÿ�"></td>
				</tr>

				<tr>
					<td colspan="2"><textarea name="content" id="content" class="bcontent"></textarea></td>
				</tr>
			</table>
	</div>

	<div class="btnGroup">
		<a class="btn darkGray underTable" href="boardList">cancel</a>
		<button class="btn yellow" type="submit">OK</button>
	</div>
		</form>
</body>
</html>