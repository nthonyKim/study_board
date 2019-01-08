<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#result {color: orange;}
#result2 {color: orange;}
</style>
<script type="text/javascript">
$(document).ready(function() {
				var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힝]/;
				var checkStrId = /^[A-Za-z0-9]{4,10}$/;
				var checkStrPw = /^[0-9]{4}$/;
				var userid = $("#userid");
				var passwd1 = $("#passwd1");
				var passwd2 = $("#passwd2");
				var username = $("#username");					
				
				//id 유효성
				$("#userid").on("keyup",  function () {
					if(!checkStrId.test(userid.val())) {
						$("#result").text('영문과 숫자 4~10자 이내로 입력하세요.');
					}else{					
					$.ajax({
						type : "GET",
						url : "idCheck",
						dataType : "text",
						data : {
							userid : $("#userid").val()
						},
						success : function(responseData, status, xhr) {
							if ($("#userid").val().length == 0) {
								$("#result").text("");
							} else {
								$("#result").text(responseData);
							};
						},
						error : function(xhr, status, error) {
							console.log(error);
						}
					});
					}
					
				})		
							
				//비밀번호 유효성
				$(passwd2).on("keyup", function() {	
					if (passwd2.val().length == 0) {
						$("#result2").text("");
					} else if (!checkStrPw.test(passwd1.val())) {
						$("#result2").text("비밀번호는 4글자의 숫자로 정해주세요.")
					} else if (passwd1.val() == passwd2.val()) {
						$("#result2").text("비밀번호 일치")
					} else {
						$("#result2").text("비밀번호 불일치")
					}					
				});
				
				//passwd1을 다시 수정했을 때
				$(passwd1).on("keyup", function() {		
					if (passwd2.val().length == 0) {
						$("#result2").text("");
					} else if (!checkStrPw.test(passwd1.val())) {
						$("#result2").text("비밀번호는 4글자의 숫자로 정해주세요.")
					} else if (passwd1.val() == passwd2.val()) {
						$("#result2").text("비밀번호 일치")
					} else {
						$("#result2").text("비밀번호 불일치")
					}
				});

				//form submit
				$("form").on("submit", function(e) {
					console.log(username.val().length)
									if (userid.val() == "") {
										alert("아이디는 필수입력 사항입니다.");
										userid.focus();
										return false;
									} else if (passwd1.val() == "") {
										alert("비밀번호는 필수입력 사항입니다.");
										passwd1.focus();
										return false;
									} else if (passwd2.val() == "") {
										alert("비밀번호를 확인해주세요");
										passwd2.focus();
										return false;
									} else if (username.val() == "") {
										alert("이름은 필수입력 사항입니다.");
										username.focus();
										return false;
									} else if ($("#result2").text() != "비밀번호 일치"
											|| $("#result").text() != "아이디 사용가능") {
										alert("아이디나 비밀번호를 확인해 주세요.")
										return false;
									} else if (passwd1.val() == userid.val()) {
										alert("아이디와 비밀번호가 같습니다.")
										passwd1.val()
										return false;
									} else if (passwd1.val().length<4 || passwd1.val().length>4) {
										alert("비밀번호는 4글자의 숫자로 정해주세요.")
										passwd1.focus()										
										return false;
									} else if (username.val().length<2 || username.val().length>10) {
										alert("이름이 너무 짧거나 깁니다.")
										username.focus()										
										return false;
									}
									return true;
								})				
			})
</script>
<body oncopy="return false" oncut="return false" onpaste="return false">
	<form action="memberInsert" method="post" name="f">
		<h1>REGISTER</h1>
		<div class="memberForm alignC">
			<!-- <p class="tblInfo"><span>*</span> 필수입력</p> -->
			<table class="tbl form">
				<colgroup>
					<col style="width: 30%">
					<col style="width: *">
				</colgroup>
				<tr>
					<th><span class="required" title="필수 입력">ID</span></th>
					<td><input type="text" name="userid" id="userid"> <span
						id="result" class="small bold"></span></td>
				</tr>
				<tr>
					<th><span class="required" title="필수 입력">PW</span></th>
					<td><input type="password" name="passwd" id="passwd1">
					</td>
				</tr>
				<tr>
					<th>PW CONFIRM</th>
					<td><input type="password" name="passwd2" id="passwd2">
						<span id="result2" class="small bold"></span></td>
				</tr>
				<tr>
					<th><span class="required" title="필수 입력">NAME</span></th>
					<td><input type="text" name="username" id="username"></td>
				</tr>
			</table>
			<div class="btnGroup alignC">
				<input type="reset" value="취소" class="btn gray"> 
				<input type="submit" value="회원가입" class="btn mint">
			</div>
		</div>
	</form>
</body>