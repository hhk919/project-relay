<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 게시글 등록</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="/Relay/css/result.css">
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
		    <c:if test="${!empty result}">
				<h3 style="text-align:center">게시글 <span class="blue">등록</span>이 <span class="blue">완료</span>되었습니다</h3>
				<br>
				<h4 style="text-align:center"><a href="boardList.do">게시판으로 이동</a></h4>
				<hr>
				<div class="row">
					<div class="image_set">
						<img class="rotate" src="https://img.icons8.com/color/180/rgb-circle-1.png" width="200" alt="milind kamthe"/>
					</div>
				</div>
			</c:if>
			<c:if test="${empty result}">
				<h3 style="text-align:center">게시글 <span class="red">등록</span>이 <span class="red">실패</span>하였습니다</h3>
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