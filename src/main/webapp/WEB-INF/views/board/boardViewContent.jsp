<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		//수정
		$("#mod").on("click", function() {
			var num = $(this).attr("data-bnum");
			location.href = "loginCheck/boardUpdate?bnum=" + num;
		})
		//삭제
		$("#del").on("click", function(e) {
			var txt = confirm("삭제하시겠습니까?");
			if (txt == true) {
				var num = $(this).attr("data-bnum");
				location.href = "loginCheck/boardDelete?bnum=" + num;
			} else {
				e.preventDefault();
			}
		})
		//목록
		$("#list").on("click",	function(e) {
			var sea = "${searching.search}"
			var key = "${searching.keyWord}"
			var cup = "${page.currentPage}"
			if (sea == "" || key == "") {
				location.href = "boardList?currentPage=" + cup;
			} else {
				location.href = "boardList?search=" + sea + "&keyWord=" + key + "&currentPage=" + cup;
			}
		})

		//댓글 페이징				
		function cmtPaging(){
			var record = "${comment.totalCount}"
			var total = record / 24;
			var bnum = "${board.bnum}";

			if (record % 24 != 0) {
				total = Math.ceil(total)
			}
			;
			var curpage = $("#curpage").val();
			var paging = "";

			for (var i = 1; i <= total; i++) {
				if (i == curpage) {
					paging = paging + i + "&nbsp;&nbsp;";
				} else if (i % 10 == 0) {

				} else {
					paging = paging
							+ "<a href='/190101_board/boardView?bnum="
							+ bnum + "&cntCurPage=" + i + "'>" + i
							+ "</a>&nbsp;&nbsp;";
				}
			}
			$(".cmtPage").html(paging);
		}
		cmtPaging();
		
		//comment delete
		$(".cmtDel").on("click", function(e) {
			var cnum = $(this).attr("data-cnum");
			var txt = confirm("삭제하시겠습니까?");
			var temp = $(this);

			if (txt == true) {
				$.ajax({
					url : "loginCheck/commentDelete",
					type : "get",
					dataType : "text",
					data : {
						cnum : cnum
					},
					success : function(data, status, xhr) {
						if (data == "success") {
							$("#commentNum" + cnum).remove();
							//$("#comment").load(" #comment"); 											
						}
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});
			}
		})//

		//공백 시 submit X
		$("#cmtSub").on("submit", function(e) {
			var content = $("#content");
			if (content.val() == "") {
				alert("내용을 입력하세요");
				content.focus();
				e.preventDefault();
			}
		})

	})
</script>

<body>	
	<div>
		<div>
			<!-- 본문 -->
			<table class="tbl" border="1">
				<colgroup>
			<col style="width: 10%">
			<col style="width: *">
				</colgroup>
				<tr>
					<td><span class="small">${board.bnum}</span></td>
					<td><span><a class="alignC aLink bold" href="boardView?bnum=${board.bnum}">${board.title}</a></span></td>
				</tr>
				<tr>
					<td>
						<%-- <a class="aLink small" href="boardSearchAuthor?author=${board.author}">${board.author}</a> --%>
						${board.author}
					</td>
					<td class="alignR small">${board.readcnt}&nbsp;&nbsp;${board.regdate}</td>
				</tr>
				<tr>
					<td colspan="2">
						<%-- <div class="bcontent">${fn:escapeXml(board.content)}</div> --%>
						<div class="bcontent">
							<c:out value="${board.content}" escapeXml="false" />
						</div> <!-- 첨부파일 목록 --> <c:if test="${!empty file}">
							<div class="small alignR boxGray">
								첨부파일:
								<c:forEach var="img" items="${file}">
								<a class="aLink small" href="fileDown?fileName=${img.savName}">${img.oriName}</a>
									<br>
								</c:forEach>
							</div>
						</c:if>
					</td>
				</tr>

			</table>

			<!-- 댓글 (코멘트) -->
			<div id="commentContainer">
				<div id="comment underTable">
				<c:if test="${comment.totalCount > 0}">
					<p class="small bold" style="margin:20px;">댓글 ${comment.totalCount}</p>
				</c:if>
					<table class="tbl">
					<colgroup>
						<col style="width: 12%">
						<col style="width: *">
						<col style="width: 20%">
						<col style="width: 12%">
					</colgroup>
						<c:forEach var="cmt" items="${comment.list}">
							<tr id="commentNum${cmt.cnum}">
								<td>
								<span class="small">${cmt.author}</span></td>
								 <td><span><c:out value="${cmt.content}"/></span></td>
								<c:choose>
									<c:when test="${user.userid eq 'admin' || user.username eq cmt.author}">
										<td class="small alignR"> ${cmt.regdate}</td>
										<td class="alignR "><button id="cmtDel${cmt.cnum}" data-cnum="${cmt.cnum}" class="gray cmtDel">삭제</button></td>											
									</c:when>
									<c:otherwise>
										<td colspan="2" class="small alignR"> ${cmt.regdate}</td>
									</c:otherwise>
								</c:choose>
									
							</tr>
						</c:forEach>
					</table>

					<!-- 코멘트 페이징 -->
					<input type="hidden" value="${comment.currentPage}" id="curpage">
					<p class="underTable cmtPage"></p>
				</div>
			<!-- 코멘트 입력 -->

		<table class="tbl underTable">
			<colgroup>
				<col style="width: 12%">
				<col style="width: *">
				<col style="width: 10%">
			</colgroup>

			<tr>
				<form action="loginCheck/commentInsert" method="post" id="cmtSub">
					<input type="hidden" value="${board.bnum}" name="bnum">
					<td><input type="text" name="author" id="author" value="${user.username}" onfocus="this.blur()" readonly="readonly"></td>
					<td><c:choose>
							<c:when test="${empty user}">
								<input type="text" name="content" id="content" maxlength="600" placeholder="로그인이 필요한 서비스 입니다">
							</c:when>
							<c:otherwise>
								<input type="text" name="content" id="content" maxlength="600" placeholder="내용을 입력하세요">
							</c:otherwise>
						</c:choose></td>
					<td class="small alignR">
						<button class="mint" type="submit">완료</button>
					</td>
				</form>
			</tr>
		</table>
	</div>
		</div>

		<div class="btnGroup">
		<c:if test="${user.userid eq 'admin' || user.username eq board.author}">
			<a data-bnum="${board.bnum}" id="mod"><button class="btn gray">수정</button></a>
			<a data-bnum="${board.bnum}" id="del"><button class="btn gray">삭제</button></a>					
		</c:if>
			<a id="list"><button class="btn darkGray" >목록</button></a>
		</div>
	</div>
</body>
