<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="css/common.css" />

<div class="topmenu">
	<ul>
		<li><a href="boardList" class="aLink alignL"><img
				src="images/icon/home.png" title="board"></a></li>
		<c:choose>
			<c:when test="${empty user}">
				<li><a href="loginForm"><img src="images/icon/users.png" title="user"></a></li>
			</c:when>
			<c:when test="${!empty user}">

				<li><a href="loginCheck/mypage"><img src="images/icon/user.png" title="mypage"></a></li>
				<li><a href="loginCheck/logout"><img src="images/icon/logout.png" title="logout"></a></li>
			</c:when>
		</c:choose>
	</ul>
</div>
