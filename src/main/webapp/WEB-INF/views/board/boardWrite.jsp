<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		CKEDITOR.replace( 'content', {
		    cloudServices_tokenUrl: 'https://36786.cke-cs.com/token/dev/HY0uayu8EoHKkSwa8CGEP5NIdC6P42g2eLBSe1Y43TECGKHGPVkTe0Wh29Dp',
		    cloudServices_uploadUrl: 'https://36786.cke-cs.com/easyimage/upload/'
		} );
		
		//CKEDITOR.replace('content');
		var cke = CKEDITOR.instances['content'];
		 
 		 function textCount(){
			 var txtcnt = cke.getData().length+"/2200";
			$(".textCount").text(txtcnt);
			 console.log(cke.getData().length);
		 } 
		 cke.on("instanceReady", function(event) {
			 cke.on('key', function(e) {
				 textCount();
					var deleteKey = 46;
					var backspaceKey = 8;
					var keyCode = e.data.keyCode;
					if (keyCode === deleteKey || keyCode === backspaceKey) {
						return true;
					} else {
						var str = CKEDITOR.instances.content.getData();
						if (str.length > 2200){
							alert("내용이 너무 깁니다")
							return false;
						}
					}
			}); 
		 });
	 
		 $(":file").on("change", filesCheck);
	 
		var tf = true;
		function filesCheck(e) {
		    var files = e.target.files;
			console.log("파일",files);
			tf = true;
			for (let f of files) {
		    	if(f.type.match("image.*")) {
		            alert("이미지는 에디터에서 첨부해 주세요");
		            tf = false;
		        } else if (f.size > 10485760){
		        	alert("첨부파일의 사이즈가 너무 큽니다");
		        	tf = false;
		        }
			}
		}		

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
			} else if (cke.getData().length > 2200) {
				alert("내용이 너무 깁니다");
				e.preventDefault();
			} else if(tf == false){
				alert("첨부파일을 확인해 주세요");
				e.preventDefault();
			}

		})

	})
</script>

<body>
	<form action="loginCheck/boardWrite" method="post"
		enctype="multipart/form-data">
		<div>
			<table class="tbl" border="1">
				<tr>
					<th style="width: 10%">public</th>
					<td style="width: *" class="small">공개<input type="radio"
						value="y" checked="checked" name="pub"> 비공개<input
						type="radio" value="n" name="pub"> <span>선택하지 않는 경우
							자동으로 공개처리 됩니다.</span></td>
				</tr>
				<tr>
					<th>author</th>
					<td><input type="text" name="author" id="author"
						value="${user.username}" onfocus="this.blur()" readonly="readonly"></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" id="title"
						placeholder="제목을 입력하세요" maxlength="30"></td>
				</tr>

				<tr>
					<td colspan="2"><textarea name="content" id="content"
							class="bcontent" maxlength="3000"></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<p class="textCount alignR highlight"></p>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="file" name="theFile"
						multiple="multiple"></td>
				</tr>
			</table>
		</div>

		<div class="btnGroup">
			<a href="boardList"><button class="btn darkGray" type="button">취소</button></a>
			<button class="btn mint" type="submit">완료</button>
		</div>
	</form>

</body>
</html>