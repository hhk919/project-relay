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
<script>
		function onlyNumber(event){
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				return false;
		}
		function removeChar(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
	</script>
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
			상품 수정
			<form action="/Relay/updateAdmin.do" method="post">
				<c:if test="${!empty searchone}">
					<table style="margin-left: auto; margin-right: auto">

						<tr>
							<td align="left">Product No</td>
							<td align="left"><input type="text" name="pno" readonly="readonly"
								value="${searchone.pno}"></td>
						</tr>
						<tr>
							<td align="left">Product Name</td>
							<td align="left"><input type="text" name="pname"
								value="${searchone.pname}"></td>
						</tr>
						<tr>
							<td align="left">Highest Price</td>
							<td align="left"><input type="text" name="phprice"
								value="${searchone.phprice}"></td>
						</tr>
						<tr>
							<td align="left">Lowest Price</td>
							<td align="left"><input type="text" name="plprice"
								value="${searchone.plprice}"></td>
						</tr>
						<tr>
							<td align="left">Mall</td>
							<td align="left"><input type="text" name="pmall"
								value="${searchone.pmall}"></td>

						</tr>
						<tr>
							<td align="left">URL</td>
							<td align="left"><input type="text" name="pmallurl"
								value="${searchone.pmallurl}"></td>

						</tr>
						<tr>
							<td align="left">IMG</td>
							<td align="left"><input type="text" name="pimg"
								value="${searchone.pimg}"></td>

						</tr>
						<tr>
							<td>
								<input type="hidden" name="go" value="${go}">
							<td>
						</tr>
					</table>
				</c:if>
				<div style="padding-bottom: 30px;">

					<br> <input type="submit" value="수정완료" />
				</div>

			</form>
		</Section>
	</div>


	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>