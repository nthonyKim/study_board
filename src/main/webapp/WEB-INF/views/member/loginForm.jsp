<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(document).ready(function() {	
		//form submit
		$("form").on("submit", function(e){
			var userid = $("#userid");
			var passwd = $("#passwd");
				
			if(userid.val() == ""){
				alert("아이디는 필수입력 사항입니다.");
				userid.focus();
				e.preventDefault();
			}else if(passwd.val() == ""){
				alert("비밀번호는 필수입력 사항입니다.");
				passwd.focus();
				e.preventDefault();
			}
		})
	})
	
	var mesg = "${mesg}"
	console.log(mesg)
	if(mesg){
		alert(mesg);
	}
	</script>
	
	<c:if test="${!empty mesg}">
		<script type="text/javascript">
			alert("${mesg}");
		</script>
	</c:if>	

<h1>LOGIN</h1>
<div class="loginForm alignC">
<form action="login" method="post">
<table class="tbl form">
	<colgroup>
			<col style="width:30%">
			<col style="width:*">
	</colgroup>			
	<tr><th>ID</th><td><input type="text" name="userid" id="userid">
	</td></tr>	
	<tr><th>PW</th><td><input type="password" name="passwd" id="passwd">
	</td></tr>	
</table>
<div class="btnGroup alignC">
${mesg}
<a class="btn darkGray underTable" id="list" href="boardList">목록</a>
<input type="submit" value="로그인" class="btn mint alignC">
</div>
<div class="form underTable">
<!-- <a href="idFind" class="aLink">아이디 찾기</a> -->
<a href="memberForm" class="aLink small">회원가입</a><br><br>
</div>
</form>
</div>


