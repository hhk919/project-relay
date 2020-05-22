<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
@import url("/Relay/css/admin.css");
</style>
<%
	if (((MemberVO)session.getAttribute("vo1")).getMno() != 1)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
<%	
	}
	else{
%>
		
<%}
		%>
</head>
<body>
	<Header>
		<h1 align="left"><a href="/Relay/index.jsp">Relay</a> Admin</h1>
		<p style="text-align: center">
			<a href="/Relay/pages/adminMember/memberM.jsp">Member</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminProduct/productM.jsp">Products</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminBoard/boardM.jsp">Board</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminNotice/noticeM.jsp">Notice</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/login/loginout.jsp">Logout</a>
			&nbsp;&nbsp;
		</p>
	</Header>

	<Nav>
		<a href="/Relay/prdlistAdmin.do">|ProductList|</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="/Relay/pages/adminProduct/productMsearch.jsp">|ProductSearch|</a>
	</Nav>

	<div style="overflow: auto;">
		<Section>
			<c:if test="${!empty updated}">
				<div align="center">
					|&nbsp; ${updated.getPno()}번 상품&nbsp;|&nbsp; ${updated.getPname()}&nbsp;|<br>
					수정 완료<br>
					<a
						href="/Relay/prdsearchAdmin.do?go=${go}">Back</a>
				</div>
			</c:if>

			<c:if test="${empty updated}">
				<div align="center">
					수정 실패 <br> <a href="javascript:history.back()">다시 수정</a>
				</div>
			</c:if>
		</Section>
	</div>

	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>