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
		var cke = CKEDITOR.instances['content'];
		var title = $("#title");
		title.focus();		

 		var con = "${board.content}";
		cke.setData(con); 
 		
		cke.on("instanceReady", function(event) {
 		 cke.on('key', function(e) { 	
 			 textCount();
 				var deleteKey = 46;
 				var backspaceKey = 8;
 				var keyCode = e.data.keyCode;
 				if (keyCode === deleteKey || keyCode === backspaceKey) {
 					return true;
 				} else {
 					//var str = cke.getData();
 					if ( cke.getData().length > 2200){
 						alert("내용이 너무 깁니다")
 						return false;
 					}
 				}
 			});  		 
		}); 		 
 		 
 		 function textCount(){
 			$(".textCount").text(cke.getData().length+"/2200");
			 console.log(cke.getData().length);
 		 }
 		 
		// 공백 시 submit X
		$("form").on("submit", function(e) {
			$("#temp").val(cke.getData());
			if (title.val() == "") {
				alert("제목을 입력해 주십시오");
				title.focus();
				e.preventDefault();
			} else if (cke.getData() == "") {
				alert("내용을 입력해 주십시오");
				content.focus();
				e.preventDefault();
			} else if (cke.getData().length > 2200) {
				alert("내용이 너무 깁니다");
				e.preventDefault();
			}
		})

	})
</script>


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
					<td><input type="text" value="${board.title}" name="title" id="title" maxlength="30"></td>
				</tr>
				<tr>
					<td colspan="2"><textarea id="content" class="bcontent" maxlength="3000" value="${board.content}"></textarea></td>
				</tr>
								<tr>
				<td colspan="2">
					<p class="textCount alignR highlight"></p>
				</td></tr>
			</table>
		</div>

		<div class="btnGroup">
			<a href="boardView?bnum=${board.bnum}"><button type="button" class="btn darkGray">취소</button></a>
			<button class="btn mint" type="submit">완료</button>
		</div>
	</form>
