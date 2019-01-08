<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	$(document).ready(function(){
	var mesg = "비밀번호 불일치";
		$("#passwd1").on("keyup", function() {
			if ($("#passwd2").val() == $(this).val()) {
				mesg = "비밀번호 일치"
			} else {
				mesg = "비밀번호 불일치" //git gg
			}
		})
		$("#passwd2").on("keyup", function() {
			if ($("#passwd1").val() == $(this).val()) {
				mesg = "비밀번호 일치"
			} else {
				mesg = "비밀번호 불일치"
			}

			$("#presult").text(mesg);

			if (passwd2.length == 0) {
				$("#presult").text("");
			}
		})

		$("form").on("submit", function(e) {
			if ($("#passwd2").val().length == 0 || mesg == "비밀번호 불일치") {
				alert("비밀번호를 한번 더 확인하세요.");
				$("#passwd2").focus();
				e.preventDefault();
			}
		})
	})
</script>
<h1>MY PAGE</h1>
<form action="loginCheck/memberUpdate" method="post">
	<table class="tbl form">
		<colgroup>
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<tr>
			<th>ID</th>
			<td><input type="text" value="${user.userid}" readonly="readonly" name="userid" onfocus="this.blur()"></td>
		</tr>
		<tr>
			<th>PW</th>
			<td><input type="password" name="passwd" id="passwd1" ></td>
		</tr>
		<tr>
			<th>PW CONFIRM</th>
			<td><input type="password" name="passwd2" id="passwd2"><span id="presult"></span></td>
		</tr>
		<tr>
			<th>NAME</th>
			<td><input type="text" value="${user.username}" readonly="readonly" name="username" onfocus="this.blur()"></td>
		</tr>
	</table>
	<div class="btnGroup alignC">
		<input type="submit" value="수정" class="btn mint"> 
		<a href="boardList" class="btn darkGray">취소</a>
	</div>
</form>