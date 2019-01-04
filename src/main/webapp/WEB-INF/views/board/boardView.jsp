<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {
		//����
		$("#mod").on("click", function() {
			var num = $(this).attr("data-bnum");
			location.href = "boardUpdate?bnum=" + num;
		})
		//����
		$("#del").on("click", function(e) {
			var txt = confirm("�����Ͻðڽ��ϱ�?");
			if (txt == true) {
				var num = $(this).attr("data-bnum");
				location.href = "boardDelete?bnum=" + num;
			} else {
				e.preventDefault();
			}	
		})
		
		//��� ����¡
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
		$(".cntDel").on("click", function(e) {
			var cnum = $(this).attr("data-cnum");
			var txt = confirm("�����Ͻðڽ��ϱ�?");
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
							console.log(data);
							/* temp.parents().filter("tr").remove();	 */
							 $("#comment").load(" #comment");
						}	
					},
					error : function(xhr, status, error) {						
						console.log(error);
					}
				});
			}else{
				e.preventDefault();					
			}
		})//
		
		//���� �� submit X
		$("form").on("submit", function(e) {		
			var author = $("#author");
			var content = $("#content");
			if(author.val() == ""){
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
	<div>
	
	<!-- ���� -->
		<table class="tbl" border="1">
			<tr>
				<td style="width: 10%"><span class="small">${board.bnum}</span></td>
				<td style="width: *"><span><a class="alignC aLink bold"
						href="boardView?bnum=${board.bnum}">${board.title}</a></span></td>
			</tr>
			<tr>
				<td><a class="aLink small"
					href="boardSearchAuthor?author=${board.author}">${board.author}</a></td>
				<td class="alignR small">${board.readcnt} ${board.regdate}</td>
			</tr>
			<tr>
				<td colspan="2">
					<!-- ���� ġȯ --> <% pageContext.setAttribute("br", "\n"); %>
					<div class="bcontent">${fn:replace(board.content, br, "<br/>")}</div>
				</td>
			</tr>
		</table>
		
	<!-- ��� (�ڸ�Ʈ) -->
		<div id="comment">
		<table class="tbl underTable">
			<c:forEach var="cnt" items="${comment.list}">
				<tr>
					<td style="width: 12%" class="small">${cnt.author}</td>
					<td style="width: *">${cnt.content}</td>
					<td style="width: 10%" class="small alignC">${cnt.regdate}</td>
					<td style="width: 10%" class="small alignR">
						<button data-cnum="${cnt.cnum}" class="cntDel gray">����</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		</div>
	<!-- �ڸ�Ʈ ����¡ -->
		<input type="hidden" value="${comment.totalCount}" id="totalCount"> 
		<input type="hidden" value="${comment.currentPage}" id="curpage">
		<p class="underTable page">page</p>
	<!-- �ڸ�Ʈ �Է� -->
		<table class="tbl underTable">
			<tr>
			<form action="commentInsert" method="get">
			<input type="hidden" value="${board.bnum}" name="bnum">
				<td style="width: 12%"><input type="text" name="author" id="author"></td>
				<td style="width: *"><input type="text" name="content" id="content"></td>
				<td style="width: 10%" class="small alignR"><button class="mint" type="submit">�Ϸ�</button></td>
				</form>
			</tr>
		</table>
	</div>

	<div class="btnGroup">
		<a class="btn gray underTable" data-bnum="${board.bnum}" id="mod">����</a> 
		<a class="btn gray underTable" data-bnum="${board.bnum}" id="del">����</a>
		<a class="btn darkGray underTable" href="boardList">���</a>
	</div>
</body>
</html>