<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Relay: 게시글 수정</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/Relay/css/result_update.css">
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
<%	
	}
	else{
%>
		<%@ include file="/pages/include/header_afterlogin.jsp"%>
<%}
		%>
</head>
<body>
	<div class="container" id="main">
	    <div class="container">
		    <c:if test="${result eq 1}">
				<h3 style="text-align:center">게시글 <span class="blue">수정</span>이 <span class="blue">완료</span>되었습니다</h3>
				<br>
				<h4 style="text-align:center"><a href="boardList.do">게시판으로 이동</a></h4>
				<hr>
				<div class="row">
					<div class="image_set">
						<img class="rotate" src="https://img.icons8.com/color/180/rgb-circle-1.png" width="200" alt="milind kamthe"/>
					</div>
				</div>
			</c:if>
			<c:if test="${result eq 0}">
				<h3 style="text-align:center">게시글 <span class="red">수정</span>이 <span class="red">실패</span>하였습니다</h3>
				<br>
				<h4 style="text-align:center"><a href="javascript:history.back()">다시 입력</a></h4>
				<hr>
				<div class="row">
					<div class="image_set">
						<img class="rotate" src="https://img.icons8.com/color/180/rgb-circle-1.png" width="200" alt="milind kamthe"/>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<div class="footer">
	<%@ include file="/pages/include/footer.jsp"%>
	</div>
</body>

</html>