<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						

					})
</script>

<body>
	<div>
		<table class="tbl" border="1">
		
			<tr>
				<td style="width: 10%"><span class="small">${board.bnum}</span></td>
				<td style="width: *"><span><a class="alignC aLink bold" href="boardView?bnum=${board.bnum}">${board.title}</a></span></td>
			</tr>
			<tr>
				<td><a class="aLink small" href="boardSearch?author=${board.author}">${board.author}</a></td>
					<td class="alignR small">${board.readcnt} ${board.regdate}</td>
			</tr>
			<tr>
				<td colspan="2"><span class="bcontent">${board.content}</span></td>
			</tr>
		</table>
	</div>
	
	<div class="btnGroup">	
	<a class="btn darkGray underTable" href="boardList">list</a>
	</div>
</body>
</html>