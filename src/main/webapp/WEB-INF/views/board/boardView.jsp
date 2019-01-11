<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<c:choose>
		<c:when test="${board.pub eq 'n'}">
			<c:choose>
				<c:when test="${user.userid eq 'admin' || user.username eq board.author}">
					<jsp:include page="boardViewContent.jsp" flush="true" />
				</c:when>
				<c:otherwise>
					<table class="tbl" border="1">
						<colgroup>
							<col style="width: 10%">
							<col style="width: *">
						</colgroup>
						<tr>
							<td><span class="">${board.bnum}</span></td>
							<td></td>
						</tr>
						<tr>
							<td>${board.author}</td>
							<td class="alignR">${board.readcnt}&nbsp;&nbsp;${board.regdate}</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="bcontent alignC">
									<span class="bold"><br><br>관리자와 작성자만 볼 수 있는 게시글 입니다.</span>
								</div> 
							</td>
						</tr>

					</table>				
					
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${board.pub eq 'y'}">
			<jsp:include page="boardViewContent.jsp" flush="true" />	
		</c:when>
	</c:choose>
		<c:if test="${!empty page}">
	<div id="bListContainer" style="margin-top: 100px;">
		<jsp:include page="boardList.jsp" flush="true" />
	</div>				
		</c:if>
