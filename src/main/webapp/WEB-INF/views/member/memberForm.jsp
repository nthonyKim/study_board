<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#result {color: orange;}
#result2 {color: orange;}
</style>
<script type="text/javascript">
	$(function() {
				var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힝]/;
				var userid = $("#userid");
				var passwd1 = $("#passwd1");
				var passwd2 = $("#passwd2");
				var username = $("#username");
				//id 유효성
				$("#userid").on("keyup", function() {
									if (!(userid.val() >= '0' && userid.val() <= '9')
											&& !(userid.val() >= 'a' && userid.val() <= 'z')
											&& !(userid.val() >= 'A' && userid.val() <= 'Z')) {
										$("#result").text("아이디는 대소문자, 숫자만 입력가능합니다.")
									} else if (userid.val().indexOf(" ") >= 0) {
										$("#result").text("아이디에 공백을 사용할 수 없습니다.")
									} else if (check.test(userid.val())) {
										$("#result").text("아이디에 한글을 사용하실 수 없습니다")
									} else if (userid.val().length < 4 || userid.val().length > 10) {
										$("#result").text("아이디를 4~10자까지 입력해주세요.")
									} else {
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
									}//ajax
								})
				//비밀번호 유효성
				$("#passwd2").on("keyup", function() {
					var passwd = $("#passwd1").val();
					var passwd2 = $(this).val();

					if (passwd == passwd2) {
						$("#result2").text("비밀번호 일치")
					} else if (passwd2.length == 0) {
						$("#result2").text("");
					} else {
						$("#result2").text("비밀번호 불일치")
					}
					if (passwd.length<4 || passwd.length>4) {
						$("#result2").text("비밀번호는 4글자의 숫자로 정해주세요.")
					}
				});

				//form submit
				$("form").on("submit", function(e) {
									if (userid.val() == "") {
										alert("아이디는 필수입력 사항입니다.");
										userid.focus();
										e.preventDefault();
									} else if (passwd1.val() == "") {
										alert("비밀번호는 필수입력 사항입니다.");
										passwd1.focus();
										e.preventDefault();
									} else if (passwd2.val() == "") {
										alert("비밀번호를 확인해주세요");
										passwd2.focus();
										e.preventDefault();
									} else if (username.val() == "") {
										alert("이름은 필수입력 사항입니다.");
										username.focus();
										e.preventDefault();
									} else if ($("#result2").text() != "비밀번호 일치"
											|| $("#result").text() != "아이디 사용가능") {
										alert("아이디나 비밀번호를 확인해 주세요.")
										e.preventDefault();
									} else if (f.passwd1.value == f.userid.value) {
										alert("아이디와 비밀번호가 같습니다.")
										document.f.passwd1.focus()
										e.preventDefault();
									} else
									//비밀번호 길이 체크
									if (passwd1.val().length<4 || passwd1.val().length>4) {
										alert("비밀번호는 4글자의 숫자로 정해주세요.")
										document.f.passwd1.focus()
										document.f.passwd1.select()
										e.preventDefault();
									}
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