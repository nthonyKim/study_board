<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		//수정
		$("#mod").on("click", function() {
			var num = $(this).attr("data-bnum");
			location.href = "boardUpdate?bnum=" + num;
		})
		//삭제
		$("#del").on("click", function(e) {
			var txt = confirm("삭제하시겠습니까?");
			if (txt == true) {
				var num = $(this).attr("data-bnum");
				location.href = "boardDelete?bnum=" + num;
			} else {
				e.preventDefault();
			}	
		})
		
		//댓글 페이징
		var record = $("#totalCount").val()
		var total = record / 8;
		var bnum = "${board.bnum}";

		if (record % 8 != 0)
			total = Math.ceil(total);
		console.log(total)
		var curpage = $("#curpage").val();
		var paging = "";

		for (var i = 1; i <= total; i++) {
			console.log(i);
			if (i == curpage) {
				paging = paging + i + "&nbsp;&nbsp;";
			} else {
				paging = paging
						+ "<a href='/190101_board/boardView?bnum="+bnum+"&cntCurPage="
						+ i + "'>" + i + "</a>&nbsp;&nbsp;";
			}
		}
		$("p").html(paging);
	
		//comment delete
		$(".cmtDel").on("click", function(e) {
			var cnum = $(this).attr("data-cnum");
			var txt = confirm("삭제하시겠습니까?");
			var temp = $(this);
			
			if (txt == true) {
				$.ajax({
					url : "commentDelete",
					type : "get",
					dataType : "text",
					data : {
						cnum : cnum
					},
					success : function(data, status, xhr) {
						if (data == "success") {
							console.log(xhr);
							 $("#comment").load(" #comment");						
							 /* $("#commentNum"+cnum).remove(); */
						}	
					},
					error : function(xhr, status, error) {						
						console.log(error);
					}
				});
			}
		})//
		
		//공백 시 submit X
		$("form").on("submit", function(e) {		
			var author = $("#author");
			var content = $("#content");
			if(author.val() == ""){
				alert("글쓴이를 입력해 주십시오");
				author.focus();
				e.preventDefault();
			}else if(content.val() == ""){
				alert("내용을 입력해 주십시오");
				content.focus();
				e.preventDefault();
			}
		})
		
		
	})
</script>

<body>
	<div>
	
	<!-- 본문 -->
		<table class="tbl" border="1">
			<tr>
				<td style="width: 10%"><span class="small">${board.bnum}</span></td>
				<td style="width: *"><span><a class="alignC aLink bold"
						href="boardView?bnum=${board.bnum}">${board.title}</a></span></td>
			</tr>
			<tr>
				<td>
				<%-- <a class="aLink small" href="boardSearchAuthor?author=${board.author}">${board.author}</a> --%>
				${board.author}
				</td>
				<td class="alignR small">${board.readcnt} ${board.regdate}</td>
			</tr>
			<tr>
				<td colspan="2">
	<!-- 엔터 치환 --> <%pageContext.setAttribute("br", "\n");%>
					<div class="bcontent">${fn:replace(board.content, br, "<br/>")}</div>
	<!-- 첨부파일 목록 -->
					<c:if test="${!empty file}">
						<div class="xsmall alignR boxGray">
							첨부파일:
							<c:forEach var="img" items="${file}">
							${img.oriName}<br>
							</c:forEach>
						</div>
					</c:if>
				</td>
			</tr>

		</table>
		
	<!-- 댓글 (코멘트) -->
		<div id="comment">
		<table class="tbl underTable">
			<c:forEach var="cmt" items="${comment.list}">
				<tr id="commentNum${cmt.cnum}">
					<td style="width: 12%" class="small">
						${cmt.author}</td>
					<td style="width: *">
						${cmt.content}</td>
					<td style="width: 10%" class="small alignC">
						${cmt.regdate}</td>
					<td style="width: 10%" class="small alignR">
						<button id="cmtDel${cmt.cnum}" data-cnum="${cmt.cnum}" class="gray cmtDel">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		</div>
	<!-- 코멘트 페이징 -->
		<input type="hidden" value="${comment.totalCount}" id="totalCount"> 
		<input type="hidden" value="${comment.currentPage}" id="curpage">
		<p class="underTable page"></p>
	<!-- 코멘트 입력 -->
		<table class="tbl underTable">
			<tr>
			<form action="commentInsert" method="get">
			<input type="hidden" value="${board.bnum}" name="bnum">
				<td style="width: 12%"><input type="text" name="author" id="author" placeholder="글쓴이를 입력하세요"></td>
				<td style="width: *"><input type="text" name="content" id="content" placeholder="내용을 입력하세요"></td>
				<td style="width: 10%" class="small alignR"><button class="mint" type="submit">완료</button></td>
				</form>
			</tr>
		</table>
	</div>

	<div class="btnGroup">
		<a class="btn gray underTable" data-bnum="${board.bnum}" id="mod">수정</a> 
		<a class="btn gray underTable" data-bnum="${board.bnum}" id="del">삭제</a>
		<a class="btn darkGray underTable" href="boardList">목록</a>
	</div>
</body>
</html>